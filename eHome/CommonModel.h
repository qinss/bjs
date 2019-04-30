//
//  CommonModel.h
//  eHome
//
//  Created by 秦世帅 on 2017/9/26.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import "BaseModel.h"

@interface CommonModel : BaseModel
@property(nonatomic,assign) NSInteger collectionStatus;
@property(nonatomic,assign) NSInteger supportCount;
@property(nonatomic,assign) NSInteger supportStatus;
@property(nonatomic,assign) NSInteger commentCount;
@property(nonatomic,assign) NSInteger readCount;
+(instancetype)makeModelWithDict:(NSDictionary *)dict;
@end
