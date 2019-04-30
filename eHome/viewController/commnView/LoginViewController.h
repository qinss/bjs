//
//  LoginViewController.h
//  eHome
//
//  Created by 秦世帅 on 2017/10/13.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import "EHomeViewController.h"
#import "BasicViewController.h"
@interface LoginViewController : BasicViewController
@property (weak, nonatomic) IBOutlet UIButton *btnCheck;
@property (weak, nonatomic) IBOutlet UITextField *txtUserName;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
@property (weak, nonatomic) IBOutlet UIButton *btnSave;
- (IBAction)btnSaveTouchUpInside:(UIButton *)sender;

- (IBAction)btnLoginTouchUpInside:(UIButton *)sender;

@end
