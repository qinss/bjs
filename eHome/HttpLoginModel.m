//
//  HttpLoginModel.m
//  BaoJin
//
//  Created by qinss on 16/7/1.
//  Copyright © 2016年 sensu_nikun. All rights reserved.
//

#import "HttpLoginModel.h"

@implementation HttpLoginModel
+(void)requestUserLogin:(NSMutableDictionary *)param
                success:(SuccessBlock)success
                failure:(FailureBlock)failure{
    [AFNetWorkingAPI postHttp:UserLogin showHUD:YES parameters:param success:^(NSMutableDictionary *responseDic)
     {
         [SVProgressHUD dismiss];
         NSDictionary *data = [responseDic objectForKey:@"responseData"];
         NSInteger flag = [[data objectForKey:@"flag"] integerValue];
         if (flag == 1) {
             NSDictionary *userDic = [data objectForKey:@"user"];
             UserInfoModel *model = [UserInfoModel makeModelWithDict:userDic];
             [GlobalVariables shareGlobalVariables].currentUser = model;
//             [SVProgressHUD showErrorWithStatus:@"11"];
             //保存 用户名 和密码
             success();
         }
         else{
             failure();
             [SVProgressHUD showErrorWithStatus:@"密码错误"];
         }
         
         [GlobalVariables saveCookie:UserLogin];
//        success();
        
     } failure:^(NSString *message,NSInteger code)
     {
         failure();
     }];
}
@end
