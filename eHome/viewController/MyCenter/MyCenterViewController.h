//
//  MyCenterViewController.h
//  eHome
//
//  Created by 秦世帅 on 2017/5/23.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import "BasicViewController.h"

@interface MyCenterViewController : BasicViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * _tableView;

}
@property (weak, nonatomic) IBOutlet UIImageView *imgHeader;
@property (strong, nonatomic) IBOutlet UIView *viewHeader;
@end
