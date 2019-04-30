//
//  LoginViewModel.m
//  eHome
//
//  Created by 秦世帅 on 2017/10/13.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import "LoginViewModel.h"
#import "HttpLoginModel.h"
#import "HttpHomeWindowModel.h"
@implementation LoginViewModel
-(void)requestForLogin:(NSString *)username
              password:(NSString *)password
             messageID:(NSString *)messageID{
    
    NSMutableDictionary * paraDict =[[NSMutableDictionary alloc]init];
    [paraDict setObject:username forKey:@"name"];
    if (messageID) {
         [paraDict setObject:messageID forKey:@"messageID"];
    }
    [paraDict setObject:password forKey:@"password"];
    [HttpLoginModel requestUserLogin:paraDict success:^(){
        [self callBackWithData:nil tag:tagLoginSuccess];
        
    } failure:^(){
        [self callBackWithData:nil tag:tagLoginFailure];
        
    }];
}
-(void)searchFinish:(NSInteger)tag data:(NSInteger)data{
        [self uplodaStep:data];
    }
-(void)uplodaStep:(NSInteger)step{
    NSMutableDictionary  *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@(step) forKey:@"stepCount"];
    [HttpHomeWindowModel uploadStep:dic];
}
    -(void)searchStep{
        HealthyHelp *healthyHelp = [[HealthyHelp alloc] init];
        healthyHelp.searchStepDelegete = self;
        [healthyHelp healthyKitPermissionWithStep:^(){
            [healthyHelp getStepWithDay:0];
        } failureBlock:^(){
        }];
    }
@end
