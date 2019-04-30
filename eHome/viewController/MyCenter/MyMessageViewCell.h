//
//  MyMessageViewCell.h
//  eHome
//
//  Created by 秦世帅 on 2017/10/20.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageModel.h"
@interface MyMessageViewCell : UITableViewCell
    @property (weak, nonatomic) IBOutlet UILabel *lblTitle;
    @property (weak, nonatomic) IBOutlet UILabel *lblContent;
    @property (weak, nonatomic) IBOutlet UILabel *lblDate;
- (void)makeCellWithModel:(MessageModel *)model;
@end
