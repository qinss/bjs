//
//  HttpLoginModel.h
//  BaoJin
//
//  Created by qinss on 16/7/1.
//  Copyright © 2016年 sensu_nikun. All rights reserved.
//

#import "HttpServer.h"

@interface HttpLoginModel : HttpServer

+(void)requestUserLogin:(NSMutableDictionary *)param
                success:(SuccessBlock)success
                failure:(FailureBlock)failure;
@end
