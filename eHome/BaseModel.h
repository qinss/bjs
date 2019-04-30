//
//  BaseModel.h
//  eHome
//
//  Created by 秦世帅 on 2017/9/28.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseDefine.h"
@interface BaseModel : NSObject
+(instancetype)makeModelWithDict:(NSDictionary *)dict;
@end
