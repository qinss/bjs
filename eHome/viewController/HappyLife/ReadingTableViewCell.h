//
//  ReadingTableViewCell.h
//  eHome
//
//  Created by 秦世帅 on 2017/5/31.
//  Copyright © 2017年 whsmwy. All rights reserved.
//
#import "BookModel.h"
#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"
@interface ReadingTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblAuthor;
@property (weak, nonatomic) IBOutlet UILabel *lblRecommened;
@property (weak, nonatomic) IBOutlet UILabel *lblContent;
- (void)makeCellWithModel:(BookModel *)model;
@end
