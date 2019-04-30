//
//  MyMessageViewCell.m
//  eHome
//
//  Created by 秦世帅 on 2017/10/20.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import "MyMessageViewCell.h"

@implementation MyMessageViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)makeCellWithModel:(MessageModel *)model{
    
        self.lblTitle.text = model.title;
        
        self.lblContent.text = model.content;
        self.lblDate.text = [GlobalVariables unixTimeToBeiJingTime:@"yyyy-MM-dd hh:mm" unixtime:model.date/1000];

    }

@end
