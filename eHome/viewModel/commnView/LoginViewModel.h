//
//  LoginViewModel.h
//  eHome
//
//  Created by 秦世帅 on 2017/10/13.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import "EHomeViewModel.h"
#import "HealthyHelp.h"
typedef NS_ENUM(NSInteger,tag){
    
    tagLoginSuccess = 0,
    tagLoginFailure =1
};
@interface LoginViewModel : EHomeViewModel<SearchStepDelegate>

-(void)requestForLogin:(NSString *)username
              password:(NSString *)password
             messageID:(NSString *)messageID;
-(void)searchStep;
-(void)uplodaStep:(NSInteger)step;
@end
