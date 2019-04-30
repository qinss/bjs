//
//  MyInfoViewController.m
//  eHome
//
//  Created by 秦世帅 on 2017/10/17.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import "MyInfoViewController.h"
#import "MyInfoViewModel.h"
#import "EditInfoViewController.h"
#import "LoginViewController.h"
#import "FDNavigationController.h"
@interface MyInfoViewController ()<UIImagePickerControllerDelegate,UITextFieldDelegate>
//@property(nonatomic,strong) UIDatePicker *datePicker;
@property(nonatomic,strong) MyInfoViewModel *model;
@end

@implementation MyInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNavigationBar:@"我"];
    self.imgHead.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgClick)];
    [self.imgHead addGestureRecognizer:tapGesture];
//    self.txtDate.delegate = self;
    self.model = [[MyInfoViewModel alloc] initWithDelegate:self];
//    [self addDatePicker];
  
    
   

    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:self action:@selector(pushToEditInfoViewController) forControlEvents:UIControlEventTouchUpInside];
    btn.bounds = CGRectMake(0, 0,60, 30);
    btn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    [btn setImage:[UIImage imageNamed:@"icon_addRemark"] forState:UIControlStateNormal];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = item;
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated{
    self.lblName.text = [GlobalVariables shareGlobalVariables].currentUser.name;
    NSString *gender = [GlobalVariables shareGlobalVariables].currentUser.gender ? @"女":@"男";
    self.lblGender.text = [NSString stringWithFormat:@"性别:%@",gender];
    self.lblDepartment.text = [NSString stringWithFormat:@"科室:%@",[GlobalVariables shareGlobalVariables].currentUser.department];
    self.lblBirthday.text = [GlobalVariables shareGlobalVariables].currentUser.birthday;
    self.lblEmail.text = [GlobalVariables shareGlobalVariables].currentUser.email;
    self.lblPostion.text = [NSString stringWithFormat:@"职务:%@",[GlobalVariables shareGlobalVariables].currentUser.postion];
    NSString *url = [NSString stringWithFormat:@"%@%@",DefaultUrl,[GlobalVariables shareGlobalVariables].currentUser.image];
    [self.imgHead sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:defaultHeaderImage]];
}
-(void)imgClick{
    [self.actionSheet showInView:self.view];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 0) {
        [self localPhoto];
    }
    else if (buttonIndex == 1){
        
        [self takePhoto];
    }
    else{
    }
}
-(void)modelCallBack:(id)data tag:(NSInteger)tag{
    NSString *imageUrl = [GlobalVariables shareGlobalVariables].currentUser.image;
//    self.imgHead
    NSString *url = [NSString stringWithFormat:@"%@%@",DefaultUrl,imageUrl];
    [self.imgHead sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil];
    
}
-(void)doAddPhoto:(UIImage *)image{
//    [self.imgHead setImage:image];
    [self.model requestAddImage:image];
//    self.hasImage = YES;
}
-(void)pushToEditInfoViewController{
    EditInfoViewController *vc = [[EditInfoViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)btnExitTouchUpInside:(UIButton *)sender {
    
    
    
    self.tabBarController.selectedViewController =  [self.tabBarController.viewControllers objectAtIndex:0];
    [GlobalVariables setUserDefault:@"password" value:@""];

    LoginViewController * login =[[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
    FDNavigationController  * navi =[[FDNavigationController alloc]initWithRootViewController:login];
    [self presentViewController:navi animated:YES completion:nil];
    

}
@end
