//
//  DiscussionTableViewCell.h
//  eHome
//
//  Created by 秦世帅 on 2017/5/31.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentModel.h"
#import "UIImageView+WebCache.h"
@interface DiscussionTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblContent;
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblDate;
- (void)makeCellWithModel:(CommentModel *)model;
@end
