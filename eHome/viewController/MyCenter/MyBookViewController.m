//
//  MyBookViewController.m
//  eHome
//
//  Created by 秦世帅 on 2017/10/16.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import "MyBookViewController.h"
#import "ReadingTableViewCell.h"
#import "BookDetailViewController.h"
#import "ReadingViewModel.h"
#import "MyBookViewModel.h"
@interface MyBookViewController ()
@property(nonatomic,strong) MyBookViewModel *model;
@end

@implementation MyBookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.viewTitle;
    // Do any additional setup after loading the view from its nib.
    self.model = [[MyBookViewModel alloc] initWithDelegate:self];
    self.model.title = self.viewTitle;
    [self creatTableView:CGRectMake(0, 0, ScreenWidth, ScreenHeight -64 -49)];
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
    if (tag == tagGetBookListSuccess){
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
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat sectionHeaderHeight = 10;//设置你footer高度
    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.model.dataArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
    footerView.backgroundColor = ColorLightGray;
    return footerView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ReadingTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"readingTableViewCell"];
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"ReadingTableViewCell" owner:self options:nil]lastObject];
    }
    BookModel *bookModel = [self.model.dataArr objectAtIndex:indexPath.section];
    [cell makeCellWithModel:bookModel];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    BookModel *bookModel = [self.model.dataArr objectAtIndex:indexPath.section];
    [self pushToBookDetailViewController:bookModel];
    
}

-(void)pushToBookDetailViewController:(BookModel *) bookModel{
    
    BookDetailViewController *vc = [[BookDetailViewController alloc] init];
    
    vc.bookModel = bookModel;
    [self.navigationController pushViewController:vc animated:YES];
}
@end
