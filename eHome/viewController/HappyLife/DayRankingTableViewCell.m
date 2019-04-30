//
//  DayRankingTableViewCell.m
//  eHome
//
//  Created by 秦世帅 on 2017/5/27.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import "DayRankingTableViewCell.h"

@implementation DayRankingTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)makeCellWithDic:(NSDictionary *)dic{
    NSInteger step = [[dic objectForKey:@"step"] integerValue];
    NSInteger number = [[dic objectForKey:@"number"] integerValue];
    NSString *date = [dic objectForKey:@"date"] ;
    self.lblStepCount.text = [NSString stringWithFormat:@"%ld",step] ;
    self.lblRanking.text = [NSString stringWithFormat:@"%ld",number] ;
//
    NSDate *newdate = [self stringToDate:date withDateFormat:@"yyyy-MM-dd"];
    NSString *str = [self dateToString:newdate withDateFormat:@"MM月dd日"];
    self.lblDate.text = [NSString stringWithFormat:@"查看%@排行榜",str];
    
    
}


//日期格式转字符串
- (NSString *)dateToString:(NSDate *)date withDateFormat:(NSString *)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    NSString *strDate = [dateFormatter stringFromDate:date];
    return strDate;
}

//字符串转日期格式
- (NSDate *)stringToDate:(NSString *)dateString withDateFormat:(NSString *)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    NSDate *date = [dateFormatter dateFromString:dateString];
    return [self worldTimeToChinaTime:date];
}

//将世界时间转化为中国区时间
- (NSDate *)worldTimeToChinaTime:(NSDate *)date
{
    NSTimeZone *timeZone = [NSTimeZone systemTimeZone];
    NSInteger interval = [timeZone secondsFromGMTForDate:date];
    NSDate *localeDate = [date  dateByAddingTimeInterval:interval];
    return localeDate;
}

@end
