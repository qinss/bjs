//
//  LoginViewController.m
//  eHome
//
//  Created by 秦世帅 on 2017/10/13.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import "LoginViewController.h"
#define CHECK_YES @"imgCheckYes"
#define CHECK_NO @"imgCheckNo"
#import "LoginViewModel.h"
#import  "JPUSHService.h"
@interface LoginViewController ()
@property(nonatomic,strong) LoginViewModel *model;
@property(nonatomic,strong) NSString *registrationID;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   self.registrationID = [JPUSHService registrationID];
//    NSLog(@"registartionID:%@",registrationID);
    
    [self setUpNavigationBar:@"登录"];
    self.model = [[LoginViewModel alloc] initWithDelegate:self];
    [_btnCheck setBackgroundImage:[UIImage imageNamed:CHECK_NO] forState:UIControlStateNormal];
    [_btnCheck setBackgroundImage:[UIImage imageNamed:CHECK_YES] forState:UIControlStateSelected];
    _btnCheck.selected = NO;
    _btnCheck.adjustsImageWhenHighlighted = NO;
    self.navigationItem.leftBarButtonItem = nil;
    self.txtUserName.text = [GlobalVariables getUserDefault:@"username"];
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated{
    NSString *password = [GlobalVariables getUserDefault:@"password"];
    if (password.length > 0) {
        NSString *username = [GlobalVariables getUserDefault:@"username"];
          [self.model requestForLogin:username password:password messageID:self.registrationID];
    }
    
    
    
}
-(void)modelCallBack:(id)data tag:(NSInteger)tag{
    if (tagLoginFailure == tag) {
        [self.view makeToast:@"用户名密码错误"];
    }
    else if (tagLoginSuccess == tag){
        if (self.btnSave.selected) {
            
            //
             [self.model searchStep];
            
            
            
             [GlobalVariables setUserDefault:@"password" value:self.txtPassword.text];
        }
        
        [GlobalVariables setUserDefault:@"username" value:self.txtUserName.text];
        
    [self dismissViewControllerAnimated:YES completion:nil];
    }
    
    
}
- (IBAction)btnSaveTouchUpInside:(UIButton *)sender {
    sender.selected = !sender.selected;
}

- (IBAction)btnLoginTouchUpInside:(UIButton *)sender {
    
    if ([GlobalVariables InputIsemptyOrNot:self.txtUserName.text])
    {
        [self.txtUserName.layer shake];
        
    }else if ([GlobalVariables InputIsemptyOrNot:self.txtPassword.text])
    {
        [self.txtPassword.layer shake];
    }
    else{
        [self.model requestForLogin:self.txtUserName.text password:self.txtPassword.text messageID:self.registrationID];
    }
    if (!_btnSave.selected) {
         [GlobalVariables setUserDefault:@"password" value:@""];
    }
   
    
    
}
@end
