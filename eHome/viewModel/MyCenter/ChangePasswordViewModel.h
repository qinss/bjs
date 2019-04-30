//
//  ChangePasswordViewModel.h
//  eHome
//
//  Created by 秦世帅 on 2017/10/13.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import "EHomeViewModel.h"

@interface ChangePasswordViewModel : EHomeViewModel
-(void)requestUpdatePassword:(NSString *)oldPassword
              password:(NSString *)newPassword;
@end
