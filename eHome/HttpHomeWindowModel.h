//
//  HttpHomeWindowModel.h
//  eHome
//
//  Created by 秦世帅 on 2017/9/15.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import "HttpServer.h"
#import "BannerModel.h"
@interface HttpHomeWindowModel : HttpServer
+(void) requestBankList:(void(^)(NSMutableArray *dataArr))success;

+(void)uploadStep:(NSMutableDictionary *)param
                       ;

@end
