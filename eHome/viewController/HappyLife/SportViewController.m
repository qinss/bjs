//
//  SportViewController.m
//  eHome
//
//  Created by 秦世帅 on 2017/5/26.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import "SportViewController.h"
#import "FindViewController.h"
#import "DayRankingTableViewCell.h"
#import "RankingListViewController.h"
#import "SportViewModel.h"
@interface SportViewController()
@property(nonatomic,strong) RankingListViewController *rankingListViewController;
@property(nonatomic,strong) SportViewModel *model;
@end

@implementation SportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"运动了没";
    self.model = [[SportViewModel alloc] initWithDelegate:self];
    [self creatTableView:CGRectMake(0, 50, ScreenWidth, ScreenHeight-64-49-50-48)];
    [self.tableView removeFooterView];
    @WeakObj(self);
    [self.tableView setRequest:^(NSInteger i){[selfWeak.model requestInfo];}];
    [self.model requestInfo];
}

-(void)modelCallBack:(id)data tag:(NSInteger)tag{
    if (tag == tagGetRankingListSuccess) {
        
  @WeakObj(self);
        [self.tableView endRefreshing];
        [self.tableView requestWithData:data totalPage:1 dataArr:selfWeak.model.dataArr complemetBlock:nil];
}
}
/******************************************************************************
 *  TableViewDelegate Implementation
 ******************************************************************************/
#pragma mark -
#pragma mark TableViewDelegate Implementation
#pragma mark - tableView的代理方法

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.model.dataArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DayRankingTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"dayRankingTableViewCell"];
    if (cell == nil) 
    {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"DayRankingTableViewCell" owner:self options:nil]lastObject];
    }
    
    NSDictionary *dic = [self.model.dataArr objectAtIndex:indexPath.row];
    
    [cell makeCellWithDic:dic];
      return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self pushToRankingListViewController:indexPath.row];
}
-(void)pushToRankingListViewController:(NSInteger)index{
        RankingListViewController *vc = [[RankingListViewController alloc] init];
    vc.dataDic = [self.model.dataArr objectAtIndex:index];
    
    [self.navigationController pushViewController:vc animated:YES];
}
@end
