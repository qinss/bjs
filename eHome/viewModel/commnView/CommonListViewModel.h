//
//  CommonListViewModel.h
//  eHome
//
//  Created by 秦世帅 on 2017/9/18.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import "HttpServer.h"
#import "EHomeViewModel.h"
typedef NS_ENUM(NSInteger,tag){
    
    tagGetBannerSuccess = 0,
    tagGetInfoListSuccess = 1
};
@interface CommonListViewModel : EHomeViewModel
@property(nonatomic,strong) NSMutableArray *dataArr;
@property(nonatomic,assign) NSInteger totalPage;
@property(nonatomic,strong) NSString *title;
-(void)requestInfo:(NSInteger)page;

@end
