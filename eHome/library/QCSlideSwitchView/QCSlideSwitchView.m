//
//  QCSlideSwitchView.m
//  QCSliderTableView
//
//  Created by “ 邵鹏 on 14-4-16.
//  Copyright (c) 2014年 Scasy. All rights reserved.
//


#import "QCSlideSwitchView.h"
#import "BaseDefine.h"
static const CGFloat kHeightOfTopScrollView = 44.0f;
static const CGFloat kWidthOfButtonMargin = 0.0f;
static const CGFloat kFontSizeOfTabButton = 13.0f;
static const NSUInteger kTagOfRightSideButton = 999;
//
static const CGFloat kFontSizeOfTabButtonSelect = 13.0f;
//

@implementation QCSlideSwitchView

#pragma mark - 初始化参数

- (void)initValues
{
    //设置默认颜色
    self.tabItemNormalColor =  NOSELECT_BLACK_COLOR;
    self.tabItemSelectedColor = SELECT_RED_COLOR;
    
    //设置topScrollView的宽度
    self.topScrollViewWidth = [[UIScreen mainScreen] bounds].size.width;
    // 设置topScrollView按钮字体大小
    _topFontSizeOfTabButton = kFontSizeOfTabButton;
    // add by qinss start
    _topFontSizeOfTabButtonSelect = kFontSizeOfTabButtonSelect;
    // add by qinss end
    
    //创建顶部可滑动的tab
    _topScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, kHeightOfTopScrollView)];
    _topScrollView.delegate = self;
    _topScrollView.backgroundColor = [UIColor clearColor];
    _topScrollView.pagingEnabled = NO;
    _topScrollView.showsHorizontalScrollIndicator = NO;
    _topScrollView.showsVerticalScrollIndicator = NO;
    _topScrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self addSubview:_topScrollView];
    _userSelectedChannelID = 100;

    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, kHeightOfTopScrollView, self.frame.size.width, 1)];
    line.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    line.backgroundColor = SELECT_RED_COLOR;
    [self addSubview:line];
    
    //创建主滚动视图
    _rootScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kHeightOfTopScrollView, self.bounds.size.width, self.bounds.size.height - kHeightOfTopScrollView)];
    _rootScrollView.delegate = self;
    _rootScrollView.pagingEnabled = YES;
    _rootScrollView.userInteractionEnabled = YES;
    _rootScrollView.bounces = NO;
    _rootScrollView.showsHorizontalScrollIndicator = NO;
    _rootScrollView.showsVerticalScrollIndicator = NO;
    _rootScrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
    _userContentOffsetX = 0;
    [_rootScrollView.panGestureRecognizer addTarget:self action:@selector(scrollHandlePan:)];
    [self addSubview:_rootScrollView];
    
    _viewArray = [[NSMutableArray alloc] init];
    
    _isBuildUI = NO;
    
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initValues];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initValues];
    }
    return self;
}

#pragma mark getter/setter

- (void)setRigthSideButton:(UIButton *)rigthSideButton
{
    UIButton *button = (UIButton *)[self viewWithTag:kTagOfRightSideButton];
    [button removeFromSuperview];
    rigthSideButton.tag = kTagOfRightSideButton;
    _rigthSideButton = rigthSideButton;
    [self addSubview:_rigthSideButton];
    
}

- (void)setTopScrollViewWidth:(CGFloat)topScrollViewWidth
{
    _topScrollViewWidth = topScrollViewWidth;
}

- (void)setTopFontSizeOfTabButton:(CGFloat)topFontSizeOfTabButton
{
    _topFontSizeOfTabButton = topFontSizeOfTabButton;
}

#pragma mark - 创建控件

//当横竖屏切换时可通过此方法调整布局
- (void)layoutSubviews
{
    //创建完子视图UI才需要调整布局
    if (_isBuildUI) {
        //如果有设置右侧视图，缩小顶部滚动视图的宽度以适应按钮
        if (self.rigthSideButton.bounds.size.width > 0) {
            _rigthSideButton.frame = CGRectMake(self.bounds.size.width - self.rigthSideButton.bounds.size.width, 0,
                                                _rigthSideButton.bounds.size.width, _topScrollView.bounds.size.height);
            
            _topScrollView.frame = CGRectMake(0, 0,
                                              self.bounds.size.width - self.rigthSideButton.bounds.size.width, kHeightOfTopScrollView);
        }
        
        //更新主视图的总宽度
        _rootScrollView.contentSize = CGSizeMake(self.bounds.size.width * [_viewArray count], 0);
        
        //更新主视图各个子视图的宽度
        for (int i = 0; i < [_viewArray count]; i++) {
            UIViewController *listVC = _viewArray[i];
            listVC.view.frame = CGRectMake(0+_rootScrollView.bounds.size.width*i, 0,
                                           _rootScrollView.bounds.size.width, _rootScrollView.bounds.size.height);
        }
        
        //滚动到选中的视图
        [_rootScrollView setContentOffset:CGPointMake((_userSelectedChannelID - 100)*self.bounds.size.width, 0) animated:NO];
        
        //调整顶部滚动视图选中按钮位置
        UIButton *button = (UIButton *)[_topScrollView viewWithTag:_userSelectedChannelID];
        [self adjustScrollViewContentX:button];
    }
}

