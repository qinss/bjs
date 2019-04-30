//
//  RankingListViewController.h
//  eHome
//
//  Created by 秦世帅 on 2017/5/27.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import "BasicTableViewController.h"

@interface RankingListViewController : BasicTableViewController
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblRanking;
@property (weak, nonatomic) IBOutlet UILabel *lblStep;
@property (weak, nonatomic) IBOutlet UILabel *LblSupportCount;
@property (weak, nonatomic) IBOutlet UIImageView *imgHeaderView;

@property(nonatomic,strong) NSDictionary *dataDic;
@end
