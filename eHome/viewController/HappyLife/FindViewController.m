//
//  FindViewController.m
//  eHome
//
//  Created by 秦世帅 on 2017/5/26.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import "FindViewController.h"
#import "FindTableViewCell.h"
#import "FindviewModel.h"
#import "PhotoBroswerVC.h"
#import "PhotoCollectionView.h"
#import "AddDiscussViewController.h"
#import "DiscorveyModel.h"
#define lblDataHeight 30.0
#define lblContentHeight 40.0
#define lblButtonHeight 30.0
@interface FindViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, assign, getter = isVisiable) BOOL visiable;
@property (nonatomic, assign, getter = isSelf_adaption) BOOL self_adaption;
@property (nonatomic, strong) NSIndexPath* indexPath_cell;
@property(nonatomic,strong)FindTableViewCell *cell;
@property(nonatomic,strong)FindviewModel *model;

@property(nonatomic,strong) NSMutableArray *ifOpen;
//@property(nonatomic,strong) NSArray *height
@end

@implementation FindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.viewTitle;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.ifOpen = [[NSMutableArray alloc] initWithCapacity:1000];
    self.model = [[FindviewModel alloc] initWithDelegate:self];
    CGFloat tableHeight = ScreenHeight -64 -49-48;
    if ([self.viewTitle isEqualToString:@"我的微论坛"]) {
        tableHeight += 48;
    }
    self.model.title = self.viewTitle;
    [self creatTableView:CGRectMake(0, 0, ScreenWidth, tableHeight)];
    [self.tableView registerNib:[UINib nibWithNibName:@"FindTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"findTableViewCell"];
    self.cell = [self.tableView dequeueReusableCellWithIdentifier:@"findTableViewCell"];
    @WeakObj(self);
    [self.tableView setRequest:^(NSInteger i){[selfWeak.model requestInfo:i];}];
}
- (id)initWithTitle:(NSString *)title
{
    self = [super init];
    if(self != nil){
        self.viewTitle = title;
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
     [self.model requestInfo:1];
}
-(void)modelCallBack:(id)data tag:(NSInteger)tag{
    if (tag == tagGetListSuccess) {
      
        @WeakObj(self);
      
          [self.tableView endRefreshing];
//          [self updateHeightArr];
        [self.tableView requestWithData:data totalPage:selfWeak.model.totalPage dataArr:selfWeak.model.dataArr complemetBlock:^(){[selfWeak updateHeightArr];}];
        
        
    }
}
-(void)btnSearchTouchUpInside:(UIButton *)sender{
   
    FindTableViewCell *cell2 = (FindTableViewCell *)[[[sender superview] superview] superview];
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell2];
     FindTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    if ([sender.titleLabel.text  isEqual: @"查看全文"]) {
        [sender setTitle:@"收起全文" forState:UIControlStateNormal];
        [self.model.ifOpendic
         setValue:@(1) forKey: [NSString stringWithFormat:@"%ld",indexPath.row]];
        [self.tableView beginUpdates];
        NSInteger index = sender.tag - 2000;
        CGFloat height = [[self.model.heightArr objectAtIndex:index] floatValue];
        [UIView animateWithDuration:0.5
                         animations:^{
                             
//                             NSInteger a = sender.tag;
                          
//                             CGSize size = [self.cell.lblContent sizeThatFits:CGSizeMake(self.cell.lblContent.frame.size.width, MAXFLOAT)];
                             CGRect oldFrame = cell.frame;
//                             oldFrame.size.height = size.height;
                             oldFrame.size.height = height;
                             cell.frame = oldFrame;
                             cell.lblContent.frame = CGRectMake(cell.lblContent.frame.origin.x, cell.lblContent.frame.origin.y, cell.lblContent.frame.size.width, height);
                             
                         }completion:^(BOOL finish){
                             _visiable = YES;
                             
                         }];
        
        [UIView animateWithDuration:0.5 animations:^{
            
//             CGSize size = [self.cell.lblContent sizeThatFits:CGSizeMake(self.cell.lblContent.frame.size.width, MAXFLOAT)];
//            NSLog(@"rfrgs%@",size);
            
            sender.superview.frame = CGRectMake(sender.superview.frame.origin.x, sender.superview.frame.origin.y+height -lblContentHeight, sender.superview.frame.size.width, sender.superview.frame.size.height  );

        }];
        [self.tableView endUpdates];
    }
    else{
        [sender setTitle:@"查看全文" forState:UIControlStateNormal];
         [self.model.ifOpendic setValue:@(0) forKey: [NSString stringWithFormat:@"%ld",indexPath.row]];
        [UIView animateWithDuration:0.5
                         animations:^{
                         }completion:^(BOOL finish){
                             _visiable = NO;
                             _self_adaption = NO;
                             cell.lblContent.frame = CGRectMake(cell.lblContent.frame.origin.x, cell.lblContent.frame.origin.y, cell.lblContent.frame.size.width, lblContentHeight);
                             [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                         }];
        [UIView animateWithDuration:0.5 animations:^{
            CGSize size = [self.cell.lblContent sizeThatFits:CGSizeMake(self.cell.lblContent.frame.size.width, MAXFLOAT)];
            sender.superview.frame = CGRectMake(sender.superview.frame.origin.x, sender.superview.frame.origin.y-size.height+37 , sender.superview.frame.size.width, sender.superview.frame.size.height);
        }];
    }
}
-(void)updateHeightArr{
    
    for (int i = 0; i< self.model.dataArr.count; i++) {
        DiscorveyModel * model = [self.model.dataArr objectAtIndex:i];
        NSString *str = model.dis_content;
        self.cell.lblContent.text = str;
        CGSize size = [self.cell.lblContent sizeThatFits:CGSizeMake(self.cell.lblContent.frame.size.width, MAXFLOAT)];
        [self.model.heightArr setObject:@(size.height) atIndexedSubscript:i];
        
        NSArray *commentArr = model.commentArray;
        CGFloat height = 0;
        for (NSDictionary *dic in commentArr) {
            height += [self.model getLblCommentHeight:dic]+5;
        }
          [self.model.commentHeightArr setObject:@(height) atIndexedSubscript:i];
    }
}
/******************************************************************************
 *  TableViewDelegate Implementation
 ******************************************************************************/
#pragma mark -
#pragma mark TableViewDelegate Implementation
#pragma mark - tableView的代理方法

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    DiscorveyModel *model = [self.model.dataArr objectAtIndex:indexPath.row];
    NSArray *imageArr = [self.model getImageArr:model.dis_image];
    CGFloat photoViewHeight = [self photoViewHeight:imageArr.count];
   
    NSString *str = model.dis_content;
    self.cell.lblContent.text = str;
    
    NSInteger openState = [[self.model.ifOpendic objectForKey:[NSString stringWithFormat:@"%ld",indexPath.row]] integerValue];
      CGFloat contentHeight = [[self.model.heightArr objectAtIndex:indexPath.row] floatValue];
    
    CGFloat commentHeight = [[self.model.commentHeightArr objectAtIndex:indexPath.row] floatValue];
    if (openState == 1 && contentHeight> lblContentHeight) {

         return 30 + contentHeight+ photoViewHeight + lblDataHeight+lblButtonHeight+commentHeight;
    }
    else if(contentHeight < lblContentHeight){
       return 30 + lblContentHeight+ photoViewHeight + lblDataHeight+commentHeight;
    }
    else{
        return 30 + lblContentHeight+ photoViewHeight + lblDataHeight+lblButtonHeight+commentHeight;
    }
  
//    //如果是打开状态
//    // 如果是可打开状态
//    //如果是不可打开
//    if([[self.model.heightArr objectAtIndex:indexPath.row] floatValue]> lblContentHeight){
//        return 30 + lblContentHeight+ photoViewHeight + lblDataHeight;
//    }
//    else if (openState == 1)
//    {
//        return 30 + lblContentHeight+ photoViewHeight + lblDataHeight+lblButtonHeight;
//    }
//    else{
//        
//        return 30 + contentHeight+ photoViewHeight + lblDataHeight+lblButtonHeight;;
//
//    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.model.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger openState = [[self.model.ifOpendic objectForKey:[NSString stringWithFormat:@"%ld",indexPath.row]] integerValue];
       DiscorveyModel *model = [self.model.dataArr objectAtIndex:indexPath.row];
     NSArray *imageArr = [self.model getImageArr:model.dis_image];
    CGFloat photoViewHeight = [self photoViewHeight:imageArr.count];
    FindTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"findTableViewCell"];
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"FindTableViewCell" owner:self options:nil]lastObject];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.btnSearch.tag = 1000+indexPath.row;

    if (cell.viewContent != nil) {
        [cell.viewContent removeFromSuperview];
    }
    CGFloat height = [[self.model.heightArr objectAtIndex:indexPath.row] floatValue];
    Boolean updat = height>lblContentHeight? YES:NO;
    CGFloat contentHeight = photoViewHeight  + lblDataHeight;
    CGFloat buttonHeigt = lblButtonHeight;
    CGFloat lblRemarkHeight = lblContentHeight;
    CGFloat commentHeight =  [[self.model.commentHeightArr objectAtIndex:indexPath.row] floatValue];
    if (openState == 1) {
        lblRemarkHeight = [[self.model.heightArr objectAtIndex:indexPath.row] floatValue];
    }
    if (updat) {
        contentHeight += lblButtonHeight
        ;
    }
    else{
        buttonHeigt = 0;
    }
    
    cell.viewContent = [[ UIView alloc] initWithFrame:CGRectMake(55, 30+lblRemarkHeight, ScreenWidth -60, photoViewHeight + lblButtonHeight + lblDataHeight+commentHeight)];
    if (updat) {
        UIButton *btn =  [[ UIButton alloc] initWithFrame: CGRectMake(0, 0, 60, lblButtonHeight)];
        if (openState == 1) {
          [btn setTitle:@"收起全文" forState: UIControlStateNormal];
        }else{
        [btn setTitle:@"查看全文" forState: UIControlStateNormal];
        }
        [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnSearchTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = indexPath.row + 2000;
        btn.backgroundColor = [UIColor clearColor];
        [cell.viewContent addSubview:btn];
    }
   
    cell.viewContent.backgroundColor = [UIColor clearColor];
    [cell.contentView addSubview: cell.viewContent];
    
    
    PhotoCollectionView *collectionView = [[PhotoCollectionView alloc] initWithFrame:CGRectMake(0, buttonHeigt , ScreenWidth - 80, photoViewHeight)];
  
    collectionView.userInteractionEnabled = YES;
   
    collectionView.imageArr = imageArr;
    collectionView.viewPhotoBlock = ^(NSInteger index){
        [self networkImageShow:index imageArr:imageArr];
    };
    [collectionView reloadData];
//    collectionView.backgroundColor = [UIColor clearColor];
    [cell.viewContent addSubview:collectionView];
    UILabel *lblDate = [[UILabel alloc] initWithFrame:CGRectMake(0, buttonHeigt+ photoViewHeight , 200, lblDataHeight)];
    
    lblDate.font = [UIFont systemFontOfSize:12];
    lblDate.text  = [GlobalVariables unixTimeToBeiJingTime:@"yyyy-MM-dd hh:mm:ss" unixtime:model.dis_date/1000];
    lblDate.textColor = [UIColor lightGrayColor];
    cell.lblContent.text = model.dis_content;
    cell.lblName.text = model.name;
    
    [cell.viewContent addSubview:lblDate];
    UIButton *btnDiscuss = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth-100, buttonHeigt+photoViewHeight+5, 30, 20) ];
    [btnDiscuss setImage:[UIImage imageNamed:@"icon_suggestion"] forState:UIControlStateNormal];
    NSInteger discussId = model.dis_id;
    btnDiscuss.tag = discussId;
    [btnDiscuss addTarget:self action:@selector(addSuggestion:) forControlEvents:UIControlEventTouchUpInside];
    [cell.viewContent addSubview:btnDiscuss];
    CGFloat lblCommentY = buttonHeigt+photoViewHeight+lblDataHeight;
    NSArray *commentArr = model.commentArray;
    for (NSDictionary* dic in commentArr) {
        CGFloat height = [self.model getLblCommentHeight:dic];
        
        UILabel *lblComment = [[UILabel alloc] initWithFrame:CGRectMake(0, lblCommentY , ScreenWidth - 55 -30, height)];
//        NSString *string = [self.model getLblCommentString:dic];
        lblCommentY += height + 5;
        lblComment.font = [UIFont systemFontOfSize:lblCommentFont];
        lblComment.text = [self.model getLblCommentString:dic];
//        lblComment.backgroundColor = [UIColor blueColor];
        lblComment.numberOfLines = 0;
        [cell.viewContent addSubview:lblComment];
        
    }
    NSString *imgUrl = [NSString stringWithFormat:@"%@%@",DefaultUrl,model.image];
    [cell.img sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:[UIImage imageNamed:defaultHeaderImage]];
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
     [tableView deselectRowAtIndexPath:indexPath animated:YES];

    
    
}
-(void)addSuggestion:(UIButton *)sender{
//    NSInteger a = sender.tag;
    AddDiscussViewController *vc = [[AddDiscussViewController alloc] init];
    vc.info_id = sender.tag;
    vc.type = 0;
    [self.navigationController pushViewController:vc animated:YES];
    
    
    
    
}
-(void)networkImageShow:(NSUInteger)index
               imageArr:(NSArray *)imageArr{
    
      @WeakObj(self);
    
    [PhotoBroswerVC show:selfWeak type:PhotoBroswerVCTypeModal index:index photoModelBlock:^NSArray *{
        
        NSMutableArray *modelsM = [NSMutableArray arrayWithCapacity:imageArr.count];
        for (NSUInteger i = 0; i<imageArr.count; i++) {
            
            PhotoModel *pbModel=[[PhotoModel alloc] init];
            pbModel.mid = i + 1;
            //            pbModel.title = [NSString stringWithFormat:@"这是标题%@",@(i+1)];
            //            pbModel.desc = [NSString stringWithFormat:@"我是一段很长的描述文字我是一段很长的描述文字我是一段很长的描述文字我是一段很长的描述文字我是一段很长的描述文字我是一段很长的描述文字%@",@(i+1)];
            pbModel.image_HD_U = imageArr[i];
            //源frame
//            UIImageView *imageV =(UIImageView *) weakSelf.collectionView.subviews[i];
//            pbModel.sourceImageView = imageV;
//
            [modelsM addObject:pbModel];
        }
        return modelsM;
    }];
}
-(CGFloat)photoViewHeight:(NSInteger)count{
    NSInteger b = count/3;
    if (count % 3 > 0)
    {
        b++;
    }
 return ((ScreenWidth - 100)/3 +10) * b;
}
@end
