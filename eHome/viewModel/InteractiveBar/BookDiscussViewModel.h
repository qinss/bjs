//
//  BookDiscussViewModel.h
//  eHome
//
//  Created by 秦世帅 on 2017/9/28.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import "EHomeViewModel.h"
typedef NS_ENUM(NSInteger,tag){
    
    tagGetCommentListSuccess = 0
};
@interface BookDiscussViewModel : EHomeViewModel
@property(nonatomic,strong) NSMutableArray *dataArr;
@property(nonatomic,assign) NSInteger totalPage;
-(void)requestInfo:(NSInteger)page
           book_id:(NSInteger)book_id;
@end
