//
//  PassEnentTableViewController.m
//  eHome
//
//  Created by 秦世帅 on 2017/6/2.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import "PassEnentTableViewController.h"
#import "PassEnentTableViewCell.h"
#import "DiscussionViewController.h"
#import "PassEnentTableViewModel.h"
#import "ActionModel.h"
#import "PassEnentTableViewCell.h"
#import "DiscussionViewController.h"
#import "ActionDetailViewController.h"
@interface PassEnentTableViewController ()
@property(nonatomic,strong) PassEnentTableViewModel *model;
@property(nonatomic,strong)PassEnentTableViewCell *cell;
@end

@implementation PassEnentTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"E起讨论";
    [self setUpNavigationBar:@"E起讨论"];
    self.model = [[PassEnentTableViewModel alloc] initWithDelegate:self];
    [self creatTableView:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64-48-49 )];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"PassEnentTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"passEnentTableViewCell"];
    self.cell = [self.tableView dequeueReusableCellWithIdentifier:@"passEnentTableViewCell"];
    
    
    
    @WeakObj(self);
    [self.tableView setRequest:^(NSInteger i){[selfWeak.model requestInfo:i];}];
    [self.model requestInfo:1];
}
-(void)modelCallBack:(id)data tag:(NSInteger)tag{
//    if (tag == tagGetBookListSuccess){
        [self.tableView endRefreshing];
        @WeakObj(self);
        [self.tableView requestWithData:data totalPage:selfWeak.model.totalPage dataArr:selfWeak.model.dataArr complemetBlock:nil];
//    }
}
/******************************************************************************
 *  TableViewDelegate Implementation
 ******************************************************************************/
#pragma mark -
#pragma mark TableViewDelegate Implementation
#pragma mark - tableView的代理方法

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ActionModel *actionModel = [self.model.dataArr objectAtIndex:indexPath.row];
    self.cell.lblContent.text = actionModel.content;
    CGSize size = [self.cell.lblContent sizeThatFits:CGSizeMake(self.cell.lblContent.frame.size.width, MAXFLOAT)];
    
    
    
    return (ScreenWidth-60) * 11/20 + 40 + size.height;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.model.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PassEnentTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"passEnentTableViewCell"];
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"PassEnentTableViewCell" owner:self options:nil]lastObject];
    }
    
    [cell.btnSuggestion addTarget:self action:@selector(pushViewController:animated:) forControlEvents:UIControlEventTouchUpInside];
    ActionModel *actionModel = [self.model.dataArr objectAtIndex:indexPath.row];
    [cell makeCellWithModel:actionModel];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     [tableView deselectRowAtIndexPath:indexPath animated:YES];
     ActionModel *actionModel = [self.model.dataArr objectAtIndex:indexPath.row];
    [self pushToDetailViewController:actionModel];
}
-(void)pushToDetailViewController:(ActionModel *) model{
    
    ActionDetailViewController *vc = [[ActionDetailViewController alloc] init];
    vc.actionModel = model;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
