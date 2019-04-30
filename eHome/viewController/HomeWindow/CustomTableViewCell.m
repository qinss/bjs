//
//  CustomTableViewCell.m
//  eHome
//
//  Created by 秦世帅 on 2017/5/26.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import "CustomTableViewCell.h"

@implementation CustomTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)makeCellWithModel:(InfoModel *)model{
    [self.img sd_setImageWithURL:[NSURL URLWithString:model.image]];
    self.lblTitle.text = model.title;
    self.lblSummary.text = model.info_summary;
     self.lblDate.text = [GlobalVariables unixTimeToBeiJingTime:@"yyyy-MM-dd" unixtime:model.date/1000];
}

@end
