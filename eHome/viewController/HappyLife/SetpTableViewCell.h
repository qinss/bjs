//
//  SetpTableViewCell.h
//  eHome
//
//  Created by 秦世帅 on 2017/6/1.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StepModel.h"
@interface SetpTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblRanking;
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblSetpCount;
@property (weak, nonatomic) IBOutlet UILabel *lblSupportCount;
@property (weak, nonatomic) IBOutlet UIButton *btnSupport;
-(void)makeCellWithDic:(StepModel *)model;
@end
