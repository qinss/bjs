//
//  RankingListViewModel.h
//  eHome
//
//  Created by 秦世帅 on 2017/10/12.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import "EHomeViewModel.h"
typedef NS_ENUM(NSInteger,tag){
    
    tagGetListSuccess = 0,
    tagAddSupportSuccess = 1

};
@interface RankingListViewModel : EHomeViewModel
@property(nonatomic,strong) NSMutableArray *dataArr;
@property(nonatomic,assign) NSInteger totalPage;
-(void)requestInfo:(NSInteger)page date:(NSString *)date;
-(void)requestAddSupport:(NSInteger)step_id;


@end
