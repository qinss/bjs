//
//  HttpHomeWindowModel.m
//  eHome
//
//  Created by 秦世帅 on 2017/9/15.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import "HttpHomeWindowModel.h"

@implementation HttpHomeWindowModel
+(void) requestBankList:(void(^)(NSMutableArray *dataArr))success{
    [AFNetWorkingAPI getHttp:GetBannerList parameters:nil showHUD:NO success:^(NSDictionary *responseDic){
        NSMutableArray *arrs = [[NSMutableArray alloc] init];
        NSDictionary *data = [responseDic objectForKey:@"responseData"];
        NSArray *bannerArr = [data objectForKey:@"list"];
        for (NSDictionary *bankListDic in bannerArr)
        {
            BannerModel *model = [BannerModel makeModelWithDict:bankListDic];
            [arrs addObject:model];
        }
            success(arrs);

    } failure:^(NSString *message,NSInteger statusCode){
    }];
}
+(void)uploadStep:(NSMutableDictionary *)param
{
    [AFNetWorkingAPI getHttp:sendStepCount parameters:param showHUD:NO success:^(NSDictionary *responseDic){
        
        
    } failure:^(NSString *message,NSInteger statusCode){
    }];
}
@end
