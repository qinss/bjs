//
//  HttpCommonModel.h
//  eHome
//
//  Created by 秦世帅 on 2017/9/15.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import "HttpServer.h"
#import "InfoModel.h"
@interface HttpCommonModel : HttpServer
+(void)requestInfoList:(NSMutableDictionary *)param
                      success:(void(^)(NSMutableArray *dataArr,NSInteger totalPage)) success;


+(void)requestChangeCollection:(NSMutableDictionary *)param
                       success:(SuccessBlock) success;
+(void)requestChangeSupport:(NSMutableDictionary *)param
                       success:(SuccessBlock) success;
+(void)requestAddComment:(NSMutableDictionary *)param
                    success:(SuccessBlock) success;
+(void)requestCommentList:(NSMutableDictionary *)param
               success:(void(^)(NSMutableArray *dataArr,NSInteger totalPage)) success;
@end
