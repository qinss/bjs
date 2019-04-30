//
//  ChangePasswordViewController.h
//  eHome
//
//  Created by 秦世帅 on 2017/10/13.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BasicViewController.h"
@interface ChangePasswordViewController : BasicViewController
@property (weak, nonatomic) IBOutlet UITextField *txtOldPassword;
@property (weak, nonatomic) IBOutlet UITextField *txtNewPassword;
@property (weak, nonatomic) IBOutlet UITextField *txtConfirmPassword;
- (IBAction)btnUpdateTouchUpInside:(UIButton *)sender;


@end
