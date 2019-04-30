//
//  DiscorveyModel.m
//  eHome
//
//  Created by 秦世帅 on 2017/10/9.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import "DiscorveyModel.h"

@implementation DiscorveyModel
+(instancetype)makeModelWithDict:(NSDictionary *)dict{
    
//    @property(nonatomic,assign) NSInteger dis_id;
//    @property(nonatomic,strong) NSString *dis_content;
//    @property(nonatomic,strong) NSString *dis_image;
//    @property(nonatomic,strong) NSString *name;
//    @property(nonatomic,assign) NSInteger dis_date;
    DiscorveyModel *model = [[DiscorveyModel alloc] init];
    model.dis_id = [MBNonEmptyString([dict objectForKey:@"dis_id"]) integerValue];
    model.dis_content = MBNonEmptyString([dict objectForKey:@"dis_content"]);
    model.dis_image = MBNonEmptyString([dict objectForKey:@"dis_image"]);
    model.name = MBNonEmptyString([dict objectForKey:@"name"]);
    model.dis_date = [MBNonEmptyString([dict objectForKey:@"dis_date"]) integerValue];
    model.commentArray = [dict objectForKey:@"commentList"];
     model.image = MBNonEmptyString([dict objectForKey:@"image"]) ;
    return  model;
}
@end
