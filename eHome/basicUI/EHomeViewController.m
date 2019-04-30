//
//  EHomeViewController.m
//  eHome
//
//  Created by 秦世帅 on 2017/5/23.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import "EHomeViewController.h"
#import "FDNavigationController.h"
#import "HomeWindowViewController.h"
#import "NewHorizonViewController.h"
#import "InteractiveBarViewController.h"
#import "HappyLifeViewController.h"
#import "MyCenterViewController.h"
#import "BaseDefine.h"

@interface EHomeViewController ()<UITabBarControllerDelegate>
@end

@implementation EHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.tabBar.translucent = NO;
    NSArray * normalItems =@[@"bar1",@"bar3",@"bar5",@"bar7",@"bar9"];
    NSArray * selectItmes =@[@"bar2",@"bar4",@"bar6",@"bar8",@"bar10"];

    NSArray * controllClass = @[@"HomeWindowViewController",@"NewHorizonViewController",@"InteractiveBarViewController",@"HappyLifeViewController",@"MyCenterViewController"];
    self.delegate = self;
    NSArray * itemTitles =@[@"组工窗",@"新视界",@"互动吧",@"乐生活",@"我"];
    NSMutableArray * controllers =[[NSMutableArray alloc]init];
    for (NSInteger i =0; i<5; i++)
    {
        UIViewController * homeview;
        if (i == 1) {
            homeview = [[NSClassFromString(controllClass[i]) alloc]init];
        }
        else
        {
            homeview = [[NSClassFromString(controllClass[i]) alloc]initWithNibName:controllClass[i] bundle:nil];
        }
        FDNavigationController * navigation =[[FDNavigationController alloc]initWithRootViewController:homeview];
        navigation.tabBarItem.image = [[UIImage imageNamed:normalItems[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        navigation.tabBarItem.selectedImage = [[UIImage imageNamed:selectItmes[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [controllers addObject:navigation];
        navigation.tabBarItem.title = itemTitles[i];
        navigation.tabBarItem.titlePositionAdjustment = UIOffsetMake(0,-3);
    }
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName :ColorRedColor} forState:UIControlStateSelected];
    self.viewControllers = controllers;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end