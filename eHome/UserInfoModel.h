//
//  UserInfoModel.h
//  eHome
//
//  Created by 秦世帅 on 2017/10/13.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "BaseModel.h"
@interface UserInfoModel : NSObject
@property(nonatomic,strong )NSString *name;
@property(nonatomic,strong) NSString *user_id;
@property(nonatomic,strong) NSString *image;
@property(nonatomic,assign) NSInteger gender;//0：男。1:女
@property(nonatomic,strong) NSString *postion;//职务
@property(nonatomic,strong) NSString *department;//科室
@property(nonatomic,strong) NSString *birthday;
@property(nonatomic,strong) NSString *email;
+(instancetype)makeModelWithDict:(NSDictionary *)dic;
@end
