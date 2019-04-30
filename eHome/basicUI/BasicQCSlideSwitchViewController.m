//
//  BasicQCSlideSwitchViewController.m
//  eHome
//
//  Created by 秦世帅 on 2017/5/31.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import "BasicQCSlideSwitchViewController.h"

@interface BasicQCSlideSwitchViewController ()<QCSlideSwitchViewDelegate>

@end

@implementation BasicQCSlideSwitchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
}
- (void)setUpSliderSwithView
{
    if (self.slideSwitchView)
    {
        [self.slideSwitchView removeFromSuperview];
        self.slideSwitchView = nil;
    }
    CGRect frame = CGRectMake(0,0, ScreenWidth, ScreenHeight-47);
    self.slideSwitchView = [[QCSlideSwitchView alloc] initWithFrame:frame];
    self.slideSwitchView.slideSwitchViewDelegate = self;
    [self.view addSubview:self.slideSwitchView];
    for (UIViewController *controller in self.controllers)
    {
        [self addChildViewController:controller];
    }
    [self.slideSwitchView buildUI];
}

/******************************************************************************
 *  QCSlideSwitchViewDelegate Implementation
 ******************************************************************************/
#pragma mark -
#pragma mark QCSlideSwitchViewDelegate Implementation

- (NSUInteger)numberOfTab:(QCSlideSwitchView *)view
{
    return self.controllers.count;
}

- (UIViewController *)slideSwitchView:(QCSlideSwitchView *)view viewOfTab:(NSUInteger)number
{
    return self.controllers[number];
}

- (void)slideSwitchView:(QCSlideSwitchView *)view didselectTab:(NSUInteger)number
{
    
    
}
@end
