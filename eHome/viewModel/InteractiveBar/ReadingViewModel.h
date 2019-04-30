//
//  ReadingViewModel.h
//  eHome
//
//  Created by 秦世帅 on 2017/9/19.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import "EHomeViewModel.h"
#import "BookModel.h"
typedef NS_ENUM(NSInteger,tag){
    
    tagGetBookListSuccess = 0
};
@interface ReadingViewModel : EHomeViewModel
@property(nonatomic,strong) NSMutableArray *dataArr;
@property(nonatomic,assign) NSInteger totalPage;
-(void)requestInfo:(NSInteger)page;

@end
