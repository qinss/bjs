//
//  CustomTableViewCell.h
//  eHome
//
//  Created by 秦世帅 on 2017/5/26.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InfoModel.h"
#import "UIImageView+WebCache.h"
#import "GlobalVariables.h"
@interface CustomTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *lblSummary;
@property (weak, nonatomic) IBOutlet UILabel *lblDate;
- (void)makeCellWithModel:(InfoModel *)model;
@end
