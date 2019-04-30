//
//  CommentModel.m
//  eHome
//
//  Created by 秦世帅 on 2017/9/28.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import "CommentModel.h"

@implementation CommentModel
+(instancetype)makeModelWithDict:(NSDictionary *)dict{
    CommentModel *model = [[CommentModel alloc] init];
    model.comment_id = MBNonEmptyString([dict objectForKey:@"comment_id"]);
     model.comment_type = MBNonEmptyString([dict objectForKey:@"comment_type"]);
     model.name = MBNonEmptyString([dict objectForKey:@"name"]);
     model.comment_content = MBNonEmptyString([dict objectForKey:@"comment_content"]);
     model.comment_date = [MBNonEmptyString([dict objectForKey:@"comment_date"]) integerValue];
     model.comment_id = MBNonEmptyString([dict objectForKey:@"comment_id"]);
     model.image = MBNonEmptyString([dict objectForKey:@"image"]);
    return  model;
}
@end
