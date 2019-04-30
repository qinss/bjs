//
//  HttpServer.h
//  BaoJin
//
//  Created by qinss on 16/6/24.
//  Copyright © 2016年 sensu_nikun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetWorkingAPI.h"
#import "BaseDefine.h"
#import "UrlDefine.h"
#import "SVProgressHUD.h"
@interface HttpServer : NSObject
typedef void (^SuccessBlock)();
typedef void (^FailureBlock)();
typedef void (^FailureWithMessageBlock)(NSString *message);
@end
