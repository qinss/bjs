//
//  MessageModel.h
//  eHome
//
//  Created by 秦世帅 on 2017/10/20.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import "BaseModel.h"

@interface MessageModel : BaseModel
    @property(nonatomic,strong)NSString *title;
    @property(nonatomic,strong)NSString *content;
    @property(nonatomic,assign)NSInteger date;
@end
