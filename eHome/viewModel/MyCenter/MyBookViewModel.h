//
//  MyBookViewModel.h
//  eHome
//
//  Created by 秦世帅 on 2017/10/16.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import "EHomeViewModel.h"

@interface MyBookViewModel : EHomeViewModel
@property(nonatomic,strong) NSMutableArray *dataArr;
@property(nonatomic,assign) NSInteger totalPage;
@property(nonatomic,strong) NSString *title;
-(void)requestInfo:(NSInteger)page;
@end
