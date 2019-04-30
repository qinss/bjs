//
//  DiscorveyModel.h
//  eHome
//
//  Created by 秦世帅 on 2017/10/9.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import "BaseModel.h"

@interface DiscorveyModel : BaseModel
@property(nonatomic,assign) NSInteger dis_id;
@property(nonatomic,strong) NSString *dis_content;
@property(nonatomic,strong) NSString *dis_image;
@property(nonatomic,strong) NSString *name;
@property(nonatomic,assign) NSInteger dis_date;
@property(nonatomic,strong) NSArray *commentArray;
    @property(nonatomic,strong) NSString *image;
//@property(nonatomic,assign) NSInteger supportCount;
//@property(nonatomic,assign) NSInteger commentCount;
@end
