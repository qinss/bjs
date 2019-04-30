//
//  CommonListViewController.m
//  eHome
//
//  Created by 秦世帅 on 2017/5/24.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import "CommonListViewController.h"
#import "CustomTableViewCell.h"
#import "CommonListViewModel.h"

@interface CommonListViewController()
@property(nonatomic,strong) CommonListViewModel *model;
@end

@implementation CommonListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.viewTitle;
    self.model = [[CommonListViewModel alloc] initWithDelegate:self];
    self.model.title = self.viewTitle;
    [self creatTableView:CGRectMake(0, 0, ScreenWidth, ScreenHeight -64 -49-48)];
    @WeakObj(self);
    [self.tableView setRequest:^(NSInteger i){[selfWeak.model requestInfo:i];}];
    [self.model requestInfo:1];
}


- (id)initWithTitle:(NSString *)title
{
    self = [super init];
    if(self != nil){
        self.viewTitle = title;
    }
    return self;
}

-(void)modelCallBack:(id)data tag:(NSInteger)tag{
    if (tag == tagGetInfoListSuccess){
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
    return 80;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.model.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CustomTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"customTableViewCell"];
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"CustomTableViewCell" owner:self options:nil]lastObject];
    }
    InfoModel *infoModel = [self.model.dataArr objectAtIndex:indexPath.row];
    [cell makeCellWithModel:infoModel];
    return cell;
}
@end
