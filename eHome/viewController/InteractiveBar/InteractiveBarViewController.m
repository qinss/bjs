//
//  InteractiveBarViewController.m
//  eHome
//
//  Created by 秦世帅 on 2017/5/23.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import "InteractiveBarViewController.h"
#import "ReadingViewController.h"
#import "LearningViewController.h"
#import "ActionViewController.h"
#import "RecommendBookViewController.h"
//PassEnentTableViewController
#import "PassEnentTableViewController.h"
@interface InteractiveBarViewController ()
@property(nonatomic,strong) ReadingViewController *controller1;
@property(nonatomic,strong) LearningViewController *controller2;
@property(nonatomic,strong) PassEnentTableViewController *controller3;

@end

@implementation InteractiveBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     [self setUpNavigationBar:@"互动吧"];
    if (self.controller1 == nil) {
        self.controller1 = [[ReadingViewController alloc]init];
    }
    if (self.controller2 == nil) {
        self.controller2 = [[LearningViewController alloc] init];
    }
    if (self.controller3 == nil) {
        self.controller3 = [[PassEnentTableViewController alloc] init];
    }
     self.controllers = @[self.controller1,self.controller2,self.controller3];
     self.navigationItem.leftBarButtonItem = nil;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:self action:@selector(pushToRecommendBookViewController) forControlEvents:UIControlEventTouchUpInside];
    btn.bounds = CGRectMake(0, 0,60, 30);
    btn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    [btn setImage:[UIImage imageNamed:@"icon_recommend"] forState:UIControlStateNormal];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = item;
    [self setUpSliderSwithView];
}
-(void)pushToRecommendBookViewController{
    RecommendBookViewController *vc = [[RecommendBookViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
