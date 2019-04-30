//
//  ActionDetailViewController.m
//  eHome
//
//  Created by 秦世帅 on 2017/10/18.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import "ActionDetailViewController.h"
#import "PassEnentTableViewCell.h"
#import "AddDiscussViewController.h"
#import "ActionDetailViewModel.h"
@interface ActionDetailViewController ()
@property(nonatomic,strong)PassEnentTableViewCell *cell;
@property(nonatomic,strong)ActionDetailViewModel *model;
@property(nonatomic,assign)CGFloat commentHeight;
@end

@implementation ActionDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNavigationBar:@"E起讨论"];
    self.model = [[ActionDetailViewModel alloc] initWithDelegate:self];

    [self creatTableViewWithStyle:CGRectMake(0, -30, ScreenWidth, ScreenHeight+30) style:UITableViewStyleGrouped];
//    self.tableView.backgroundColor = [UIColor redColor];
    [self.btnSupport setBackgroundImage:[UIImage imageNamed:@"icon_support_red"] forState:UIControlStateSelected];
    [self.btnSupport setBackgroundImage:[UIImage imageNamed:@"icon_support_gray"] forState:UIControlStateNormal];
    [self.tableView registerNib:[UINib nibWithNibName:@"PassEnentTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"passEnentTableViewCell"];
    self.cell = [self.tableView dequeueReusableCellWithIdentifier:@"passEnentTableViewCell"];
     NSString * datestr  = [GlobalVariables unixTimeToBeiJingTime:@"yyyy-MM-dd hh:mm" unixtime:self.actionModel.date/1000];
    self.lblDate.text = [NSString stringWithFormat:@"发表于:%@",datestr];
    
    [self.tableView removeFooterView];
    [self.tableView removeHeaderView];
}

-(void)viewWillAppear:(BOOL)animated{
    [self.model requestActionInfo:self.actionModel.action_id];
}
-(void)modelCallBack:(id)data tag:(NSInteger)tag{
    if (tagGetDetailSuccess == tag) {
        [self makeView];
        [self.tableView reloadData];
    }
    else if (tagChangeSupportSuccess == tag){
        
        self.btnSupport.selected = !self.btnSupport.selected;
        NSInteger count = [self.lblSupportCount.text integerValue];
        if (self.btnSupport.selected) {
            count ++;
            
        }
        else{
            count --;
        }
        self.lblSupportCount.text = [NSString stringWithFormat:@"%ld",(long)count];
    }
}
/******************************************************************************
 *  TableViewDelegate Implementation
 ******************************************************************************/
#pragma mark -
#pragma mark TableViewDelegate Implementation
#pragma mark - tableView的代理方法

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *str = self.actionModel.content;
    self.cell.lblContent.text = str;
    CGSize size = [self.cell.lblContent sizeThatFits:CGSizeMake(self.cell.lblContent.frame.size.width, MAXFLOAT)];
        return (ScreenWidth-60) * 11/20 + 40 + size.height;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return  self.commentHeight;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return  self.viewContent;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PassEnentTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"passEnentTableViewCell"];
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"PassEnentTableViewCell" owner:self options:nil]lastObject];
    }
    
    [cell.btnSuggestion addTarget:self action:@selector(pushViewController:animated:) forControlEvents:UIControlEventTouchUpInside];
    [cell makeCellWithModel:self.actionModel];
    
    NSString *str = self.actionModel.content;
    self.cell.lblContent.text = str;
    CGSize size = [self.cell.lblContent sizeThatFits:CGSizeMake(self.cell.lblContent.frame.size.width, MAXFLOAT)];
//    return (ScreenWidth-60) * 11/20 + 40 + size.height;
    
    self.cell.lblContent.size = size;
    
    
    return cell;
}
- (IBAction)btnSupportTouchUpInside:(UIButton *)sender {

    NSInteger status = 0;
    if (sender.selected) {
        status = 1;
    }
    [self.model changeSupport:status book_id:self.actionModel.action_id];


//    [self.model ]


}
- (IBAction)btnCommentTouchUpInside:(UIButton *)sender {
    AddDiscussViewController *vc = [[AddDiscussViewController alloc] init];
    vc.info_id = self.actionModel.action_id;
    vc.type = 1;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)makeView{
    self.btnSupport.selected = self.model.supportStatus;
    self.lblSupportCount.text = [NSString stringWithFormat:@"%ld",self.model.supportCount];
    self.lblCommentCount.text = [NSString stringWithFormat:@"%ld",self.model.commentCount];
    
     CGFloat lblCommentY = 50;
    for (NSDictionary* dic in self.model.commentList) {
        CGFloat height = [self.model getLblCommentHeight:dic];
        
        UILabel *lblComment = [[UILabel alloc] initWithFrame:CGRectMake(30, lblCommentY , ScreenWidth - 55 -30, height)];


        lblCommentY += height + 20;
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(30, lblCommentY - 10, ScreenWidth - 30, 1)];
        lineView.backgroundColor = [UIColor lightGrayColor];
        [self.viewContent addSubview:lineView];

        lblComment.font = [UIFont systemFontOfSize:lblCommentFont];
        lblComment.text = [self.model getLblCommentString:dic];
        //        lblComment.backgroundColor = [UIColor blueColor];
        lblComment.numberOfLines = 0;
        [self.viewContent addSubview:lblComment];
        self.commentHeight =lblCommentY ;
        
    }
    
    
}
@end