/*!
 * @method 创建子视图UI
 * @abstract
 * @discussion
 * @param
 * @result
 */
- (void)buildUI
{
    NSUInteger number = [self.slideSwitchViewDelegate numberOfTab:self];
    
    for (int i=0; i<number; i++) {
        UIViewController *vc = [self.slideSwitchViewDelegate slideSwitchView:self viewOfTab:i];
        [_viewArray addObject:vc];
        [_rootScrollView addSubview:vc.view];
        NSLog(@"%@",[vc.view class]);
    }
    
    [self createNameButtons];

    //选中第一个view
    if (self.slideSwitchViewDelegate && [self.slideSwitchViewDelegate respondsToSelector:@selector(slideSwitchView:didselectTab:)]) {
        [self.slideSwitchViewDelegate slideSwitchView:self didselectTab:_userSelectedChannelID - 100];
    }
    
    _isBuildUI = YES;
    
    //创建完子视图UI才需要调整布局
    [self setNeedsLayout];
}


/*!
 * @method 初始化顶部tab的各个按钮
 * @abstract
 * @discussion
 * @param
 * @result
 */
- (void)createNameButtons
{
    _shadowImageView = [[UIImageView alloc] init];
    [_shadowImageView setImage:_shadowImage];
    [_topScrollView addSubview:_shadowImageView];
    
    //顶部tabbar的总长度
    CGFloat topScrollViewContentWidth = 0;

    for (int i = 0; i < [_viewArray count]; i++) {
        UIViewController *vc = _viewArray[i];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        CGFloat btnWidth = self.topScrollViewWidth/(CGFloat)[_viewArray count];

       
        
        
        //累计每个tab文字的长度
        topScrollViewContentWidth += btnWidth;
        //设置按钮尺寸
        [button setFrame:CGRectMake(0+i*btnWidth, 0, btnWidth, kHeightOfTopScrollView)];
        [button setTag:i+100];
        [button setTitle:vc.title forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:_topFontSizeOfTabButton];
        [button setTitleColor:self.tabItemNormalColor forState:UIControlStateNormal];
        [button setTitleColor:self.tabItemSelectedColor forState:UIControlStateSelected];
//        [button setBackgroundImage:self.tabItemNormalBackgroundImage forState:UIControlStateNormal];
//        [button setBackgroundImage:self.tabItemSelectedBackgroundImage forState:UIControlStateSelected];
        [button addTarget:self action:@selector(selectNameButton:) forControlEvents:UIControlEventTouchUpInside];
        [_topScrollView addSubview:button];
//        [button setBackgroundColor:[UIColor redColor]];
        CGSize textSize = [vc.title sizeWithFont:[UIFont systemFontOfSize:_topFontSizeOfTabButton]
                               constrainedToSize:CGSizeMake(_topScrollView.bounds.size.width, kHeightOfTopScrollView)
                                   lineBreakMode:NSLineBreakByTruncatingTail];
        
        if (i == 0) {
            button.selected = YES;
            _bottomLine = [[UILabel alloc] initWithFrame:CGRectMake(button.center.x - (textSize.width)/2.0f, _topScrollView.frame.size.height - 3, textSize.width, 3)];
            _bottomLine.tag = button.tag;
            _bottomLine.backgroundColor = ColorRedColor;
            [_topScrollView addSubview: _bottomLine];

            
            
            // add by qinss start
             button.titleLabel.font = [UIFont systemFontOfSize:_topFontSizeOfTabButtonSelect];
            // add by qinss end
            
        }
        UIView *lineBottom = [[UIView alloc] initWithFrame:CGRectMake(0, _topScrollView.frame.size.height - 0.7, _topScrollView.frame.size.width, 0.7)];
        lineBottom.backgroundColor = RGBColor(190,190,190)
;
        [_topScrollView addSubview:lineBottom];

        //此处添加 按钮 点击 下啦菜单
        if (_showMenuArr.count > 0) {
            NSString *a = _showMenuArr[i];
            
            if ([a  isEqual: @"1"]) {
        
                
                UIImage *img = [UIImage imageNamed:@"expandableImage"];

                UIImageView *imgView = [[UIImageView alloc] init];
//                imgView.frame = CGRectMake(btnWidth * i + btnWidth - 10 - img.size.width, (btnWidth-img.size.height)/2, img.size.width, img.size.height);
                imgView.image = img;
//                imgView.frame =CGRectMake(btnWidth * i + btnWidth - 10 - img.size.width, (btnWidth-img.size.height)/2, img.size.width, img.size.height);
//                imgView.center = button.center;
                imgView.frame = CGRectMake(btnWidth*(i + 1) - 50,(kHeightOfTopScrollView-8)/2, 12, 8);
                imgView.tag = 999 + i;
              
               
                [_topScrollView insertSubview:imgView atIndex:999];
                
//                
//                UIView *vi = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 10)];
//                vi.backgroundColor = [UIColor redColor];
//                [_topScrollView addSubview:vi];
                
//                button.backgroundColor = [UIColor grayColor];
//                UIImage *img = [UIImage imageNamed:@"expandableImage"];
//                float padding = (btnWidth - (img.size.width + [vc.title sizeWithFont:[UIFont systemFontOfSize:_topFontSizeOfTabButton]].width)) / 2 +10;
//                 [button setImage:img forState:UIControlStateNormal];
//                  [button setImageEdgeInsets:UIEdgeInsetsMake(11, [vc.title sizeWithFont:[UIFont systemFontOfSize:_topFontSizeOfTabButton]].width + padding , 11, 0)];
            }
        }
        
        
        
    }

    //设置顶部滚动视图的内容总尺寸
    _topScrollView.contentSize = CGSizeMake(topScrollViewContentWidth, kHeightOfTopScrollView);
}


