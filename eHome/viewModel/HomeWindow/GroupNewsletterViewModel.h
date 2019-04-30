//
//  GroupNewsletterViewModel.h
//  eHome
//
//  Created by 秦世帅 on 2017/9/15.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import "EHomeViewModel.h"
#import "HealthyHelp.h"
typedef NS_ENUM(NSInteger,tag){
    
    tagGetBannerSuccess = 0,
    tagGetInfoListSuccess = 1
};
@interface GroupNewsletterViewModel : EHomeViewModel<SearchStepDelegate>
@property(nonatomic,strong) NSMutableArray *titleArr;
@property(nonatomic,strong) NSMutableArray *imageUrlArr;
@property(nonatomic,strong) NSMutableArray *dataArr;
@property(nonatomic,assign) NSInteger totalPage;
-(void)requestBanner;
-(void)requestInfo:(NSInteger)page;
-(void)searchStep;
-(void)uplodaStep:(NSInteger)step;
@end
