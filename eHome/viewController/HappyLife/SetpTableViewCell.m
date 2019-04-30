//
//  SetpTableViewCell.m
//  eHome
//
//  Created by 秦世帅 on 2017/6/1.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import "SetpTableViewCell.h"
#import "UIImageView+WebCache.h"
@implementation SetpTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.btnSupport setBackgroundImage:[UIImage imageNamed:@"icon_support_red"] forState:UIControlStateSelected];
    [self.btnSupport setBackgroundImage:[UIImage imageNamed:@"icon_support_gray"] forState:UIControlStateNormal];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)makeCellWithDic:(StepModel *)model{
    
    NSString *url = [NSString stringWithFormat:@"%@%@",DefaultUrl,model.image];
    [_img sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:defaultHeaderImage]];
    
    _lblRanking.text = [NSString stringWithFormat:@"%ld",model.ranking];
    _lblName.text = model.name;
    _lblSetpCount.text = [NSString stringWithFormat:@"%ld步",model.step_count];
    _lblSupportCount.text = [NSString stringWithFormat:@"%ld",model.support_count];
    _btnSupport.selected = model.if_support;

}

@end
