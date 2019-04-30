//
//  HomeWindowViewController.m
//  eHome
//
//  Created by 秦世帅 on 2017/5/23.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import "HomeWindowViewController.h"
#import "CommonListViewController.h"
#import "SearchViewController.h"
#import "GruopNewsletterViewController.h"
@interface HomeWindowViewController ()

@property(nonatomic,strong) GruopNewsletterViewController *controller1;
@property(nonatomic,strong) CommonListViewController *controller2;
@property(nonatomic,strong) CommonListViewController *controller3;
@property(nonatomic,strong) CommonListViewController *controller4;
@property(nonatomic,strong) SearchViewController *searchViewController;

@end

@implementation HomeWindowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNavigationBar:@"北洋之窗"];
   
    if(self.controller1 == nil){
         self.controller1 = [[GruopNewsletterViewController alloc] init];
    }
    if(self.controller2 == nil){
        self.controller2 = [[CommonListViewController alloc] initWithTitle:@"每日动态"];
    }
    if(self.controller3 == nil){
        self.controller3 = [[CommonListViewController alloc] initWithTitle:@"要闻速递"];
    }
    if(self.controller4 == nil){
        self.controller4 = [[CommonListViewController alloc] initWithTitle:@"北洋讲堂"];
    }
    self.controllers = @[self.controller1,self.controller2,self.controller3,self.controller4];
     [self setUpSliderSwithView];
    

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:self action:@selector(pushToSearchViewController) forControlEvents:UIControlEventTouchUpInside];
    btn.bounds = CGRectMake(0, 0,60, 30);
    btn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    [btn setImage:[UIImage imageNamed:@"icon_search"] forState:UIControlStateNormal];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = item;
    
    UIButton *btnLeft = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnLeft addTarget:self action:@selector(pushToSearchViewController) forControlEvents:UIControlEventTouchUpInside];
    btnLeft.bounds = CGRectMake(0, 0,20, 30);
    btnLeft.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
    btnLeft.titleLabel.font = [UIFont systemFontOfSize:16];
    [btnLeft setImage:[UIImage imageNamed:@"icon_horn"] forState:UIControlStateNormal];
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc] initWithCustomView:btnLeft];
//    btnLeft.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = item2;
    
    
}

/******************************************************************************
 *  privateMethod Implementation
 ******************************************************************************/
#pragma mark - privateMethod

-(void)pushToSearchViewController{
    if (self.searchViewController == nil) {
        self.searchViewController = [[SearchViewController alloc] init];
    }
    [self.navigationController pushViewController:self.searchViewController animated:YES];
}





@end
