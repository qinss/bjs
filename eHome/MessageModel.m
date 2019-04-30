//
//  MessageModel.m
//  eHome
//
//  Created by 秦世帅 on 2017/10/20.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import "MessageModel.h"

@implementation MessageModel
+(instancetype)makeModelWithDict:(NSDictionary *)dict{
    
    MessageModel *model = [[MessageModel alloc] init];
    model.title = MBNonEmptyString([dict objectForKey:@"title"]);
    model.content = MBNonEmptyString([dict objectForKey:@"content"]);
    model.date = [MBNonEmptyString([dict objectForKey:@"date"]) integerValue];
    return  model;
}
@end
