//
//  MyInfoViewController.h
//  eHome
//
//  Created by 秦世帅 on 2017/10/17.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import "BasicViewController.h"
#import "BasicUploadImageViewController.h"
@interface MyInfoViewController : BasicUploadImageViewController
@property (weak, nonatomic) IBOutlet UIImageView *imgHead;
//@property (weak, nonatomic) IBOutlet UITextField *txtDate;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblGender;
@property (weak, nonatomic) IBOutlet UILabel *lblPostion;
@property (weak, nonatomic) IBOutlet UILabel *lblDepartment;
@property (weak, nonatomic) IBOutlet UILabel *lblBirthday;
@property (weak, nonatomic) IBOutlet UILabel *lblEmail;
- (IBAction)btnExitTouchUpInside:(UIButton *)sender;

@end
