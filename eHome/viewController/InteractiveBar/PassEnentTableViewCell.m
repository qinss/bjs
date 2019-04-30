//
//  PassEnentTableViewCell.m
//  eHome
//
//  Created by 秦世帅 on 2017/6/5.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import "PassEnentTableViewCell.h"

@implementation PassEnentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)makeCellWithModel:(ActionModel *)model{
    self.lblTitle.text = model.title;
    self.img.image = [UIImage imageNamed:defaultHeaderImage];
    
    self.lblContent.text = model.content;
    
}
@end
