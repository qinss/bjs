//
//  UserInfoModel.m
//  eHome
//
//  Created by 秦世帅 on 2017/10/13.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import "UserInfoModel.h"

@implementation UserInfoModel

//@property(nonatomic,strong )NSString *name;
//@property(nonatomic,strong) NSString *user_id;
//@property(nonatomic,strong) NSString *image;
//@property(nonatomic,assign) NSInteger gender;//0：男。1:女
//@property(nonatomic,strong) NSString *postion;//职务
//@property(nonatomic,strong) NSString *department;//科室
//@property(nonatomic,strong) NSString *birthday;
//@property(nonatomic,strong) NSString *email;

+(instancetype)makeModelWithDict:(NSDictionary *)dict{
    UserInfoModel *model = [[UserInfoModel alloc] init];
    model.name = [dict objectForKey:@"name"];
    model.user_id = [dict objectForKey:@"id"];
    model.image = [dict objectForKey:@"image"];
    
    
    model.gender = [[dict objectForKey:@"gender"] integerValue];
    model.postion = NonEmptyString([dict objectForKey:@"postion"]
                                   );
    model.department =NonEmptyString([dict objectForKey:@"department"]) ;
    model.birthday = [dict objectForKey:@"birthday"];
    model.email = [dict objectForKey:@"email"];
    return model;
}
NSString* NonEmptyString(id obj){
    
    if (obj == nil || obj == [NSNull null] ||
        ([obj isKindOfClass:[NSString class]] && [obj length] == 0)) {
        return @"";
    } else if ([obj isKindOfClass:[NSNumber class]]) {
        return NonEmptyString([obj stringValue]);
    }
    return obj;
}
@end
