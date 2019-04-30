//
//  ActionDetailViewModel.h
//  eHome
//
//  Created by 秦世帅 on 2017/10/18.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import "EHomeViewModel.h"
#import "CommentModel.h"
#define lblCommentFont 13.0
typedef NS_ENUM(NSInteger,tag){
    
    tagGetDetailSuccess = 0,
    tagChangeSupportSuccess = 1
};
@interface ActionDetailViewModel : EHomeViewModel
-(void)requestActionInfo:(NSInteger)action_id;
@property(nonatomic,assign)NSInteger supportCount;
@property(nonatomic,assign)NSInteger supportStatus;
@property(nonatomic,assign)NSInteger commentCount;
@property(nonatomic,strong)NSArray *commentList;
-(CGFloat) getLblCommentHeight:(NSDictionary *)commentDic;
-(NSString *) getLblCommentString:(NSDictionary *)commentDic;
-(void)changeSupport:(NSInteger )ststus
             book_id:(NSInteger) book_id;
@end
