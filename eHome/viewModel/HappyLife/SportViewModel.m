//
//  SportViewModel.m
//  eHome
//
//  Created by 秦世帅 on 2017/10/12.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import "SportViewModel.h"
#import "HttpHappyLifeModel.h"
@implementation SportViewModel
-(void)requestInfo{
    if (self.dataArr == nil) {
        self.dataArr = [[NSMutableArray alloc] init];
    }
    [HttpHappyLifeModel requestUserStepRankingList:^(NSArray *arr){
        [self callBackWithData:arr tag:tagGetRankingListSuccess];
    }];
    
    
    
}
@end
