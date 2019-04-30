//
//  CommonListViewModel.m
//  eHome
//
//  Created by 秦世帅 on 2017/9/18.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import "CommonListViewModel.h"
#import "HttpCommonModel.h"

@implementation CommonListViewModel
-(void)requestInfo:(NSInteger)page{
    NSMutableDictionary  *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@(page) forKey:@"page"];
    [dic setObject:@(10) forKey:@"pagesize"];
    int type = -1;
    if ([self.title isEqualToString:@"政经要点"]) {
        type = 0;
    }
    else if ([self.title isEqualToString:@"党性修养"]){
        type = 1;
    }
    else if ([self.title isEqualToString:@"精彩网视"]){
        type = 2;
    }
    else if ([self.title isEqualToString:@"组工简讯"]){
        type = 3;
    }
    
    else if ([self.title isEqualToString:@"每日动态"]){
        type = 4;
    }
    else if ([self.title isEqualToString:@"要闻速递"]){
        type = 5;
    }
    else if ([self.title isEqualToString:@"组工讲堂"]){
        type = 6;
    }
    else if ([self.title isEqualToString:@"我的文章收藏"]){
        
        type = 7;
    }
    else if ([self.title isEqualToString:@"我的点赞文章"]){
        
        type = 8;
    }

    [dic setObject:@(type) forKey:@"info_type"];
    if (self.dataArr == nil) {
        self.dataArr = [[NSMutableArray alloc] init];
    }
    [HttpCommonModel requestInfoList:dic success:^(NSArray *dataArr,NSInteger totalPage){
        self.totalPage = totalPage;
        [self callBackWithData:dataArr tag:tagGetInfoListSuccess];
    }];
}
@end
