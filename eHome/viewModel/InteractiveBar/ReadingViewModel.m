//
//  ReadingViewModel.m
//  eHome
//
//  Created by 秦世帅 on 2017/9/19.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import "ReadingViewModel.h"
#import "BookModel.h"
#import "HttpInteractiveBarModel.h"
@implementation ReadingViewModel
-(void)requestInfo:(NSInteger)page{
    NSMutableDictionary  *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@(page) forKey:@"page"];
    [dic setObject:@(10) forKey:@"pagesize"];
    
   
    if (self.dataArr == nil) {
        self.dataArr = [[NSMutableArray alloc] init];
    }
 

    [HttpInteractiveBarModel requestBookList:dic success:^(NSArray *dataArr,NSInteger totalPage){
        self.totalPage = totalPage;
        [self callBackWithData:dataArr tag:tagGetBookListSuccess];
    }];

}

@end
