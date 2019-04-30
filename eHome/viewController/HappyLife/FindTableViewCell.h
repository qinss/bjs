//
//  FindTableViewCell.h
//  eHome
//
//  Created by 秦世帅 on 2017/5/26.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FindTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblContent;
@property (weak, nonatomic) IBOutlet UIButton *btnSearch;
@property (strong, nonatomic) UIView *viewContent;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
    @property (weak, nonatomic) IBOutlet UIImageView *img;

@end
