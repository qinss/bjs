//
//  EHomeViewModel.h
//  eHome
//
//  Created by 秦世帅 on 2017/5/24.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ModelCallBackDelegate.h"
#import <UIKit/UIKit.h>
typedef void (^successCallback)();
typedef void (^successCallbackWithModel)();
typedef void (^failureCallback)();
@interface EHomeViewModel : NSObject

@property (weak, nonatomic) id<ModelCallBackDelegate> delegate;
-(void)callBackWithData:(id)data
                    tag:(NSInteger)tag;
-(id)initWithDelegate:(id< ModelCallBackDelegate>)delegate;
@end
