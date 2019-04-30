//
//  HttpInteractiveBarModel.m
//  eHome
//
//  Created by 秦世帅 on 2017/9/19.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import "HttpInteractiveBarModel.h"
#import "BookModel.h"
#import "CommonModel.h"
#import "ActionModel.h"

@implementation HttpInteractiveBarModel
+(void)requestBookList:(NSMutableDictionary *)param
               success:(void(^)(NSMutableArray *dataArr,NSInteger totalPage)) success{
    
    
    [AFNetWorkingAPI getHttp:GetBookList parameters:param showHUD:NO success:^(NSDictionary *responseDic){
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
+(void)requestAddBook:(NSMutableDictionary *)param
              success:(SuccessBlock) success
             fromData:(void(^)(id<AFMultipartFormData>  formData))formData
{
    [SVProgressHUD showWithStatus:@"加载中···" maskType:2];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:UploadImage parameters:param constructingBodyWithBlock:formData success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"responseObject %@",responseObject);
//        [SVProgressHUD dismiss];
        NSDictionary *responseData = [responseObject objectForKey:@"responseData"];
        NSInteger flag = [[responseData objectForKey:@"flag"] integerValue];
        if (flag == 1 ) {
            [SVProgressHUD showSuccessWithStatus:@"添加成功"];
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
+(void)requestBookInfo:(NSMutableDictionary *)param
               success:(void(^)(CommonModel *model)) success{
    
    
    [AFNetWorkingAPI getHttp:GetBookInfo parameters:param showHUD:NO success:^(NSDictionary *responseDic){
        NSMutableArray *arrs = [[NSMutableArray alloc] init];
        NSDictionary *data = [responseDic objectForKey:@"responseData"];
        NSInteger flag = [[data objectForKey:@"flag"] integerValue];
        if (flag == 1) {
            CommonModel *model = [CommonModel makeModelWithDict:data ];
            success(model);
        }
        else{
            
            [SVProgressHUD showErrorWithStatus:@"系统异常"];
        }
        
    } failure:^(NSString *message,NSInteger statusCode){
        
        
    }];
    
}

+(void)requestActionList:(NSMutableDictionary *)param
               success:(void(^)(NSMutableArray *dataArr,NSInteger totalPage)) success{
    
    
    [AFNetWorkingAPI getHttp:GetActionList parameters:param showHUD:NO success:^(NSDictionary *responseDic){
        NSMutableArray *arrs = [[NSMutableArray alloc] init];
        NSDictionary *data = [responseDic objectForKey:@"responseData"];
        NSArray *listArr = [data objectForKey:@"list"];
        for (NSDictionary *listDic in listArr)
        {
            ActionModel *model = [ActionModel makeModelWithDict:listDic];
            [arrs addObject:model];
        }
        NSInteger totalPage = [[data objectForKey:@"totalPage"] integerValue];
        success(arrs,totalPage);
        
        
    } failure:^(NSString *message,NSInteger statusCode){
        
        
    }];
    
    
}

+(void)requestActionInfo:(NSMutableDictionary *)param
               success:(void(^)(NSDictionary *dic)) success{
    
    
    [AFNetWorkingAPI getHttp:getActionDetail parameters:param showHUD:NO success:^(NSDictionary *responseDic){
//        NSMutableArray *arrs = [[NSMutableArray alloc] init];
        NSDictionary *data = [responseDic objectForKey:@"responseData"];
        NSInteger flag = [[data objectForKey:@"flag"] integerValue];
        if (flag == 1) {
           
            success(data);
        }
        else{
            [SVProgressHUD showErrorWithStatus:@"系统异常"];
        }
        
    } failure:^(NSString *message,NSInteger statusCode){
    }];
    
}
@end
