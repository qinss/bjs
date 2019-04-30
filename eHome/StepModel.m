//
//  StepModel.m
//  eHome
//
//  Created by 秦世帅 on 2017/10/13.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import "StepModel.h"

@implementation StepModel
//@property(nonatomic,strong)NSString *step_date;
//@property(nonatomic,strong)NSString *name;
//@property(nonatomic,strong)NSString *image;
//@property(nonatomic,assign) NSInteger step_count;
//@property(nonatomic,assign) NSInteger support_count;
//@property(nonatomic,assign) NSInteger if_support;

+(instancetype)makeModelWithDict:(NSDictionary *)dict{
    
    StepModel *model = [[StepModel alloc] init];
    model.step_date = MBNonEmptyString([dict objectForKey:@"step_date"]);
    model.name = MBNonEmptyString([dict objectForKey:@"name"]);
    model.image = MBNonEmptyString([dict objectForKey:@"image"]);
    model.step_count = [MBNonEmptyString([dict objectForKey:@"step_count"]) integerValue];
    model.support_count = [MBNonEmptyString([dict objectForKey:@"support_count"]) integerValue];
    model.if_support = [MBNonEmptyString([dict objectForKey:@"if_support"]) integerValue];
    model.ranking = [MBNonEmptyString([dict objectForKey:@"ranking"]) integerValue];
    model.step_id = [MBNonEmptyString([dict objectForKey:@"id"]) integerValue];
    return  model;
}
@end
