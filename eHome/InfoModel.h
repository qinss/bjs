//
//  InfoModel.h
//  eHome
//
//  Created by 秦世帅 on 2017/9/15.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import "BaseModel.h"

@interface InfoModel : BaseModel

//info_type 0:正经热点 1:党性修养 2:精彩 视 3:组 简讯 4:每 动态 5:要闻速递 6:组 讲堂
@property(nonatomic,assign) NSInteger info_id;
@property(nonatomic,strong) NSString *image;
@property(nonatomic,strong) NSString *url;
@property(nonatomic,strong) NSString *content;
@property(nonatomic,strong) NSString *title;
@property(nonatomic,assign) NSInteger read_times;
@property(nonatomic,strong) NSString *info_summary;
@property(nonatomic,assign) NSInteger date;

@end
