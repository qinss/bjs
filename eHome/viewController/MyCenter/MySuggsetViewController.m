//
//  MySuggsetViewController.m
//  eHome
//
//  Created by 秦世帅 on 2017/10/16.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import "MySuggsetViewController.h"
#import "MyBookViewController.h"
#import "FindViewController.h"
@interface MySuggsetViewController ()
@property(nonatomic,strong) MyBookViewController *controller1;
@property(nonatomic,strong) FindViewController *controller2;
@end

@implementation MySuggsetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNavigationBar:@"我的发表与推荐"];
    if (self.controller1 == nil) {
        self.controller1 =[[MyBookViewController alloc] initWithTitle:@"我的好书推荐"];
    }
    if(self.controller2 == nil){
        self.controller2 = [[FindViewController alloc] initWithTitle:@"我的微论坛"];
    }
    self.controllers = @[self.controller1,self.controller2];
    [self setUpSliderSwithView];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
