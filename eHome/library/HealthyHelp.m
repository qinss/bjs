//
//  HealthyHelp.m
//  BaoJin
//
//  Created by 秦世帅 on 2016/11/1.
//  Copyright © 2016年 sensu_nikun. All rights reserved.
//

#import "HealthyHelp.h"
#import "GlobalVariables.h"
#import "AFNetWorkingAPI.h"
@implementation HealthyHelp
static HealthyHelp *_instance = nil;

- (instancetype)init
{
    if (self = [super init]) {
        self.healthStore = [[HKHealthStore alloc] init];
    }
    return self;
}
-(BOOL)deviceSupport{
    return [HKHealthStore isHealthDataAvailable];
}

-(void)healthyKitPermissionWithStep:(PermissionBlock)successBlock
failureBlock:(PermissionBlock)failureblock
{
    HKObjectType *stepType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    NSSet *healthSet2 = [NSSet setWithObjects:stepType, nil];
    [_healthStore requestAuthorizationToShareTypes:nil readTypes:healthSet2 completion:^(BOOL success, NSError * _Nullable error) {
    
        if (success)
        {
            if (successBlock)
            {
                successBlock();
            }
        }
        else{
            if (failureblock)
            {
                failureblock();
            }
        }
    }];
}

-(void)getStepWithDay:(NSInteger)day {
    //查询采样信息
    HKSampleType *sampleType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    //NSSortDescriptor来告诉healthStore怎么样将结果排序
    NSSortDescriptor *start = [NSSortDescriptor sortDescriptorWithKey:HKSampleSortIdentifierStartDate ascending:NO];
    NSSortDescriptor *end = [NSSortDescriptor sortDescriptorWithKey:HKSampleSortIdentifierEndDate ascending:NO];
    //获取当前时间
  
    /*查询的基类是HKQuery，这是一个抽象类，能够实现每一种查询目标，这里我们需要查询的步数是一个HKSample类所以对应的查询类是HKSampleQuery。下面的limit参数传1表示查询最近一条数据，查询多条数据只要设置limit的参数值就可以了*/
    HKSampleQuery *sampleQuery = [[HKSampleQuery alloc]initWithSampleType:sampleType predicate:[self predicateForSamplesToday:day] limit:0 sortDescriptors:@[start,end] resultsHandler:^(HKSampleQuery * _Nonnull query, NSArray<__kindof HKSample *> * _Nullable results, NSError * _Nullable error) {

        NSInteger allStepCount = 0;
        NSMutableArray *dataArr = [[NSMutableArray alloc] init];
        for (int i = 0; i < results.count; i ++) {
            //把结果转换为字符串类型
            HKQuantitySample *result = results[i];
            HKQuantity *quantity = result.quantity;
            NSMutableString *stepCount = (NSMutableString *)quantity;
            NSString *stepStr =[ NSString stringWithFormat:@"%@",stepCount];
            //获取51 count此类字符串前面的数字
            NSString *str = [stepStr componentsSeparatedByString:@" "][0];
            NSDictionary *dict = (NSDictionary *)result.metadata;
            HKSource *source = result.source;
   
            NSInteger wasUserEntered = [dict[@"HKWasUserEntered"]integerValue];
            int stepNum =  [str intValue];
            NSLog(@"step:%d",stepNum);
            if(wasUserEntered == 1) //去除用户手动添加
            {
                stepNum = 0;
            }
            else{
                //此处 添加  进去
                NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
                [dic setObject:source.name forKey:@"name"];
                [dic setValue:@(stepNum) forKey:@"step"];
                [dataArr addObject:dic];
            }
        }
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        for (int i = 0; i < dataArr.count; i++) {
            NSDictionary * dataDic = [dataArr objectAtIndex:i];
            NSString *dataName = [dataDic objectForKey:@"name"];
            NSInteger step = [[dataDic objectForKey:@"step"] integerValue];
            NSInteger a = [[dic objectForKey:dataName] integerValue];
            [dic setValue:@(step+a) forKey:dataName];
        }
        if (dic.count > 0) {
            for (id key in dic) {
                NSInteger setp = [[dic objectForKey:key] integerValue];
                if (setp > allStepCount) {
                    allStepCount = setp;
                }
            }
        }
        else{
            allStepCount = 0;
        }
//        if(day == -1 && self.searchStepDelegete != nil)
//        {
            //此处 为 查询 当天步数
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [self.searchStepDelegete searchFinish:tagSetp data:allStepCount];
            }];
//        }
//        else {
//            if (self.stepArr == nil) {
//                self.stepArr = [[NSMutableArray alloc] init];
//            }
//            NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
//            [dic setObject:@([self getDayTimeStamp:day]) forKey:@"time"];
//            [dic setObject:@(allStepCount) forKey:@"step"];
//            [self.stepArr addObject:dic];
//            if (self.stepArr.count == self.days+1) {
//                //查询完毕  准备提交
//                [self uploadSteps];
//            }
//        }
    }];
    [self.healthStore executeQuery:sampleQuery];
}


-(void)updateSteps{
    
//    if (!IsLogin) {
//        return;
//    }
    //查询  上次 保存的 步数的  时间戳
    [self healthyKitPermissionWithStep:^(){
       
     NSInteger timeStamp =  [GlobalVariables getStepTimeStamp];
    self.days = ([self getDayTimeStamp:0] - timeStamp) / 86400;
    
    if (self.days > 6){
        self.days = 6;
    }
        if (self.days == 0) {
            self.days ++;
        }
    for (NSInteger i = self.days; i >= 0; i--) {
        [self getStepWithDay:i];
    }

    } failureBlock:nil ];

    }
