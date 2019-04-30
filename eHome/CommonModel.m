//
//  CommonModel.m
//  eHome
//
//  Created by 秦世帅 on 2017/9/26.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import "CommonModel.h"
#import "BaseDefine.h"
@implementation CommonModel

+(instancetype)makeModelWithDict:(NSDictionary *)dict{
    CommonModel *model = [[CommonModel alloc] init];
    model.collectionStatus = [MBNonEmptyString([dict objectForKey:@"collectionStatus"]) integerValue];
    
     model.supportCount = [MBNonEmptyString([dict objectForKey:@"supportCount"]) integerValue];
     model.supportStatus = [MBNonEmptyString([dict objectForKey:@"supportStatus"]) integerValue];
     model.commentCount = [MBNonEmptyString([dict objectForKey:@"commentCount"]) integerValue];

     model.readCount = [MBNonEmptyString([dict objectForKey:@"readCount"]) integerValue];
    return model;
    
   }
@end
