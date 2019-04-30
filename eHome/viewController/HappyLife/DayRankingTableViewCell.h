//
//  DayRankingTableViewCell.h
//  eHome
//
//  Created by 秦世帅 on 2017/5/27.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DayRankingTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblDate;
@property (weak, nonatomic) IBOutlet UILabel *lblStepCount;
@property (weak, nonatomic) IBOutlet UILabel *lblRanking;
-(void)makeCellWithDic:(NSDictionary *)dic;
@end