#pragma mark - 顶部滚动视图逻辑方法

/*!
 * @method 选中tab时间
 * @abstract
 * @discussion
 * @param 按钮
 * @result
 */
-(void)changeBtnShowMenuStatus:(NSInteger) i Rotation:(CGFloat)angle{
    
//    UIButton * btn = (UIButton *)[_topScrollView viewWithTag: i+100];

    [UIView animateWithDuration:0.1f animations:^{
        UIImageView * img = (UIImageView *)[_topScrollView viewWithTag: i+999];

//        if (angle == 0) {
//            [btn setBackgroundColor:[UIColor whiteColor]];
//        } else {
//            [btn setBackgroundColor:[UIColor colorWithRed:(221.0/255.0) green:(221.0/255.0) blue:(221.0/255.0) alpha:1.0f]];
//        }
        img.transform = CGAffineTransformMakeRotation(angle);
    }];

    
}
-(void)changeSelectButton:(NSInteger) i
{
    UIButton * btn = (UIButton *)[_topScrollView viewWithTag: i+100];
    [self selectNameButton:btn];
}


- (void)selectNameButton:(UIButton *)sender
{
    
    //如果点击的tab文字显示不全，调整滚动视图x坐标使用使tab文字显示全
    [self adjustScrollViewContentX:sender];
    [self resignFirstResponder];
    [self endEditing:YES];
    
    NSLog(@"sender.selected====%d",sender.selected);
    NSLog(@"tag====%ld",(long)sender.tag);
    NSLog(@"_userSelectedChannelID====%ld",(long)_userSelectedChannelID);
//    NSLog(@"_isRootScroll====%ld",(long)_isRootScroll);
    
    // add by qinss start
    sender.titleLabel.font = [UIFont systemFontOfSize:_topFontSizeOfTabButtonSelect];

    // add by qinss end

    //如果更换按钮
    if (sender.tag != _userSelectedChannelID) {
        //取之前的按钮
        UIButton *lastButton = (UIButton *)[_topScrollView viewWithTag:_userSelectedChannelID];
        lastButton.selected = NO;
        // add by qinss start
         lastButton.titleLabel.font = [UIFont systemFontOfSize:_topFontSizeOfTabButton];
        // add by qinss end
        //赋值按钮ID
        _userSelectedChannelID = sender.tag;
    }
    else //没有 更换按钮 
    {
        if(self.complettionBlock){
            self.complettionBlock(sender.tag);
        }
    }
    
    //按钮选中状态
    if (!sender.selected) {
        sender.selected = YES;
        
        
        [UIView animateWithDuration:0.3 animations:^
         {
             _bottomLine.centerX = sender.centerX;
 
         }];
//        for (UIView *view in _topScrollView.subviews) {
//            if ([view isKindOfClass:[UILabel class]]) {
//                if (view.tag == sender.tag) {
//                    view.backgroundColor = ColorOrangeColor;
//                } else {
//                    view.backgroundColor = [UIColor redColor];
//                }
//            }
//        }
        [UIView animateWithDuration:0.1 animations:^{
            
            [_shadowImageView setFrame:CGRectMake(sender.frame.origin.x, 0, sender.frame.size.width, _shadowImage.size.height)];
            
        } completion:^(BOOL finished) {
            if (finished) {
                //设置新页出现
//                if (!_isRootScroll) {
                    [_rootScrollView setContentOffset:CGPointMake((sender.tag - 100)*self.bounds.size.width, 0) animated:YES];
//                }
//                _isRootScroll = NO;
                
                if (self.slideSwitchViewDelegate && [self.slideSwitchViewDelegate respondsToSelector:@selector(slideSwitchView:didselectTab:)]) {
                    [self.slideSwitchViewDelegate slideSwitchView:self didselectTab:_userSelectedChannelID - 100];
                }
            }
        }];
        
    }
    //重复点击选中按钮
    else {
        
    }
}

