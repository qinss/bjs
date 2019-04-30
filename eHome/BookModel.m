//
//  BookModel.m
//  eHome
//
//  Created by 秦世帅 on 2017/9/19.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import "BookModel.h"
#import "BaseDefine.h"
@implementation BookModel

+(instancetype)makeModelWithDict:(NSDictionary *)dict{
    BookModel *model = [[BookModel alloc] init];
    model.name = MBNonEmptyString([dict objectForKey:@"name"]);
    model.author = MBNonEmptyString([dict objectForKey:@"author"]);
    model.press = MBNonEmptyString([dict objectForKey:@"press"]);
    model.publication_date = [[dict objectForKey:@"publication_date"] integerValue];
    model.blurb = MBNonEmptyString([dict objectForKey:@"blurb"]);
    model.reason= MBNonEmptyString([dict objectForKey:@"reason"]);
    model.review = MBNonEmptyString([dict objectForKey:@"review"]);
    model.image = MBNonEmptyString([dict objectForKey:@"image"]);
    model.recommended =  MBNonEmptyString([dict objectForKey:@"recommend"]);
    model.book_id = MBNonEmptyString([dict objectForKey:@"book_id"]);
    return model;
}
@end
