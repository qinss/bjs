//
//  DiscussionViewController.m
//  eHome
//
//  Created by 秦世帅 on 2017/5/31.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import "DiscussionViewController.h"
#import "DiscussionTableViewCell.h"
#import "DiscussionViewModel.h"
@interface DiscussionViewController ()
@property (nonatomic,strong) DiscussionViewModel *model;
@property(nonatomic,strong) DiscussionTableViewCell *cell;

@end

@implementation DiscussionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNavigationBar:@"交流讨论"];
    self.model = [[DiscussionViewModel alloc] initWithDelegate:self];
    [self createView];
     [self.tableView registerNib:[UINib nibWithNibName:@"DiscussionTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"discussionTableViewCell"];
    self.cell = [self.tableView dequeueReusableCellWithIdentifier:@"discussionTableViewCell"];
}

-(void)createView{
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0,ScreenHeight - 45  , ScreenWidth, 45)];
    [btn setTitle:@"添加我的建议" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:btn];
    [self creatTableView:CGRectMake(0, 0, ScreenWidth, ScreenHeight -45)];
    @WeakObj(self);
    [self.tableView setRequest:^(NSInteger i){[selfWeak.model requestInfo:i];}];
    [self.model requestInfo:1];
}


-(void)modelCallBack:(id)data tag:(NSInteger)tag{
    if (tag == tagGetCommentListSuccess){
        [self.tableView endRefreshing];
        @WeakObj(self);
        [self.tableView requestWithData:data totalPage:selfWeak.model.totalPage dataArr:selfWeak.model.dataArr complemetBlock:nil];
    }
}
/******************************************************************************
 *  TableViewDelegate Implementation
 ******************************************************************************/
#pragma mark -
#pragma mark TableViewDelegate Implementation
#pragma mark - tableView的代理方法

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *str = [self.model.dataArr objectAtIndex:indexPath.row];
    self.cell.lblContent.text = str;
    CGSize size = [self.cell.lblContent sizeThatFits:CGSizeMake(self.cell.lblContent.frame.size.width, MAXFLOAT)];
    if (size.height >40) {
        return size.height + 60;
    }
    else{
    return 100;
    }
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.model.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DiscussionTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"discussionTableViewCell"];
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"DiscussionTableViewCell" owner:self options:nil]lastObject];
    }
    cell.lblContent.text = [self.model.dataArr objectAtIndex:indexPath.row];
    return cell;
}
@end
