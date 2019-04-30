//
//  HealthyHelp.h
//  BaoJin
//
//  Created by 秦世帅 on 2016/11/1.
//  Copyright © 2016年 sensu_nikun. All rights reserved.
//
#import "AppDelegate.h"
#import <CoreMotion/CoreMotion.h>
#import <Foundation/Foundation.h>
#import <HealthKit/HealthKit.h>
//#import "GtSdkLib/GTSDK.framework/GTSDK"
typedef void(^PermissionBlock)();
typedef void (^SearchSuccessBlock)(NSInteger setp);
typedef NS_ENUM(NSInteger,typeTag) {
    /// 普通的实名认证
    tagSetp = 100,
    tagDistince = 101 ,
    tagActiveEnergy = 102
        
};
@protocol SearchStepDelegate <NSObject>

@required
-(void)searchFinish:(NSInteger)tag
               data:(NSInteger)data;
@end



@interface HealthyHelp : NSObject
@property(nonatomic,strong)CMPedometer *pedometer;
@property (nonatomic,strong) HKHealthStore *healthStore;
@property (nonatomic,strong) SearchSuccessBlock searchSuccessBlock;
@property (nonatomic,assign) id <SearchStepDelegate> searchStepDelegete;
-(BOOL)deviceSupport;
-(void)healthyKitPermissionWithStep:(PermissionBlock) successblock
               failureBlock:(PermissionBlock) failureblock;
//-(void)healthyKitPermissionWithDistince:(PermissionBlock)successBlock
//                           failureBlock:(PermissionBlock)failureblock;
-(void)getStepWithDay:(NSInteger)day;
-(void)updateSteps;
-(void)getActiveEnergy;
//-(void)getDistance;
@property(nonatomic,assign)NSInteger days;

@property(nonatomic,strong) NSMutableArray *stepArr;
@end
