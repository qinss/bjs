//
//  ActionModel.h
//  eHome
//
//  Created by 秦世帅 on 2017/10/18.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import "BaseModel.h"

@interface ActionModel : BaseModel
@property(nonatomic,assign) NSInteger action_id;
@property(nonatomic,strong)NSString *image;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *content;
@property(nonatomic,assign) NSInteger date;
@end
