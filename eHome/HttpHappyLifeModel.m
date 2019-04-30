//
//  HttpHappyLifeModel.m
//  eHome
//
//  Created by 秦世帅 on 2017/10/9.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import "HttpHappyLifeModel.h"
#import "DiscorveyModel.h"
#import "StepModel.h"
@implementation HttpHappyLifeModel
+(void)requestAddDiscovery:(NSMutableDictionary *)param
                   success:(SuccessBlock) success
                  fromData:(void(^)(id<AFMultipartFormData>  formData))formData{
    
    [SVProgressHUD showWithStatus:@"加载中···" maskType:2];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:addDiscorvey parameters:param constructingBodyWithBlock:formData success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"responseObject %@",responseObject);
        NSDictionary *responseData = [responseObject objectForKey:@"responseData"];
        NSInteger flag = [[responseData objectForKey:@"flag"] integerValue];
        if (flag == 1 ) {
            [SVProgressHUD showSuccessWithStatus:@"发表成功"];
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


+(void)requestDiscorveyList:(NSMutableDictionary *)param
                    success:(void(^)(NSMutableArray *dataArr,NSInteger totalPage)) success{
    
    
    [AFNetWorkingAPI getHttp:getDiscorveyList parameters:param showHUD:NO success:^(NSDictionary *responseDic){
        NSMutableArray *arrs = [[NSMutableArray alloc] init];
        NSDictionary *data = [responseDic objectForKey:@"responseData"];
        NSArray *listArr = [data objectForKey:@"list"];
        for (NSDictionary *listDic in listArr)
        {
            DiscorveyModel *model = [DiscorveyModel makeModelWithDict:listDic];
            [arrs addObject:model];
        }
        NSInteger totalPage = [[data objectForKey:@"totalPage"] integerValue];
        success(arrs,totalPage);
    } failure:^(NSString *message,NSInteger statusCode){
        
         [SVProgressHUD showErrorWithStatus:@"网络异常"];
    }];
}
+(void)requestUserStepRankingList:(void(^)(NSArray *dataArr)) success{
    [AFNetWorkingAPI getHttp:getStepRankingList parameters:nil showHUD:NO success:^(NSDictionary *responseDic){
        NSDictionary *data = [responseDic objectForKey:@"responseData"];
        NSArray *listArr = [data objectForKey:@"list"];
        success(listArr);
    } failure:^(NSString *message,NSInteger statusCode){
        
         [SVProgressHUD showErrorWithStatus:@"网络异常"];
    }];
    
}
+(void)requestRankList:(NSMutableDictionary *)param
               success:(void(^)(NSMutableArray *dataArr,NSInteger totalPage)) success{
    
    [AFNetWorkingAPI getHttp:getStepRankingByDate parameters:param showHUD:NO success:^(NSDictionary *responseDic){
        NSMutableArray *arrs = [[NSMutableArray alloc] init];
        NSDictionary *data = [responseDic objectForKey:@"responseData"];
        NSMutableArray *listArr = [data objectForKey:@"list"];
        for (NSDictionary *listDic in listArr)
        {
            StepModel *model = [StepModel makeModelWithDict:listDic];
            [arrs addObject:model];
        }
        NSInteger totalPage = [[data objectForKey:@"totalPage"] integerValue];
        success(arrs,totalPage);
    } failure:^(NSString *message,NSInteger statusCode){
        
        [SVProgressHUD showErrorWithStatus:@"网络异常"];
    }];

    
}
+(void)requestAddSupport:(NSMutableDictionary *)param
                 success:(SuccessBlock) success{
    
    
    [AFNetWorkingAPI getHttp:addStepSupport parameters:param showHUD:YES success:^(NSDictionary *responseDic){
        NSDictionary *responseData = [responseDic objectForKey:@"responseData"];
        
        
        NSInteger flag = [[responseData objectForKey:@"flag"] integerValue];
        if (flag == 1 ) {
//            [SVProgressHUD showSuccessWithStatus:@"发表成功"];
            [SVProgressHUD dismiss];
            success();
        }
        else{
            [SVProgressHUD showErrorWithStatus:@"该用户暂未上传步数"];
        }
       
    } failure:^(NSString *message,NSInteger statusCode){
        
        [SVProgressHUD showErrorWithStatus:@"网络异常"];
    }];
    
    
    
}
@end
