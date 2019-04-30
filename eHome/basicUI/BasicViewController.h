//
//  BasicViewController.h
//  eHome
//
//  Created by 秦世帅 on 2017/5/23.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseDefine.h"
#import "ModelCallBackDelegate.h"
#import "UIView+Toast.h"
#import "UIImage+Extras.h"
#import "SVProgressHUD.h"
#import "GlobalVariables.h"
#import "UIImageView+WebCache.h"
#import "CALayer+Anim.h"
@interface BasicViewController : UIViewController<ModelCallBackDelegate>

- (void)setUpNavigationBar:(NSString *)titleText;
-(void)modelCallBack:(id)data tag:(NSInteger)tag;
- (void)showMessage:(NSString *)message;
@end
