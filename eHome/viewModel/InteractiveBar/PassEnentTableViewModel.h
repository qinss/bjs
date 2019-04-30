//
//  PassEnentTableViewModel.h
//  eHome
//
//  Created by 秦世帅 on 2017/10/18.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import "EHomeViewModel.h"

@interface PassEnentTableViewModel : EHomeViewModel
@property(nonatomic,strong) NSMutableArray *dataArr;
@property(nonatomic,assign) NSInteger totalPage;
-(void)requestInfo:(NSInteger)page;
@end
