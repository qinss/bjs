//
//  CommonListViewController.h
//  eHome
//
//  Created by 秦世帅 on 2017/5/24.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import "BasicTableViewController.h"
#import "EHomeTableView.h"
@interface CommonListViewController : BasicTableViewController

@property (nonatomic,strong) NSString *viewTitle;
- (id)initWithTitle:(NSString *)title;

@end
