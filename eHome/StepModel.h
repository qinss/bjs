//
//  StepModel.h
//  eHome
//
//  Created by 秦世帅 on 2017/10/13.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import "BaseModel.h"

@interface StepModel : BaseModel

@property(nonatomic,strong)NSString *step_date;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *image;
@property(nonatomic,assign) NSInteger step_count;
@property(nonatomic,assign) NSInteger support_count;
@property(nonatomic,assign) NSInteger if_support;
@property(nonatomic,assign) NSInteger ranking;
@property(nonatomic,assign) NSInteger step_id;



@end
