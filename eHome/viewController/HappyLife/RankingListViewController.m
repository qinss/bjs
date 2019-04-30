//
//  RankingListViewController.m
//  eHome
//
//  Created by 秦世帅 on 2017/5/27.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import "RankingListViewController.h"
#import "SetpTableViewCell.h"
#import "RankingListViewModel.h"
#import "StepModel.h"
@interface RankingListViewController ()
@property(nonatomic,strong) RankingListViewModel *model;
@end

@implementation RankingListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNavigationBar:@"乐生活"];
     [self creatTableView:CGRectMake(0,154, ScreenWidth, ScreenHeight -154)];
    self.model = [[RankingListViewModel alloc] initWithDelegate:self];
    @WeakObj(self);
    NSInteger ranking = [[self.dataDic objectForKey:@"number"] integerValue];
    self.lblRanking.text = [NSString stringWithFormat:@"%ld",ranking];
    NSInteger step = [[self.dataDic objectForKey:@"step"] integerValue];
    self.lblStep.text = [NSString stringWithFormat:@"%ld步",step];
    NSInteger supportCount = [[self.dataDic objectForKey:@"supportcount"] integerValue];
    self.LblSupportCount.text = [NSString stringWithFormat:@"%ld",supportCount];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",DefaultUrl,[GlobalVariables shareGlobalVariables].currentUser.image];
    [self.imgHeaderView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:defaultHeaderImage]];
    self.lblName.text = [GlobalVariables shareGlobalVariables].currentUser.name;
    
    [self.tableView setRequest:^(NSInteger i){
        [selfWeak.model requestInfo:i date:[selfWeak.dataDic objectForKey:@"date"]];
    }];
    [self.model requestInfo:1 date:[self.dataDic objectForKey:@"date"]];
    
}
-(void)modelCallBack:(id)data tag:(NSInteger)tag{
    if (tag == tagGetListSuccess) {
        
        @WeakObj(self);
        
        [self.tableView endRefreshing];
        [self.tableView requestWithData:data totalPage:selfWeak.model.totalPage dataArr:selfWeak.model.dataArr complemetBlock:nil];
    }
    else if (tag == tagAddSupportSuccess)
    {
        NSInteger buttonTag = [data integerValue];
        UILabel *lblSupport = (UILabel *)[self.view viewWithTag:buttonTag + 1000];
        NSString *oldCount = lblSupport.text;
        lblSupport.text = [NSString stringWithFormat:@"%ld", [oldCount integerValue]+1];
        UIButton *button = (UIButton *)[self.view viewWithTag:buttonTag ];
        button.selected = YES;
        
    }
}

/******************************************************************************
 *  TableViewDelegate Implementation
 ******************************************************************************/
#pragma mark -
#pragma mark TableViewDelegate Implementation
#pragma mark - tableView的代理方法

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.model.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SetpTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"setpTableViewCell"];
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"SetpTableViewCell" owner:self options:nil]lastObject];
    }
    StepModel *model = [self.model.dataArr objectAtIndex:indexPath.row];
    cell.btnSupport.tag = model.step_id;
    
    cell.lblSupportCount.tag = model.step_id + 1000;
    [cell.btnSupport addTarget:self action:@selector(btnSupport:) forControlEvents:UIControlEventTouchUpInside];
    [cell makeCellWithDic:model];
    return cell;
}
-(void)btnSupport:(UIButton *)button{
    if (!button.selected) {
        
//        if (<#condition#>) {
//            <#statements#>
//        }
        
        [self.model requestAddSupport:button.tag];
    }
    
}

@end
