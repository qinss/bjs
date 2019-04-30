//
//  RecommendBookViewController.m
//  eHome
//
//  Created by 秦世帅 on 2017/6/2.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import "RecommendBookViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "RecommendBookViewModel.h"
#import "AFNetWorkingAPI.h"
@interface RecommendBookViewController()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate>
@property(nonatomic,strong) RecommendBookViewModel *model;
@property(nonatomic,assign) Boolean hasImage;
@property(nonatomic,strong) UIDatePicker *datePicker;
@end
@implementation RecommendBookViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.hasImage = NO;
    [self setUpNavigationBar:@"我要推荐"];
    self.scrollView.contentSize = CGSizeMake(ScreenWidth, 645);
    [self.scrollView addSubview: self.viewContent];
    self.model = [[RecommendBookViewModel alloc] initWithDelegate:self];
    self.imgHead.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgClick)];
    [self.imgHead addGestureRecognizer:tapGesture];
    self.txtDate.delegate = self;
    [self addSaveButton];
    [self addDatePicker];
    
    
}
-(void)imgClick{
    [self.actionSheet showInView:self.view];
}

-(void)addSaveButton{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:self action:@selector(saveBook) forControlEvents:UIControlEventTouchUpInside];
    btn.bounds = CGRectMake(0, 0,60, 30);
    btn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    [btn setImage:[UIImage imageNamed:@"icon_Save"] forState:UIControlStateNormal];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = item;
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
-(void)modelCallBack:(id)data tag:(NSInteger)tag{
    if (tag == tagAddBookSuccess) {
        [self.navigationController popViewControllerAnimated:YES];
    }
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

-(void)doAddPhoto:(UIImage *)image{
      [self.imgHead setImage:image];
    self.hasImage = YES;
}

-(void)saveBook{
    
    if (!self.hasImage) {
        [self.view makeToast:@"请添加图书图片"];
        return;
    }
    if (self.txtDate.text.length == 0) {
         [self.view makeToast:@"请选择出版日期"];
        return;
    }
    
    [self.model addBook:self.imgHead.image name:self.txtName.text author:self.txtAuthor.text press:self.txtPress.text date:self.txtDate.text bulub:self.txvBlurb.text reason:self.txvReason.text review:self.txvReview.text];
}


@end
