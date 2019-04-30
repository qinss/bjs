//
//  RecommendBookViewController.h
//  eHome
//
//  Created by 秦世帅 on 2017/6/2.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import "BasicUploadImageViewController.h"

@interface RecommendBookViewController : BasicUploadImageViewController
@property (strong, nonatomic) IBOutlet UIView *viewContent;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *imgHead;
@property (weak, nonatomic) IBOutlet UITextField *txtName;
@property (weak, nonatomic) IBOutlet UITextField *txtAuthor;
@property (weak, nonatomic) IBOutlet UITextField *txtPress;
@property (weak, nonatomic) IBOutlet UITextField *txtDate;
@property (weak, nonatomic) IBOutlet UITextView *txvBlurb;
@property (weak, nonatomic) IBOutlet UITextView *txvReason;
@property (weak, nonatomic) IBOutlet UITextView *txvReview;

@end