/*!
 * @method 调整顶部滚动视图x位置
 * @abstract
 * @discussion
 * @param
 * @result
 */
- (void)adjustScrollViewContentX:(UIButton *)sender
{
    //如果 当前显示的最后一个tab文字超出右边界
    if (sender.frame.origin.x - _topScrollView.contentOffset.x > self.bounds.size.width - (kWidthOfButtonMargin+sender.bounds.size.width)) {
        //向左滚动视图，显示完整tab文字
        [_topScrollView setContentOffset:CGPointMake(sender.frame.origin.x - (_topScrollView.bounds.size.width- (kWidthOfButtonMargin+sender.bounds.size.width)), 0)  animated:YES];
    }
    
    //如果 （tab的文字坐标 - 当前滚动视图左边界所在整个视图的x坐标） < 按钮的隔间 ，代表tab文字已超出边界
    if (sender.frame.origin.x - _topScrollView.contentOffset.x < kWidthOfButtonMargin) {
        //向右滚动视图（tab文字的x坐标 - 按钮间隔 = 新的滚动视图左边界在整个视图的x坐标），使文字显示完整
        [_topScrollView setContentOffset:CGPointMake(sender.frame.origin.x - kWidthOfButtonMargin, 0)  animated:YES];
    }
}

#pragma mark 主视图逻辑方法

//滚动视图开始时
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (scrollView == _rootScrollView) {
        _userContentOffsetX = scrollView.contentOffset.x;
    }
}

//滚动视图结束
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == _rootScrollView) {
        //判断用户是否左滚动还是右滚动
        if (_userContentOffsetX < scrollView.contentOffset.x) {
            _isLeftScroll = YES;
        }
        else {
            _isLeftScroll = NO;
        }
    }
}

//滚动视图释放滚动
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == _rootScrollView) {
//        _isRootScroll = YES;
        //调整顶部滑条按钮状态
        int tag = (int)scrollView.contentOffset.x/self.bounds.size.width +100;
        UIButton *button = (UIButton *)[_topScrollView viewWithTag:tag];
        [self selectNameButton:button];
    }
}

//传递滑动事件给下一层
-(void)scrollHandlePan:(UIPanGestureRecognizer*) panParam
{
    //当滑道左边界时，传递滑动事件给代理
    if(_rootScrollView.contentOffset.x <= 0) {
        if (self.slideSwitchViewDelegate
            && [self.slideSwitchViewDelegate respondsToSelector:@selector(slideSwitchView:panLeftEdge:)]) {
            [self.slideSwitchViewDelegate slideSwitchView:self panLeftEdge:panParam];
        }
    } else if(_rootScrollView.contentOffset.x >= _rootScrollView.contentSize.width - _rootScrollView.bounds.size.width) {
        if (self.slideSwitchViewDelegate
            && [self.slideSwitchViewDelegate respondsToSelector:@selector(slideSwitchView:panRightEdge:)]) {
            [self.slideSwitchViewDelegate slideSwitchView:self panRightEdge:panParam];
        }
    }
}

#pragma mark - 工具方法

/*!
 * @method 通过16进制计算颜色
 * @abstract
 * @discussion
 * @param 16机制
 * @result 颜色对象
 */
+ (UIColor *)colorFromHexRGB:(NSString *)inColorString
{
    unsigned int red,green,blue;
    NSRange range;
    range.length = 2;
    
    range.location = 0;
    [[NSScanner scannerWithString:[inColorString substringWithRange:range]] scanHexInt:&red];
    
    range.location = 2;
    [[NSScanner scannerWithString:[inColorString substringWithRange:range]] scanHexInt:&green];
    
    range.location = 4;
    [[NSScanner scannerWithString:[inColorString substringWithRange:range]] scanHexInt:&blue];
    
    return [UIColor colorWithRed:(float)(red/255.0f) green:(float)(green / 255.0f) blue:(float)(blue / 255.0f) alpha:1.0f];
}

@end

