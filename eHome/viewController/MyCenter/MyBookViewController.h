//
//  MyBookViewController.h
//  eHome
//
//  Created by 秦世帅 on 2017/10/16.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import "BasicTableViewController.h"

@interface MyBookViewController : BasicTableViewController
@property (nonatomic,strong) NSString *viewTitle;
- (id)initWithTitle:(NSString *)title;
@end
