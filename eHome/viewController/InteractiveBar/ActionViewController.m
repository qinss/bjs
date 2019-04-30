//
//  ActionViewController.m
//  eHome
//
//  Created by 秦世帅 on 2017/5/31.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import "ActionViewController.h"
#import "DiscussionViewController.h"
#import "PassEnentTableViewController.h"
@interface ActionViewController ()
@property(nonatomic,strong) DiscussionViewController *discussionViewController;
@property(nonatomic,strong) PassEnentTableViewController *passenentTableViewontroller;

@end

@implementation ActionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"E起讨论";
     UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushToPastEventList)];
    [self.viewPastEvent addGestureRecognizer:tapGesture];
}

-(void)pushToPastEventList{
    if (self.passenentTableViewontroller == nil) {
        self.passenentTableViewontroller = [[PassEnentTableViewController alloc] init];
    }
    [self.navigationController pushViewController:self.passenentTableViewontroller animated:YES];
}

- (IBAction)btnSuggestionTouchUpInside:(UIButton *)sender {
    
    if (self.discussionViewController == nil) {
        self.discussionViewController = [[DiscussionViewController alloc] init];
    }
    [self.navigationController pushViewController:self.discussionViewController animated:YES];
}
@end
