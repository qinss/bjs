//
//  ChangePasswordViewController.m
//  eHome
//
//  Created by 秦世帅 on 2017/10/13.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import "ChangePasswordViewController.h"
#import "ChangePasswordViewModel.h"
@interface ChangePasswordViewController ()
@property(nonatomic,strong) ChangePasswordViewModel *model;
@end

@implementation ChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNavigationBar:@"修改密码"];
    self.model = [[ChangePasswordViewModel alloc] initWithDelegate:self];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)modelCallBack:(id)data tag:(NSInteger)tag{
    [self.view makeToast:@"修改成功"];
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (IBAction)btnUpdateTouchUpInside:(UIButton *)sender {
    if ([GlobalVariables InputIsemptyOrNot:self.txtOldPassword.text]) {
        [self.txtOldPassword.layer shake];
    }
    else if ([GlobalVariables InputIsemptyOrNot:self.txtNewPassword.text])
    {
         [self.txtNewPassword.layer shake];
    }
    else if ([GlobalVariables InputIsemptyOrNot:self.txtConfirmPassword.text]){
        [self.txtConfirmPassword.layer shake];
    }
    else if (![self.txtNewPassword.text isEqualToString:self.txtConfirmPassword.text]){
        [self.view makeToast:@"两次密码输入不一致"];
    }
    else{
        [self.model requestUpdatePassword:self.txtOldPassword.text password:self.txtNewPassword.text];
    }
    
    
}
@end
