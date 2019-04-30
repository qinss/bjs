//
//  HttpCenterModel.m
//  eHome
//
//  Created by 秦世帅 on 2017/10/13.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import "HttpCenterModel.h"
#import "BookModel.h"
#import "MessageModel.h"
@implementation HttpCenterModel
+(void)requestUpdatePassword:(NSMutableDictionary *)param
                     success:(SuccessBlock) success{
    
    [AFNetWorkingAPI getHttp:updatePassword parameters:param showHUD:YES success:^(NSDictionary *responseDic){
        NSDictionary *responseData = [responseDic objectForKey:@"responseData"];
        NSInteger flag = [[responseData objectForKey:@"flag"] integerValue];
        if (flag == 1 ) {
            //            [SVProgressHUD showSuccessWithStatus:@"发表成功"];
            [SVProgressHUD dismiss];
            success();
        }
        else if(flag == -3){
            [SVProgressHUD showErrorWithStatus:@"原密码不正确"];
        }
        else{
            [SVProgressHUD showErrorWithStatus:@"网络请求失败"];

        }
    } failure:^(NSString *message,NSInteger statusCode){
        [SVProgressHUD showErrorWithStatus:@"网络异常"];
    }];
    
}


+(void)requestCollectionBookList:(NSMutableDictionary *)param
               success:(void(^)(NSMutableArray *dataArr,NSInteger totalPage)) success{
    
    
    [AFNetWorkingAPI getHttp:getMyBookList parameters:param showHUD:NO success:^(NSDictionary *responseDic){
        NSMutableArray *arrs = [[NSMutableArray alloc] init];
        NSDictionary *data = [responseDic objectForKey:@"responseData"];
        NSArray *listArr = [data objectForKey:@"list"];
        for (NSDictionary *listDic in listArr)
        {
            BookModel *model = [BookModel makeModelWithDict:listDic];
            [arrs addObject:model];
        }
        NSInteger totalPage = [[data objectForKey:@"totalPage"] integerValue];
        success(arrs,totalPage);
        
        
    } failure:^(NSString *message,NSInteger statusCode){
        
        
    }];
    
    
}


+(void)requestAddHeaderImage:(NSMutableDictionary *)param
              success:(SuccessBlock) success
             fromData:(void(^)(id<AFMultipartFormData>  formData))formData
{
    [SVProgressHUD showWithStatus:@"加载中···" maskType:2];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:addImageHeader parameters:param constructingBodyWithBlock:formData success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"responseObject %@",responseObject);
        //        [SVProgressHUD dismiss];
        NSDictionary *responseData = [responseObject objectForKey:@"responseData"];
        NSInteger flag = [[responseData objectForKey:@"flag"] integerValue];
        if (flag == 1 ) {
            NSDictionary *dic = [responseData objectForKey:@"userVO"];
            [GlobalVariables shareGlobalVariables].currentUser = [UserInfoModel makeModelWithDict:dic];
//            [SVProgressHUD showSuccessWithStatus:@"添加成功"];
            [SVProgressHUD dismiss];
            success();
        }
        else{
            NSString *message = [responseData objectForKey:@"message"];
            [SVProgressHUD showErrorWithStatus:message];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error %@",error);
        [SVProgressHUD showErrorWithStatus:@"网络异常"];
    }];
}
+(void)requestUpdateInfo:(NSMutableDictionary *)param
                 success:(SuccessBlock) success{
    [AFNetWorkingAPI postHttp:updateUserInfo showHUD:YES parameters:param success:^(NSDictionary *responseDic){
        NSDictionary *responseData = [responseDic objectForKey:@"responseData"];
        NSInteger flag = [[responseData objectForKey:@"flag"] integerValue];
        if (flag == 1 ) {
            NSDictionary *dic = [responseData objectForKey:@"userVO"];
            [GlobalVariables shareGlobalVariables].currentUser = [UserInfoModel makeModelWithDict:dic];
            [SVProgressHUD dismiss];
            success();
        }
        
        else{
            [SVProgressHUD showErrorWithStatus:@"网络请求失败"];
            
        }
    } failure:^(NSString *message,NSInteger statusCode){
        [SVProgressHUD showErrorWithStatus:@"网络异常"];
    }];

    
    
    
}
    
+(void)requestMessageList:(NSMutableDictionary *)param
                  success:(void(^)(NSMutableArray *dataArr,NSInteger totalPage)) success{
    
    [AFNetWorkingAPI getHttp:getMyMessageList parameters:param showHUD:NO success:^(NSDictionary *responseDic){
        NSMutableArray *arrs = [[NSMutableArray alloc] init];
        NSDictionary *data = [responseDic objectForKey:@"responseData"];
        NSArray *listArr = [data objectForKey:@"list"];
        for (NSDictionary *listDic in listArr)
        {
            MessageModel *model = [MessageModel makeModelWithDict:listDic];
            [arrs addObject:model];
        }
        NSInteger totalPage = [[data objectForKey:@"totalPage"] integerValue];
        success(arrs,totalPage);
        
        
    } failure:^(NSString *message,NSInteger statusCode){
        
        
    }];
    
}
+(void)requestLoginOut:(NSMutableDictionary *)param
                   success:(SuccessBlock) success{
        
    }
@end
