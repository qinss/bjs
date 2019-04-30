//
//  EditInfoViewController.h
//  eHome
//
//  Created by 秦世帅 on 2017/10/17.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import "BasicViewController.h"
#import "BasicUploadImageViewController.h"
@interface EditInfoViewController : BasicUploadImageViewController
@property (weak, nonatomic) IBOutlet UITextField *txtPostion;
@property (weak, nonatomic) IBOutlet UITextField *txtDate;
@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
- (IBAction)btnSaveTouchUpInside:(UIButton *)sender;

@end
