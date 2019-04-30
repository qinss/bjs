//
//  BJSALertView.h
//  BaoJin
//
//  Created by qinss on 16/6/30.
//  Copyright © 2016年 sensu_nikun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BJSALertView : UIView<UIAlertViewDelegate>

typedef void (^CommitBlock)();
typedef void (^CancelBlock)();
@property (nonatomic,strong)CommitBlock  commitBlock;
@property (nonatomic,strong)CancelBlock  cancleBlock;

/* 两个按键的*/
-(void)showAlertViewWithTitle:(NSString *)title
                      message:(NSString *)message
                
             otherButtonTitle:(NSString *)otherButtonTitle
            cancelButtonTitle:(NSString *)cancelButtonTitle
                  commitBlock:(void(^)()) commitBlock
                  cancleBlock:(void(^)())cancleBlock;
/* 默认确定 取消的  */
-(void)showNormalAlertViewWithTitle:(NSString *)title
                      message:(NSString *)message
                  commitBlock:(void(^)()) commitBlock;

/* 只有一个按键的  */
-(void)showOnlyCommitAlertView:(NSString *)title
                       message:(NSString *)message
             commitButtonTitle:(NSString *)commitButtonTitle
                   commitBlock:(void(^)()) commitBlock;
@end
