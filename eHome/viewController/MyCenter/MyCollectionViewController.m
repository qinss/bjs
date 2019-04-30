//
//  MyCollectionViewController.m
//  eHome
//
//  Created by 秦世帅 on 2017/10/16.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import "MyCollectionViewController.h"
//#import "CommonListViewController.h
#import "CommonListViewController.h"
#import "MyBookViewController.h"
@interface MyCollectionViewController ()
@property(nonatomic,strong) CommonListViewController *controller1;
@property(nonatomic,strong) MyBookViewController *controller2;
@end

@implementation MyCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNavigationBar:@"我的收藏"];
    if (self.controller1 == nil) {
        self.controller1 = [[CommonListViewController alloc] initWithTitle:@"我的文章收藏"];
    }
    if (self.controller2 == nil) {
        self.controller2 = [[MyBookViewController alloc] initWithTitle:@"我的好书收藏"];
    }
    self.controllers = @[self.controller1,self.controller2];
    [self setUpSliderSwithView];
}



@end
