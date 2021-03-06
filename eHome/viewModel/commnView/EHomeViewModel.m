//
//  EHomeViewModel.m
//  eHome
//
//  Created by 秦世帅 on 2017/5/24.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import "EHomeViewModel.h"


@implementation EHomeViewModel
//@property (weak, nonatomic) id<ModelCallBackDelegate> delegate;

-(id)initWithDelegate:(id<ModelCallBackDelegate>)delegate{
    
    self = [super init];
    if(self)
    {
        self.delegate = delegate;
    }
    return self;
}
-(void)callBackWithData:(id)data
                    tag:(NSInteger)tag{
    if (self.delegate && [self.delegate respondsToSelector:@selector(modelCallBack:tag:)]) {
        [self.delegate modelCallBack:data tag:tag];
    }
}
@end
