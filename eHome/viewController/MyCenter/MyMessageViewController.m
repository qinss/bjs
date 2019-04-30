//
//  MyMessageViewController.m
//  eHome
//
//  Created by 秦世帅 on 2017/10/20.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import "MyMessageViewController.h"
#import "MyMessageViewModel.h"
#import "MessageModel.h"
#import "MyMessageViewCell.h"
@interface MyMessageViewController ()
    @property(nonatomic,strong) MyMessageViewModel *model;
    @property(nonatomic,strong) MyMessageViewCell *cell;
    @end

@implementation MyMessageViewController
    
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNavigationBar:@"我的消息"];
    self.model = [[MyMessageViewModel alloc] initWithDelegate:self ];
    [self creatTableView:CGRectMake(0, 0, ScreenWidth, ScreenHeight) ];
//    self.tableView.backgroundColor = [UIColor redColor];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MyMessageViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"myMessageViewCell"];
    self.cell = [self.tableView dequeueReusableCellWithIdentifier:@"myMessageViewCell"];
    
    
    
    @WeakObj(self);
    [self.tableView setRequest:^(NSInteger i){[selfWeak.model requestInfo:i];}];
    [self.model requestInfo:1];
    
    // Do any additional setup after loading the view.
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
    //    return 120;
    MessageModel *mesageModel = [self.model.dataArr objectAtIndex:indexPath.row];
    self.cell.lblContent.text = mesageModel.content;
    CGSize size = [self.cell.lblContent sizeThatFits:CGSizeMake(self.cell.lblContent.frame.size.width, MAXFLOAT)];
    if (size.height < 40) {
        return 100;
    }
    else{
        return  100 + (size.height - 40);
    }
}
    
    
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.model.dataArr.count;
//    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyMessageViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"myMessageViewCell"];
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"MyMessageViewCell" owner:self options:nil]lastObject];
    }
    MessageModel *commentModel = [self.model.dataArr objectAtIndex:indexPath.row];
    [cell makeCellWithModel:commentModel];
    return cell;
}
    @end
