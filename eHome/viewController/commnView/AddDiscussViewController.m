//
//  AddDiscussViewController.m
//  eHome
//
//  Created by 秦世帅 on 2017/6/2.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import "AddDiscussViewController.h"
#import "AddDiscussViewModel.h"
@interface AddDiscussViewController ()<UITextViewDelegate>
{
    UILabel *textViewPlaceholderLabel;
}
@property(nonatomic,strong) AddDiscussViewModel *model;
@property(nonatomic,strong) UITextView *textView;
@end

@implementation AddDiscussViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNavigationBar:@"评论"];
    [self addTextView];
    
    self.model = [[AddDiscussViewModel alloc] initWithDelegate:self];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    btn.bounds = CGRectMake(0, 0,60, 30);
    btn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    [btn setImage:[UIImage imageNamed:@"icon_Save"] forState:UIControlStateNormal];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = item;
}
-(void)save{

     if( _textView.text.length > 0  ){
         NSString *a = _textView.text;
         [self.model requestAddComment:_info_id type:_type content:_textView.text];
    }
    else{
        [self.view makeToast:@"评论不可为空"];
    }
    
}
-(void)addTextView{
    textViewPlaceholderLabel = [[UILabel alloc] initWithFrame:CGRectMake(13, 52, ScreenWidth-60, 25)];
    textViewPlaceholderLabel.text = @"请输入您的评论";
    textViewPlaceholderLabel.textColor = [UIColor grayColor];
    [self.scrollView addSubview: textViewPlaceholderLabel];
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(10, 50, ScreenWidth-20, 150)];
    _textView.delegate = self;
    _textView.backgroundColor = [UIColor clearColor];
    [self.scrollView addSubview: _textView];
}
//设置textView的placeholder
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    //[text isEqualToString:@""] 表示输入的是退格键
    if (![text isEqualToString:@""])
    {
        textViewPlaceholderLabel.hidden = YES;
    }
    //range.location == 0 && range.length == 1 表示输入的是第一个字符
    if ([text isEqualToString:@""] && range.location == 0 && range.length == 1)
    {
        textViewPlaceholderLabel.hidden = NO;
    }
    return YES;
}
-(void)modelCallBack:(id)data tag:(NSInteger)tag{
    if (tag == tagAddCommentSuccess) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
@end
