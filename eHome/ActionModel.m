//
//  ActionModel.m
//  eHome
//
//  Created by 秦世帅 on 2017/10/18.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import "ActionModel.h"

@implementation ActionModel


+(instancetype)makeModelWithDict:(NSDictionary *)dict{
    
    ActionModel *model = [[ActionModel alloc] init];
    model.action_id = [MBNonEmptyString([dict objectForKey:@"action_id"]) integerValue];
    model.image = MBNonEmptyString([dict objectForKey:@"image"]);
    model.title = MBNonEmptyString([dict objectForKey:@"title"]);
    model.content = MBNonEmptyString([dict objectForKey:@"content"]);
    model.date = [MBNonEmptyString([dict objectForKey:@"date"]) integerValue];
    return  model;
}

@end
