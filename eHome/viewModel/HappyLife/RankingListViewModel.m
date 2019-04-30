//
//  RankingListViewModel.m
//  eHome
//
//  Created by 秦世帅 on 2017/10/12.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import "RankingListViewModel.h"
#import "HttpHappyLifeModel.h"
@implementation RankingListViewModel
-(void)requestInfo:(NSInteger)page date:(NSString *)date{
    
    NSMutableDictionary  *dic = [[NSMutableDictionary alloc] init];
   
    [dic setObject:date forKey:@"date"];
    [dic setObject:@(page) forKey:@"page"];
    [dic setObject:@(10) forKey:@"pagesize"];
    
    if (self.dataArr == nil) {
        self.dataArr = [[NSMutableArray alloc] init];
    }
   
    [HttpHappyLifeModel requestRankList:dic success:^(NSMutableArray *dataArr,NSInteger totalPage){
    
        self.totalPage = totalPage;
        [self callBackWithData:dataArr tag:tagGetListSuccess];
    
    }];
    
    
    
}
-(void)requestAddSupport:(NSInteger)step_id{
    
    NSMutableDictionary  *dic = [[NSMutableDictionary alloc] init];
    
    [dic setObject:@(step_id) forKey:@"id"];
    [HttpHappyLifeModel requestAddSupport:dic success:^(){
        [self callBackWithData:@(step_id) tag:tagAddSupportSuccess];
    }];
    
    
}
@end
