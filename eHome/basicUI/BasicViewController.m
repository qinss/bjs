//
//  BasicViewController.m
//  eHome
//
//  Created by 秦世帅 on 2017/5/23.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import "BasicViewController.h"
#import "BaseDefine.h"
#import "UIScrollView+MJRefresh.h"
#import "UIImageView+WebCache.h"

@interface BasicViewController ()


@end

@implementation BasicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = WhiteMainColor;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:nil];
    [[SDImageCache sharedImageCache] clearMemory];
}
- (void)setUpNavigationBar:(NSString *)titleText
{
    self.navigationItem.title = titleText;
    


    
    UIButton * backBtn = [BasicViewController NewsUiBarButton:@"icon_back" WithISLeft:YES];
    [backBtn addTarget:self action:@selector(BackBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem * backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
    
}

- (void)BackBtnClick
{
    
    if ([self.navigationController respondsToSelector:@selector(popViewControllerAnimated:)])
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
        [self dismissViewControllerAnimated:YES completion:nil];
    
}
+ (UIButton *)NewsUiBarButton: (NSString *)imageStr WithISLeft:(BOOL)isPianyi
{
    UIButton *navLeftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    // navLeftButton.backgroundColor = [UIColor clearColor];
    navLeftButton.frame = CGRectMake(10, 20, 30, 30);
    [navLeftButton setImage:[UIImage imageNamed:imageStr] forState:UIControlStateNormal];
    navLeftButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    if(isPianyi)
        navLeftButton.imageEdgeInsets = UIEdgeInsetsMake(0, -16, 0, 0);
    return navLeftButton;
}
-(void)modelCallBack:(id)data tag:(NSInteger)tag{
    
}
- (void)showMessage:(NSString *)message
{
    [self showToast:message];
}
- (void)showToast:(NSString *)message
{
    if (message)
    {
        UIView *view = [[[UIApplication sharedApplication] windows] lastObject];
        [view makeToast:message duration:1.0f position:CSToastPositionBottom title:nil];
    }
}

@end

