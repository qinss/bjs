//
//  BannerModel.h
//  eHome
//
//  Created by 秦世帅 on 2017/9/15.
//  Copyright © 2017年 whsmwy. All rights reserved.
//


#import "BaseModel.h"
@interface BannerModel :BaseModel
@property(nonatomic,strong) NSString *image;
@property(nonatomic,strong) NSString *title;
@property(nonatomic,assign) NSInteger read_times;
@property(nonatomic,strong) NSString *content;

@end
