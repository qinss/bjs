//
//  BookDetailViewController.m
//  eHome
//
//  Created by 秦世帅 on 2017/6/1.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import "BookDetailViewController.h"
#import "BookDiscussViewController.h"
#import "BookDetailViewModel.h"
#import "CommonModel.h"

@interface BookDetailViewController ()
@property(nonatomic,strong) BookDetailViewModel *model;
@end

@implementation BookDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNavigationBar:@"详情"];
  
    [self.btnSave setBackgroundImage:[UIImage imageNamed:@"icon_save_red"] forState:UIControlStateSelected];
    [self.btnSave setBackgroundImage:[UIImage imageNamed:@"icon_save_gray"] forState:UIControlStateNormal];
    
    [self.btnSupport setBackgroundImage:[UIImage imageNamed:@"icon_support_red"] forState:UIControlStateSelected];
    [self.btnSupport setBackgroundImage:[UIImage imageNamed:@"icon_support_gray"] forState:UIControlStateNormal];
    
    self.model = [[BookDetailViewModel alloc] initWithDelegate:self];
    self.btnSave.selected = NO;
    self.btnSupport.selected = NO;
    [self creatScrollView];
    
    self.lblName.text = self.bookModel.name;
    self.lblAuthor.text = self.bookModel.author;
    self.lblPress.text = self.bookModel.press;
    
    self.lblData.text = [GlobalVariables unixTimeToBeiJingTime:@"yyyy-MM-dd" unixtime:self.bookModel.publication_date/1000];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",DefaultUrl,self.bookModel.image];
    [self.imgBook sd_setImageWithURL:[NSURL URLWithString: url]];
    
    
    [self.model requestBookInfo:self.bookModel.book_id];
}

-(void)creatScrollView{
    CGFloat baseHeight = 0;
    for (int i = 0; i<3; i++) {
    UIView * line1 =  [[UIView alloc] initWithFrame:CGRectMake(0, baseHeight, ScreenWidth, 1)];
    line1.backgroundColor = [UIColor lightGrayColor];
    [self.scrollView addSubview:line1];
    UILabel *lblTitle1 = [[UILabel alloc] initWithFrame:CGRectMake(20, baseHeight + 10, 200, 20)];
    lblTitle1.textColor = [UIColor blackColor];
    lblTitle1.text = @"【简介】";
    [self.scrollView addSubview:lblTitle1];
    UILabel *lblContent = [[UILabel alloc] initWithFrame:CGRectMake(20, baseHeight+40, ScreenWidth - 40, 20)];
        lblContent.numberOfLines = 0;
        lblContent.font = [UIFont systemFontOfSize:16];
        switch (i) {
            case 0:
                lblTitle1.text = @"【简介】";
                lblContent.text = self.bookModel.blurb;
                break;
            case 1:
                 lblTitle1.text = @"【推荐理由】";
                 lblContent.text = self.bookModel.reason;
                break;
            case 2:
                 lblTitle1.text = @"【精彩书评】";
                lblContent.text = self.bookModel.review;
                break;
            default:
                break;
        }
          CGSize size = [lblContent sizeThatFits:CGSizeMake(lblContent.frame.size.width, MAXFLOAT)];
        lblContent.frame = CGRectMake(lblContent.frame.origin.x, lblContent.origin.y, lblContent.frame.size.width, size.height);
        baseHeight += 40 + size.height + 10;
        [self.scrollView addSubview:lblContent];
        
    }
    self.scrollView.contentSize = CGSizeMake(ScreenWidth, baseHeight);
}


- (IBAction)btnSuggestionTouchUpInside:(UIButton *)sender {
    BookDiscussViewController *vc = [[BookDiscussViewController alloc] init];
    vc.book_id = [self.bookModel.book_id integerValue];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)btnSupportTouchUpInisde:(UIButton *)sender {
    NSInteger bookid = [self.bookModel.book_id integerValue];
    NSInteger status = 0;
    if (sender.selected) {
        status = 1;
    }
    [self.model changeSupport:status book_id:bookid];

}
- (IBAction)btnSaveTouchUpInside:(UIButton *)sender {
    NSInteger bookid = [self.bookModel.book_id integerValue];
    NSInteger status = 0;
    if (sender.selected) {
        status = 1;
    }
    [self.model changeCollection:status book_id:bookid];
}

-(void)modelCallBack:(id)data tag:(NSInteger)tag{
    if (tagGetInfoSuccess == tag) {
        [self changeView:data];
    }
    else if (tagChangeCollectionSuccess == tag){
        self.btnSave.selected = !self.btnSave.selected;
    }
    else if (tagChangeSupportSuccess == tag){
        self.btnSupport.selected = !self.btnSupport.selected;
       NSInteger count = [self.lblSupport.text integerValue];
        if (self.btnSupport.selected) {
            count ++;
            
        }
        else{
            count --;
        }
        self.lblSupport.text = [NSString stringWithFormat:@"%ld",(long)count];
        
        
    }
}
-(void)changeView:(CommonModel *)model{
    self.lblSupport.text =  [NSString stringWithFormat:@"%ld",(long)model.supportCount];
    self.lblSuggestion.text = [NSString stringWithFormat:@"%ld",model.commentCount];
    if (model.collectionStatus > 0) {
        self.btnSave.selected = YES;
    }
    self.btnSupport.selected = model.supportStatus;
}

@end
