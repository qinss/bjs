//
//  HttpCenterModel.h
//  eHome
//
//  Created by 秦世帅 on 2017/10/13.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import "HttpServer.h"

@interface HttpCenterModel : HttpServer

+(void)requestUpdatePassword:(NSMutableDictionary *)param
                 success:(SuccessBlock) success;
+(void)requestCollectionBookList:(NSMutableDictionary *)param
               success:(void(^)(NSMutableArray *dataArr,NSInteger totalPage)) success;

+(void)requestAddHeaderImage:(NSMutableDictionary *)param
              success:(SuccessBlock) success
             fromData:(void(^)(id<AFMultipartFormData>  formData))formData
;
+(void)requestUpdateInfo:(NSMutableDictionary *)param
                 success:(SuccessBlock) success;
    +(void)requestLoginOut:(NSMutableDictionary *)param
                     success:(SuccessBlock) success;
    
+(void)requestMessageList:(NSMutableDictionary *)param
                         success:(void(^)(NSMutableArray *dataArr,NSInteger totalPage)) success;

@end
