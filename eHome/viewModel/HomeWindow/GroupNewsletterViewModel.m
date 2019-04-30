//
//  GroupNewsletterViewModel.m
//  eHome
//
//  Created by 秦世帅 on 2017/9/15.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import "GroupNewsletterViewModel.h"
#import "HttpHomeWindowModel.h"
#import "HttpCommonModel.h"


@implementation GroupNewsletterViewModel
-(void)requestBanner{
    [HttpHomeWindowModel requestBankList:^(NSMutableArray *dataArr){
        self.titleArr = nil;
        self.imageUrlArr = nil;
        self.titleArr = [[NSMutableArray alloc] init];
        self.imageUrlArr = [[NSMutableArray alloc] init];
        for (BannerModel *model in dataArr) {
            [self.titleArr addObject:model.title];
            [self.imageUrlArr addObject:model.image];
        }
        [self callBackWithData:nil tag:tagGetBannerSuccess];
    }];
}
-(void)requestInfo:(NSInteger)page{
    NSMutableDictionary  *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@(page) forKey:@"page"];
    [dic setObject:@(10) forKey:@"pagesize"];
    [dic setObject:@(3) forKey:@"info_type"];
    if (self.dataArr == nil) {
        self.dataArr = [[NSMutableArray alloc] init];
    }
    [HttpCommonModel requestInfoList:dic success:^(NSArray *dataArr,NSInteger totalPage){
     self.totalPage = totalPage;
    [self callBackWithData:dataArr tag:tagGetInfoListSuccess];
    }];
}
-(void)searchStep{
    HealthyHelp *healthyHelp = [[HealthyHelp alloc] init];
    healthyHelp.searchStepDelegete = self;
    [healthyHelp healthyKitPermissionWithStep:^(){
        [healthyHelp getStepWithDay:0];
    } failureBlock:^(){
    }];
}

-(void)searchFinish:(NSInteger)tag data:(NSInteger)data{
    
    [self uplodaStep:data];
}
-(void)uplodaStep:(NSInteger)step{
    
    NSMutableDictionary  *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@(step) forKey:@"stepCount"];
    [HttpHomeWindowModel uploadStep:dic];
}
@end
