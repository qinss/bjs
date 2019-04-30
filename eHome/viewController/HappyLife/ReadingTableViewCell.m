//
//  ReadingTableViewCell.m
//  eHome
//
//  Created by 秦世帅 on 2017/5/31.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import "ReadingTableViewCell.h"
#import "UrlDefine.h"
@implementation ReadingTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)makeCellWithModel:(BookModel *)model{
    NSString *url = [NSString stringWithFormat:@"%@%@",DefaultUrl,model.image];
     [self.img sd_setImageWithURL:[NSURL URLWithString: url]];
    self.lblTitle.text = model.name;
    self.lblAuthor.text = [NSString stringWithFormat:@"作者: %@",model.author];
    self.lblRecommened.text = [NSString stringWithFormat:@"推荐者: %@",model.recommended];
    self.lblContent.text = model.blurb;
}
@end
