//
//  BookModel.h
//  eHome
//
//  Created by 秦世帅 on 2017/9/19.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import "BaseModel.h"

@interface BookModel : BaseModel
@property(nonatomic,strong) NSString *name;
@property(nonatomic,strong) NSString *author;
@property(nonatomic,strong) NSString *press;
@property(nonatomic,assign) NSInteger publication_date;
@property(nonatomic,strong) NSString *blurb;
@property(nonatomic,strong) NSString *reason;
@property(nonatomic,strong) NSString *review;
@property(nonatomic,strong) NSString *image;
@property(nonatomic,strong) NSString *recommended;
@property(nonatomic,strong) NSString *book_id;

@end
