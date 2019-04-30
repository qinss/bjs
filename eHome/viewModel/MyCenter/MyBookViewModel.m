//
//  MyBookViewModel.m
//  eHome
//
//  Created by 秦世帅 on 2017/10/16.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import "MyBookViewModel.h"
#import "HttpCenterModel.h"
@implementation MyBookViewModel
-(void)requestInfo:(NSInteger)page{
    NSMutableDictionary  *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@(page) forKey:@"page"];
    [dic setObject:@(10) forKey:@"pagesize"];
    if ([self.title isEqualToString:@"我的点赞好书"]) {
        [dic setObject:@(2) forKey:@"type"];
    }
    else if([self.title isEqualToString:@"我的好书收藏"]){
        [dic setObject:@(1) forKey:@"type"];
    }
    else if([self.title isEqualToString:@"我的好书推荐"]){
        [dic setObject:@(3) forKey:@"type"];
    }
    if (self.dataArr == nil) {
        self.dataArr = [[NSMutableArray alloc] init];
    }
    [HttpCenterModel requestCollectionBookList:dic success:^(NSArray *dataArr,NSInteger totalPage){
        self.totalPage = totalPage;
        [self callBackWithData:dataArr tag:0];
    }];
 
}
@end
