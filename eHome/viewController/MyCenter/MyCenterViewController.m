//
//  MyCenterViewController.m
//  eHome
//
//  Created by 秦世帅 on 2017/5/23.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import "MyCenterViewController.h"
#import "MyCenterViewModel.h"
#import "MyInfoCell.h"
#import "ChangePasswordViewController.h"
#import "MySupportViewController.h"
#import "MyCollectionViewController.h"
#import "MySuggsetViewController.h"
#import "MyInfoViewController.h"
#import "MyMessageViewController.h"
@interface MyCenterViewController ()
@property (nonatomic,strong)MyCenterViewModel  *model;
@property(nonatomic,strong)ChangePasswordViewController *updatePasswordViewController;
@end

@implementation MyCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     [self setUpNavigationBar:@"我"];
    self.navigationItem.leftBarButtonItem = nil;
    self.model = [[MyCenterViewModel alloc] initWithDelegate:self];
    [self createTableView];

    UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushToMyInfoViewController)];
    [self.viewHeader addGestureRecognizer:singleTap];
   
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated{
    NSString *url = [NSString stringWithFormat:@"%@%@",DefaultUrl,[GlobalVariables shareGlobalVariables].currentUser.image];
    [self.imgHeader sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:defaultHeaderImage]];
}
-(void)createTableView
{
    _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, -20, ScreenWidth, ScreenHeight-29) style:UITableViewStyleGrouped];
    _tableView.backgroundColor = WhiteMainColor;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.bounces = NO;
//    _tableView.backgroundColor = [UIColor redColor];
    _tableView.showsVerticalScrollIndicator =NO;
    _tableView.tableHeaderView = self.viewHeader;
    [self.view addSubview:_tableView];
}

/******************************************************************************
 *  TableViewDelegate Implementation
 ******************************************************************************/
#pragma mark -
#pragma mark TableViewDelegate Implementation
#pragma mark - tableView的代理方法

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return 6;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
   
//    return 11.f;
    return 49;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MyInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:@"myInfoCell"];
    if (cell ==nil)
    {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"MyInfoCell" owner:self options:nil]lastObject];
    }
    cell.lblTitle.text = [self.model.titleArray objectAtIndex:indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case 0:
            [self pushToUpdatePasswordViewController];
            break;
        case 1:
            [self pushToMySuggsetViewController];
            break;
        case 2:
            [self pushToMyCollectionViewController];
            break;
        case 3:
            [self pushToMySupportViewController];
            break;
        case 4:
        [self pushToMyMessageViewControler];
        break;
        default:
            break;
    }
}
-(void)pushToUpdatePasswordViewController{
    if (self.updatePasswordViewController == nil) {
        self.updatePasswordViewController = [[ChangePasswordViewController alloc] init];
    }
    [self.navigationController pushViewController:self.updatePasswordViewController animated:YES];
}
-(void)pushToMyCollectionViewController{
    MyCollectionViewController *vc = [[MyCollectionViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)pushToMySupportViewController{
    MySupportViewController *vc = [[MySupportViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)pushToMySuggsetViewController{
    MySuggsetViewController *vc = [[MySuggsetViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)pushToMyInfoViewController{
    MyInfoViewController *vc = [[MyInfoViewController alloc] init];
     [self.navigationController pushViewController:vc animated:YES];
}
-(void)pushToMyMessageViewControler{
    MyMessageViewController *vc = [[MyMessageViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
