//
//  NewHorizonViewController.m
//  eHome
//
//  Created by 秦世帅 on 2017/5/23.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import "NewHorizonViewController.h"
#import "CommonListViewController.h"
@interface NewHorizonViewController ()

@property(nonatomic,strong) CommonListViewController *controller1;
@property(nonatomic,strong) CommonListViewController *controller2;
@property(nonatomic,strong) CommonListViewController *controller3;
@end

@implementation NewHorizonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     [self setUpNavigationBar:@"新视界"];
    if(self.controller1 == nil){
        self.controller1 = [[CommonListViewController alloc] initWithTitle:@"政经要点"];
    }
    if(self.controller2 == nil){
        self.controller2 = [[CommonListViewController alloc] initWithTitle:@"党性修养"];
    }
    if(self.controller3 == nil){
        self.controller3 = [[CommonListViewController alloc] initWithTitle:@"精彩网视"];
    }
     self.controllers = @[self.controller1,self.controller2,self.controller3];
     self.navigationItem.leftBarButtonItem = nil;
    [self setUpSliderSwithView];

}
@end
