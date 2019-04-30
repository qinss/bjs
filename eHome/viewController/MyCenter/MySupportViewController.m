//
//  MySupportViewController.m
//  eHome
//
//  Created by 秦世帅 on 2017/10/16.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import "MySupportViewController.h"
#import "MyCenterViewModel.h"
#import "MyInfoCell.h"
#import "ChangePasswordViewController.h"
#import "CommonListViewController.h"
#import "MyBookViewController.h"
@interface MySupportViewController ()
@property(nonatomic,strong) CommonListViewController *controller1;
@property(nonatomic,strong) MyBookViewController *controller2;
@end

@implementation MySupportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNavigationBar:@"我的点赞"];
    if (self.controller1 == nil) {
        self.controller1 = [[CommonListViewController alloc] initWithTitle:@"我的点赞文章"];
    }
    if (self.controller2 == nil) {
        self.controller2 = [[MyBookViewController alloc] initWithTitle:@"我的点赞好书"];
    }
    self.controllers = @[self.controller1,self.controller2];
    [self setUpSliderSwithView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
