//
//  DiscussionTableView.m
//  eHome
//
//  Created by 秦世帅 on 2017/6/14.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import "DiscussionTableView.h"

@implementation DiscussionTableView


-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self)
    {
        self.delegate = self;
        self.dataSource = self;
    }
    return self;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  nil;
}
@end
