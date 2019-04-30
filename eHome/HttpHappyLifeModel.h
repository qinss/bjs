//
//  HttpHappyLifeModel.h
//  eHome
//
//  Created by 秦世帅 on 2017/10/9.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import "HttpServer.h"

@interface HttpHappyLifeModel : HttpServer
+(void)requestAddDiscovery:(NSMutableDictionary *)param
              success:(SuccessBlock) success
             fromData:(void(^)(id<AFMultipartFormData>  formData))formData
;
+(void)requestDiscorveyList:(NSMutableDictionary *)param
               success:(void(^)(NSMutableArray *dataArr,NSInteger totalPage)) success;

+(void)requestUserStepRankingList:(void(^)(NSArray *dataArr)) success;
+(void)requestRankList:(NSMutableDictionary *)param
                  success:(void(^)(NSMutableArray *dataArr,NSInteger totalPage)) success;


+(void)requestAddSupport:(NSMutableDictionary *)param
                    success:(SuccessBlock) success;

@end
