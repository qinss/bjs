//
//  BookDetailViewModel.m
//  eHome
//
//  Created by 秦世帅 on 2017/9/26.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import "BookDetailViewModel.h"
#import "HttpInteractiveBarModel.h"
#import "HttpCommonModel.h"
@implementation BookDetailViewModel
-(void)requestBookInfo:(NSString *)bookId{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:bookId forKey:@"id"];
    [HttpInteractiveBarModel requestBookInfo:dic success:^(CommonModel *model){
        [self callBackWithData:model tag:tagGetInfoSuccess];
    }];
}
-(void)changeCollection:(NSInteger )ststus
                book_id:(NSInteger) book_id{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@(ststus) forKey:@"status"];
    [dic setObject:@(book_id) forKey:@"id"];
    [dic setObject:@(1) forKey:@"type"];
    
    [HttpCommonModel requestChangeCollection:dic success:^(){
    
        [self callBackWithData:nil tag:tagChangeCollectionSuccess];
    }];
}
-(void)changeSupport:(NSInteger )ststus
             book_id:(NSInteger) book_id{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@(ststus) forKey:@"status"];
    [dic setObject:@(book_id) forKey:@"id"];
    [dic setObject:@(2) forKey:@"type"];
    [HttpCommonModel requestChangeSupport:dic success:^(){
        
        [self callBackWithData:nil tag:tagChangeSupportSuccess];
    }];
}
@end
