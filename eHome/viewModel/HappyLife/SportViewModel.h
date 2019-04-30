//
//  SportViewModel.h
//  eHome
//
//  Created by 秦世帅 on 2017/10/12.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import "EHomeViewModel.h"
typedef NS_ENUM(NSInteger,tag){
    
    tagGetRankingListSuccess = 0
};
@interface SportViewModel : EHomeViewModel
-(void)requestInfo;
@property(nonatomic,strong) NSMutableArray *dataArr;
@end
