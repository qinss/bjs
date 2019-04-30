//
//  RecommendBookViewModel.h
//  eHome
//
//  Created by 秦世帅 on 2017/9/20.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import "EHomeViewModel.h"
#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,tag){
    
    tagAddBookSuccess = 0
};
@interface RecommendBookViewModel : EHomeViewModel
-(void)addBook:(UIImage *) img
          name:(NSString *) name
        author:(NSString *)author
         press:(NSString *)press
          date:(NSString *)date
         bulub:(NSString *)blurb
        reason:(NSString *)reason
        review:(NSString *)review;


@end
