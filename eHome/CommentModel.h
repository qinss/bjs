//
//  CommentModel.h
//  eHome
//
//  Created by 秦世帅 on 2017/9/28.
//  Copyright © 2017年 whsmwy. All rights reserved.
//


#import "BaseModel.h"

@interface CommentModel : BaseModel
@property(nonatomic,strong) NSString *comment_id;
@property(nonatomic,strong) NSString *comment_type;
@property(nonatomic,strong) NSString *name;
@property(nonatomic,strong) NSString *comment_content;
@property(nonatomic,assign) NSInteger comment_date;
@property(nonatomic,strong) NSString *image;
@end
