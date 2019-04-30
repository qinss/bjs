//
//  BJSALertView.m
//  BaoJin
//
//  Created by qinss on 16/6/30.
//  Copyright © 2016年 sensu_nikun. All rights reserved.
//

#import "BJSALertView.h"
#import "GlobalVariables.h"

@implementation BJSALertView

-(void)showAlertViewWithTitle:(NSString *)title
                      message:(NSString *)message
             otherButtonTitle:(NSString *)otherButtonTitle
            cancelButtonTitle:(NSString *)cancelButtonTitle
                  commitBlock:(CommitBlock) commitBlock
                  cancleBlock:(CancelBlock)cancleBlock
{
    
    float iOSVersion = [[UIDevice currentDevice].systemVersion floatValue];
    if (iOSVersion < 8.0f)
    {
        self.commitBlock = commitBlock;
        self.cancleBlock = cancleBlock;
        if (otherButtonTitle == nil) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
            [alert show];
        }
        else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: title
                                                        message: message
                                                       delegate: self
                                              cancelButtonTitle: cancelButtonTitle
                                              otherButtonTitles: otherButtonTitle, nil];
        [alert show];
        }
    }
    else
    {
    
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        if (cancelButtonTitle != nil)
        {
            
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                if (cancleBlock)
                {
                        cancleBlock();
                }
            }];
            [alertController addAction:cancelAction];
        }
        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
        {
            if(commitBlock)
            {
                commitBlock();
            }
        }];
       
        [alertController addAction:otherAction];
        
       
          [[GlobalVariables currentViewController] presentViewController:alertController animated:YES completion:nil];
    }
}

-(void)showNormalAlertViewWithTitle:(NSString *)title
                      message:(NSString *)message
                  commitBlock:(void(^)()) commitBlock
{
    [self showAlertViewWithTitle:title message:message otherButtonTitle:@"确定" cancelButtonTitle:@"取消" commitBlock:commitBlock cancleBlock:nil];
}
-(void)showOnlyCommitAlertView:(NSString *)title
                       message:(NSString *)message
             commitButtonTitle:(NSString *)commitButtonTitle
                   commitBlock:(void(^)()) commitBlock
{
    [self showAlertViewWithTitle:title message:message otherButtonTitle:commitButtonTitle cancelButtonTitle:nil commitBlock:commitBlock cancleBlock:nil];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1)
    {
        if (self.commitBlock)
        {
            self.commitBlock();
        }
    }
    else{
        if (self.cancleBlock) {
            self.cancleBlock();
        }
    }
}

@end
