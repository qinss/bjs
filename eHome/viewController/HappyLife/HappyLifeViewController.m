//
//  HappyLifeViewController.m
//  eHome
//
//  Created by 秦世帅 on 2017/5/23.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import "HappyLifeViewController.h"
#import "FindViewController.h"
#import "SportViewController.h"
#import "AddHappyLifeViewController.h"

@interface HappyLifeViewController ()

@property(nonatomic,strong) FindViewController *controller1;
@property(nonatomic,strong) SportViewController *controller2;
@end

@implementation HappyLifeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     [self setUpNavigationBar:@"乐生活"];
    if(self.controller1 == nil){
        self.controller1 = [[ FindViewController alloc] initWithTitle:@"发现了没"];
    }
    if(self.controller2 == nil){
        self.controller2 = [[SportViewController alloc] init];
    }
    self.controllers = @[self.controller1,self.controller2];
     self.navigationItem.leftBarButtonItem = nil;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:self action:@selector(pushtToAddHappyLifeViewController) forControlEvents:UIControlEventTouchUpInside];
    btn.bounds = CGRectMake(0, 0,60, 30);
    btn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    [btn setImage:[UIImage imageNamed:@"icon_addRemark"] forState:UIControlStateNormal];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = item;
    [self setUpSliderSwithView];

}
-(void)pushtToAddHappyLifeViewController{
    AddHappyLifeViewController *vc = [[AddHappyLifeViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
