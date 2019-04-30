//
//  BookDiscussViewModel.m
//  eHome
//
//  Created by 秦世帅 on 2017/9/28.
//  Copyright © 2017年 whsmwy. All rights reserved.
//
#import "HttpCommonModel.h"
#import "BookDiscussViewModel.h"

@implementation BookDiscussViewModel
-(void)requestInfo:(NSInteger)page
           book_id:(NSInteger)book_id{
    NSMutableDictionary  *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@(page) forKey:@"page"];
    [dic setObject:@(10) forKey:@"pagesize"];
    [dic setObject:@(3) forKey:@"type"];
    [dic setObject:@(book_id) forKey:@"info_id"];
    if (self.dataArr == nil) {
        self.dataArr = [[NSMutableArray alloc] init];
    }
    [HttpCommonModel requestCommentList:dic success:^(NSArray *dataArr,NSInteger totalPage){
        self.totalPage = totalPage;
        [self callBackWithData:dataArr tag:tagGetCommentListSuccess];}];
}
@end
