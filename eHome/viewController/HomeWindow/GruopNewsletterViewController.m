//
//  GruopNewsletterViewController.m
//  eHome
//
//  Created by 秦世帅 on 2017/5/25.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import "GruopNewsletterViewController.h"
#import "SDCycleScrollView.h"
#import "CustomTableViewCell.h"
#import "GroupNewsletterViewModel.h"
#import "LoginViewController.h"
#import "FDNavigationController.h"
@interface GruopNewsletterViewController ()<SDCycleScrollViewDelegate>
@property(nonatomic,strong) GroupNewsletterViewModel *model;
@property(nonatomic,strong) SDCycleScrollView *imagePlayer;
@end

@implementation GruopNewsletterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"北洋简讯";
    self.model = [[GroupNewsletterViewModel alloc] initWithDelegate:self];
    
    
    [self creatTableView:CGRectMake(0, 180, ScreenWidth, ScreenHeight- 180 -64 -49-48) ];
    
    @WeakObj(self);
    [self.tableView setRequest:^(NSInteger i){[selfWeak.model requestInfo:i];}];
    [self.model requestInfo:1];
//    [self.model searchStep];
//    [self makeBanner];
    // 清除缓存
    //    [cycleScrollView2 clearCache];
    [self.model requestBanner];
    [self pushToLogin];
}
-(void)viewWillAppear:(BOOL)animated{
//    [self.model searchStep];
}
-(void)makeBanner{
    if (self.imagePlayer == nil) {
        self.imagePlayer = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, ScreenWidth, 180) delegate:self placeholderImage:[UIImage imageNamed:@"1.jpg"]];
        self.imagePlayer.titleLabelTextAlignment = NSTextAlignmentCenter;
        self.imagePlayer.infiniteLoop = YES;
        self.imagePlayer.pageControlStyle =SDCycleScrollViewPageContolStyleAnimated;
        [self.view addSubview:self.imagePlayer];
        self.imagePlayer.autoScrollTimeInterval = 4.0;
        self.imagePlayer.showPageControl = NO;
    }
    self.imagePlayer.imageURLStringsGroup = self.model.imageUrlArr;
    self.imagePlayer.titlesGroup = self.model.titleArr;
   }
-(void)modelCallBack:(id)data tag:(NSInteger)tag{
    if (tag == tagGetBannerSuccess) {
        [self makeBanner];
    }
    else if (tag == tagGetInfoListSuccess){
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
//    cell.
    [cell makeCellWithModel:infoModel];
//    cell.lblTitle.text = [self.model.titleArray objectAtIndex:indexPath.row];
    return cell;

}

- (void)cycleScrollView:   (SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
}
-(void)pushToLogin{
    LoginViewController * login =[[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
    FDNavigationController  * navi =[[FDNavigationController alloc]initWithRootViewController:login];
    [self presentViewController:navi animated:YES completion:nil];
}

@end
