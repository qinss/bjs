//
//  EditInfoViewController.m
//  eHome
//
//  Created by 秦世帅 on 2017/10/17.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import "EditInfoViewController.h"
#import "EditInfoViewModel.h"
@interface EditInfoViewController ()<UIImagePickerControllerDelegate,
UITextFieldDelegate>
@property(nonatomic,strong) UIDatePicker *datePicker;
@property(nonatomic,strong) EditInfoViewModel *model;
@end


@implementation EditInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNavigationBar:@"资料编辑"];
     self.txtDate.delegate = self;
     [self addDatePicker];
     self.model = [[EditInfoViewModel alloc] initWithDelegate:self];
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated{
    self.txtDate.text = [GlobalVariables shareGlobalVariables].currentUser.birthday;
    self.txtEmail.text = [GlobalVariables shareGlobalVariables].currentUser.email;
    self.txtPostion.text = [GlobalVariables shareGlobalVariables].currentUser.postion;
}

-(void)modelCallBack:(id)data tag:(NSInteger)tag{
    
    [self.view makeToast:@"修改成功"];
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)addDatePicker{

    self.datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-200, self.view.frame.size.width, 200)];
    self.datePicker.datePickerMode = UIDatePickerModeDate;

    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];//设置为中文
    self.datePicker.locale = locale;

    NSDate* maxDate = [NSDate date];
    self.datePicker.maximumDate = maxDate;

    UIToolbar *pickerToolbar = [[UIToolbar alloc] init];
    pickerToolbar.barTintColor = self.view.backgroundColor;
    pickerToolbar.frame = CGRectMake(0, 0, self.view.frame.size.width, 36);
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    UIBarButtonItem *cancleBtn = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(toolBarCanelClick)];
    [barItems addObject:cancleBtn];
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    [barItems addObject:flexSpace];
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(toolBarDoneClick)];
    [barItems addObject:doneBtn];
    [pickerToolbar setItems:barItems animated:YES];

    self.txtDate.inputView = self.datePicker;
    self.txtDate.inputAccessoryView = pickerToolbar;
}
-(void)toolBarCanelClick{

    [self.view endEditing:YES];
}
-(void)toolBarDoneClick
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];

    NSDate *date = [self.datePicker date];
    NSString *strDate = [dateFormatter stringFromDate:date];
    self.txtDate.text = strDate;
    [self.view endEditing:YES];
}



- (IBAction)btnSaveTouchUpInside:(UIButton *)sender {
     
    [self.model requestUpdateInfo:self.txtPostion.text birthday:self.txtDate.text email:self.txtEmail.text];
}
@end
