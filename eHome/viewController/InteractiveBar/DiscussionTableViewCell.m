//
//  DiscussionTableViewCell.m
//  eHome
//
//  Created by 秦世帅 on 2017/5/31.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import "DiscussionTableViewCell.h"

@implementation DiscussionTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)makeCellWithModel:(CommentModel *)model{
    NSString *url = [NSString stringWithFormat:@"%@%@",DefaultUrl,model.image];
    [self.img sd_setImageWithURL:[NSURL URLWithString: url] placeholderImage:[UIImage imageNamed:@"bar10"]];
    self.lblContent.text = model.comment_content;
    self.lblName.text = model.name;
    self.lblDate.text = [GlobalVariables unixTimeToBeiJingTime:@"yyyy-MM-dd hh:mm" unixtime:model.comment_date/1000];
}

@end
