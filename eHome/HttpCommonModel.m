//
//  HttpCommonModel.m
//  eHome
//
//  Created by 秦世帅 on 2017/9/15.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import "HttpCommonModel.h"
#import "CommentModel.h"
@implementation HttpCommonModel
+(void)requestInfoList:(NSMutableDictionary *)param
               success:(void(^)(NSMutableArray *dataArr,NSInteger totalPage)) success{
    
    [AFNetWorkingAPI getHttp:GetInfoList parameters:param showHUD:NO success:^(NSDictionary *responseDic){
        NSMutableArray *arrs = [[NSMutableArray alloc] init];
        NSDictionary *data = [responseDic objectForKey:@"responseData"];
        NSArray *listArr = [data objectForKey:@"list"];
        for (NSDictionary *listDic in listArr)
        {
            InfoModel *model = [InfoModel makeModelWithDict:listDic];
            [arrs addObject:model];
        }
        NSInteger totalPage = [[data objectForKey:@"totalPage"] integerValue];
        success(arrs,totalPage);
        
    } failure:^(NSString *message,NSInteger statusCode){
        
    }];
 
}
+(void)requestChangeCollection:(NSMutableDictionary *)param
                       success:(SuccessBlock) success{
    

    [AFNetWorkingAPI getHttp:ChangeCollection parameters:param showHUD:YES success:^(NSDictionary *responseDic){
        NSDictionary *data = [responseDic objectForKey:@"responseData"];
        NSInteger flag = [[data objectForKey:@"flag"] integerValue];
        if (flag == 1) {
            success();
             [SVProgressHUD dismiss];
        }
        else{
            [SVProgressHUD showErrorWithStatus:@"系统异常"];
        }
       
        
    } failure:^(NSString *message,NSInteger statusCode){
         [SVProgressHUD dismiss];
    }];

}
+(void)requestChangeSupport:(NSMutableDictionary *)param
                    success:(SuccessBlock) success{
    [AFNetWorkingAPI getHttp:ChangeSupport parameters:param showHUD:YES success:^(NSDictionary *responseDic){
        NSDictionary *data = [responseDic objectForKey:@"responseData"];
        NSInteger flag = [[data objectForKey:@"flag"] integerValue];
        if (flag == 1) {
            success();
            [SVProgressHUD dismiss];
        }
        else{
            [SVProgressHUD showErrorWithStatus:@"系统异常"];
        }
        
        
    } failure:^(NSString *message,NSInteger statusCode){
        [SVProgressHUD dismiss];
    }];
}
+(void)requestAddComment:(NSMutableDictionary *)param
                 success:(SuccessBlock) success{
    
    [AFNetWorkingAPI postHttp:AddComment showHUD:YES parameters:param success:^(NSDictionary *responseDic){
        NSDictionary *data = [responseDic objectForKey:@"responseData"];
        NSInteger flag = [[data objectForKey:@"flag"] integerValue];
        if (flag == 1) {
            success();
            [SVProgressHUD showSuccessWithStatus:@"评论成功"];
        }
        else if (flag == -1){
            //登录失效
            [SVProgressHUD showSuccessWithStatus:@"请重新登录"];
        }
        else{
            [SVProgressHUD showErrorWithStatus:@"系统异常"];
        }
        
    } failure:^(NSString *message,NSInteger statusCode){
        [SVProgressHUD dismiss];
    }];
    

    
}
+(void)requestCommentList:(NSMutableDictionary *)param
                  success:(void(^)(NSMutableArray *dataArr,NSInteger totalPage)) success{
    
    [AFNetWorkingAPI getHttp:getCommentList parameters:param showHUD:NO success:^(NSDictionary *responseDic){
        NSMutableArray *arrs = [[NSMutableArray alloc] init];
        NSDictionary *data = [responseDic objectForKey:@"responseData"];
        NSArray *listArr = [data objectForKey:@"list"];
        for (NSDictionary *listDic in listArr)
        {
            CommentModel *model = [CommentModel makeModelWithDict:listDic];
            [arrs addObject:model];
        }
        NSInteger totalPage = [[data objectForKey:@"totalPage"] integerValue];
        success(arrs,totalPage);
    } failure:^(NSString *message,NSInteger statusCode){
    }];
}
@end
