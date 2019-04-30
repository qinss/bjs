//
//  BannerModel.m
//  eHome
//
//  Created by 秦世帅 on 2017/9/15.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import "BannerModel.h"
#import "BaseDefine.h"
@implementation BannerModel
+(instancetype)makeModelWithDict:(NSDictionary *)dict{
    BannerModel *model = [[BannerModel alloc] init];
    model.image = MBNonEmptyString([dict objectForKey:@"image"]);
    model.title = MBNonEmptyString([dict objectForKey:@"title"]);
    model.read_times = [[dict objectForKey:@"read_times"] integerValue];
    model.content = [dict objectForKey:@"content"];
    return model;
}
@end
