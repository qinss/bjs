//
//  InfoModel.m
//  eHome
//
//  Created by 秦世帅 on 2017/9/15.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import "InfoModel.h"

@implementation InfoModel
+(instancetype)makeModelWithDict:(NSDictionary *)dict{
    
    
    InfoModel *model = [[InfoModel alloc] init];
    model.info_id = [[dict objectForKey:@"info_id"] integerValue];
    model.image = [dict objectForKey:@"info_image"];
    model.content = [dict objectForKey:@"content"];
    model.title = [dict objectForKey:@"info_title"];
    model.read_times = [[dict objectForKey:@"read_times"] integerValue];
    model.info_summary = [dict objectForKey:@"info_summary"];
    model.date = [[dict objectForKey:@"info_date"] integerValue];
    return model;
}
@end
