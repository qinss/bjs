//
//  AddHappyLifeViewModel.h
//  eHome
//
//  Created by 秦世帅 on 2017/10/9.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import "EHomeViewModel.h"
#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,tag){
    
    tagAddSuccess = 0
};
@interface AddHappyLifeViewModel : EHomeViewModel
-(void)addDiscorveys:(NSArray *) imgArr
            content:(NSString *)content;
@end
