//
//  DiscussionViewModel.h
//  eHome
//
//  Created by 秦世帅 on 2017/5/31.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import "EHomeViewModel.h"
typedef NS_ENUM(NSInteger,tag){
    
    tagGetCommentListSuccess = 0
};
@interface DiscussionViewModel : EHomeViewModel
@property(nonatomic,strong) NSMutableArray *dataArr;
@property(nonatomic,assign) NSInteger totalPage;
-(void)requestInfo:(NSInteger)page;
@end
