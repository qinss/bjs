//
//  PassEnentTableViewCell.h
//  eHome
//
//  Created by 秦世帅 on 2017/6/5.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActionModel.h"
@interface PassEnentTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *btnSuggestion;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *lblContent;
- (void)makeCellWithModel:(ActionModel *)model;
@end