-(NSInteger )getDayTimeStamp:(NSInteger )day{
    
    NSDate *now = [NSDate date];
    NSCalendar *calender = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dateComponent = [calender components:unitFlags fromDate:now];
    int hour = (int)[dateComponent hour];
    int minute = (int)[dateComponent minute];
    int second = (int)[dateComponent second];
    NSDate *nowDay = [NSDate dateWithTimeIntervalSinceNow:  - (hour*3600 + minute * 60 + second) ];
    NSTimeInterval timeStamp = [nowDay timeIntervalSince1970] + 86400 / 2  - 86400 *day;
    return timeStamp;
}
-(void)uploadSteps{
    
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    [param setObject:self.stepArr forKey:@"steps"];
    
//    [AFNetWorkingAPI postHttp:uploadSetps([GlobalVariables userID]) showHUD:NO parameters:param success:^(NSMutableDictionary *responseDic)
//     {
//            [GlobalVariables setStepTimeStamp:[self getDayTimeStamp:0]];
// 
//         
//     } failure:^(NSString *message,NSInteger code)
//     {
//         
//         
//     }];
}
-(void)getActiveEnergy{
     __weak typeof   (&*_healthStore)weakHealthStore = _healthStore;
    HKSampleType *type4 = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierActiveEnergyBurned];
    NSSortDescriptor *start = [NSSortDescriptor sortDescriptorWithKey:HKSampleSortIdentifierStartDate ascending:NO];
    NSSortDescriptor *end = [NSSortDescriptor sortDescriptorWithKey:HKSampleSortIdentifierEndDate ascending:NO];
    HKSampleQuery *q4 = [[HKSampleQuery alloc] initWithSampleType:type4 predicate:[self predicateForSamplesToday:0] limit:HKObjectQueryNoLimit sortDescriptors:@[start,end] resultsHandler:^(HKSampleQuery * _Nonnull query, NSArray<__kindof HKSample *> * _Nullable results, NSError * _Nullable error) {
        
        double num = 0;
        
        for (HKQuantitySample *res in results)
            
        {
            num += [res.quantity doubleValueForUnit:[HKUnit kilocalorieUnit]];
        }
        if (self.searchStepDelegete) {
            [self.searchStepDelegete searchFinish:tagActiveEnergy data:num];
        }
        NSLog(@"卡路里===%@大卡", @((long)num));
        if(error) NSLog(@"4error==%@", error);
        [weakHealthStore stopQuery:query];
        NSLog(@"\n\n");
    }];
    [self.healthStore executeQuery:q4];
}

- (NSPredicate *)predicateForSamplesToday:(NSInteger )day {
   
    NSDate *now = [NSDate date];
    NSCalendar *calender = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dateComponent = [calender components:unitFlags fromDate:now];
    int hour = (int)[dateComponent hour];
    int minute = (int)[dateComponent minute];
    int second = (int)[dateComponent second];
   
    
    NSDate *nowDay = [NSDate dateWithTimeIntervalSinceNow:  - (hour*3600 + minute * 60 + second) - 86400 * day ];
      NSDate *nextDay = [NSDate dateWithTimeIntervalSinceNow:  - (hour*3600 + minute * 60 + second)  + 86400 - 86400 * day];
    //-1  查多天
    if (day == -1) {
       nowDay = [NSDate dateWithTimeIntervalSinceNow:  - (hour*3600 + minute * 60 + second) - 86400 * 3 ];
        nextDay = [NSDate dateWithTimeIntervalSinceNow:  - (hour*3600 + minute * 60 + second)  + 86400 ];
    }
    //    //时间结果与想象中不同是因为它显示的是0区
    NSLog(@"今天%@",nowDay);
    NSLog(@"hhh:%@",nextDay);
    NSPredicate *predicate = [HKQuery predicateForSamplesWithStartDate:nowDay endDate:nextDay options:(HKQueryOptionNone)];
    return predicate;
}
//
//-(void)gotoOpenStepCountFunction{
//    
//    _pedometer = [(AppDelegate *)[UIApplication sharedApplication].delegate sharedPedometer];
//    
//    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"startStepCount"];
//    [[NSUserDefaults standardUserDefaults] synchronize];
//    
//    if ([CMPedometer isStepCountingAvailable]) {
//        [_pedometer startPedometerUpdatesFromDate:[NSDate date] withHandler:^(CMPedometerData * _Nullable pedometerData, NSError * _Nullable error) {
//            
//            if (error) {
//                NSLog(@"error====%@",error);
//                
//                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"startStepCount"];
//                [[NSUserDefaults standardUserDefaults] synchronize];
//                
//            }else {
//                NSLog(@"BBB步数====%@",pedometerData.numberOfSteps);
//                NSLog(@"BBB距离====%@",pedometerData.distance);
//                
//                NSDictionary *dic =[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%@",pedometerData.numberOfSteps],@"numberOfSteps", nil];
//                [[NSNotificationCenter defaultCenter] postNotificationName:@"numberOfSteps" object:nil userInfo:dic];
//            }
//            
//        }];
//    }else{
//        
//        NSLog(@"计步器不可用");
//        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"startStepCount"];
//        [[NSUserDefaults standardUserDefaults] synchronize];
//    }
//}
//-(BOOL)ifCanUserHealthyKit{
//    
//    
//}
@end
