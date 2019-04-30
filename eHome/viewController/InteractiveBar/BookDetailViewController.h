//
//  BookDetailViewController.h
//  eHome
//
//  Created by 秦世帅 on 2017/6/1.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import "BasicViewController.h"
#import "BookModel.h"
@interface BookDetailViewController : BasicViewController
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
- (IBAction)btnSaveTouchUpInside:(UIButton *)sender;
- (IBAction)btnSuggestionTouchUpInside:(UIButton *)sender;
- (IBAction)btnSupportTouchUpInisde:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnSave;
@property (weak, nonatomic) IBOutlet UIButton *btnSupport;
@property(nonatomic,strong) BookModel *bookModel;
@property (weak, nonatomic) IBOutlet UIImageView *imgBook;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblAuthor;
@property (weak, nonatomic) IBOutlet UILabel *lblPress;
@property (weak, nonatomic) IBOutlet UILabel *lblData;
@property (weak, nonatomic) IBOutlet UILabel *lblSuggestion;
@property (weak, nonatomic) IBOutlet UILabel *lblSupport;

@end
