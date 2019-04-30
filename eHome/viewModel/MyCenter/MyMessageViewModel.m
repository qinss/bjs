//
//  MyMessageViewModel.m
//  eHome
//
//  Created by 秦世帅 on 2017/10/20.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import "MyMessageViewModel.h"
#import "HttpCenterModel.h"
@implementation MyMessageViewModel
-(void)requestInfo:(NSInteger)page{
    NSMutableDictionary  *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@(page) forKey:@"page"];
    [dic setObject:@(10) forKey:@"pagesize"];
    if (self.dataArr == nil) {
        self.dataArr = [[NSMutableArray alloc] init];
    }

    [HttpCenterModel requestMessageList :dic success:^(NSArray *dataArr,NSInteger totalPage){
        self.totalPage = totalPage;
        [self callBackWithData:dataArr tag:0];
    }];
    
}
@end
