//
//  AddDiscussViewModel.h
//  eHome
//
//  Created by 秦世帅 on 2017/9/27.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import "EHomeViewModel.h"
typedef NS_ENUM(NSInteger,tag){
    
    tagAddCommentSuccess = 0
};
@interface AddDiscussViewModel : EHomeViewModel
-(void)requestAddComment:(NSInteger)comment_infoid
                    type:(NSInteger)type
                 content:(NSString *)content;
@end
