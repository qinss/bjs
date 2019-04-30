//
//  ReadingViewController.m
//  eHome
//
//  Created by 秦世帅 on 2017/5/31.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import "ReadingViewController.h"
#import "ReadingTableViewCell.h"
#import "BookDetailViewController.h"
#import "ReadingViewModel.h"

@interface ReadingViewController ()

@property(nonatomic,strong) ReadingViewModel *model;
@end

@implementation ReadingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"E起阅读";
    self.model = [[ReadingViewModel alloc] initWithDelegate:self];
    [self createView];
}
-(void)createView{
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, ScreenWidth-20, 50)];
    lbl.text = @"如果你在瀚海版的网络世界迷茫而不知读何物，那么不妨看看我们给您推荐的新书，如果你有一本百读不厌的好书，欢迎推荐出来，把你的感悟分享给大家。 ";
    lbl.numberOfLines = 0;
    lbl.textColor = [UIColor blueColor];
    lbl.font = [UIFont systemFontOfSize:16];
    lbl.backgroundColor = [UIColor whiteColor];
   
    CGSize size = [lbl sizeThatFits:CGSizeMake(lbl.frame.size.width, MAXFLOAT)];
    lbl.frame =  CGRectMake(10, 20, ScreenWidth-20, size.height);
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, size.height + 40)];
    [view addSubview:lbl];
    
    UIView *viewTop = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
    viewTop.backgroundColor = ColorLightGray;
    [view addSubview: viewTop];
    UIView *viewBottom = [[UIView alloc] initWithFrame:CGRectMake(0, size.height+ 40 - 10, ScreenWidth, 10)];
     viewBottom.backgroundColor = ColorLightGray;
     [view addSubview: viewBottom];
    [self.view addSubview:view];
    [self creatTableView:CGRectMake(0, size.height + 40, ScreenWidth, ScreenHeight -64 -49-48 -size.height - 40)];
    @WeakObj(self);
    [self.tableView setRequest:^(NSInteger i){[selfWeak.model requestInfo:i];}];
    [self.model requestInfo:1];
//    [self.tableView removeHeaderView];
    self.tableView.bounces = YES;
//    self.tableView.style = UITableViewStyleGrouped;
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
