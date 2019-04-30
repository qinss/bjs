//
//  HttpInteractiveBarModel.h
//  eHome
//
//  Created by 秦世帅 on 2017/9/19.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import "HttpServer.h"
#import "CommonModel.h"
@interface HttpInteractiveBarModel : HttpServer
+(void)requestBookList:(NSMutableDictionary *)param
               success:(void(^)(NSMutableArray *dataArr,NSInteger totalPage)) success;

+(void)requestAddBook:(NSMutableDictionary *)param
               success:(SuccessBlock) success
             fromData:(void(^)(id<AFMultipartFormData>  formData))formData
;
+(void)requestBookInfo:(NSMutableDictionary *)param
               success:(void(^)(CommonModel *model)) success;
+(void)requestActionList:(NSMutableDictionary *)param
               success:(void(^)(NSMutableArray *dataArr,NSInteger totalPage)) success;
+(void)requestActionInfo:(NSMutableDictionary *)param
               success:(void(^)(NSDictionary *dic)) success;
@end
