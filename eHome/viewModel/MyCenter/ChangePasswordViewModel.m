//
//  ChangePasswordViewModel.m
//  eHome
//
//  Created by 秦世帅 on 2017/10/13.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import "ChangePasswordViewModel.h"
#import "HttpCenterModel.h"
@implementation ChangePasswordViewModel
-(void)requestUpdatePassword:(NSString *)oldPassword
                    password:(NSString *)newPassword{
    
    
    NSMutableDictionary  *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:oldPassword forKey:@"oldPassword"];
    [dic setObject:newPassword forKey:@"newPassword"];
    [HttpCenterModel requestUpdatePassword:dic success:^(){
    
        [self callBackWithData:nil tag:0];
    
    
    
    }];
    
    
}
@end
