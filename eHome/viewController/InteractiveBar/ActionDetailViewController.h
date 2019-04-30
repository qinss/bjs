//
//  ActionDetailViewController.h
//  eHome
//
//  Created by 秦世帅 on 2017/10/18.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import "BasicViewController.h"
#import "ActionModel.h"
#import "BasicTableViewController.h"
@interface ActionDetailViewController :BasicTableViewController
- (IBAction)btnSupportTouchUpInside:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *lblDate;
@property(nonatomic,assign) ActionModel *actionModel;
@property (weak, nonatomic) IBOutlet UIButton *btnSupport;
@property (weak, nonatomic) IBOutlet UIButton *btnComment;
- (IBAction)btnCommentTouchUpInside:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *lblSupportCount;
@property (weak, nonatomic) IBOutlet UILabel *lblCommentCount;
@property (strong, nonatomic) IBOutlet UIView *viewContent;

@end
