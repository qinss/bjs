//
//  ModelCallBackDelegate.h

//
//  Created by qinss on 16/7/1.
//  Copyright © 2016年 sensu_nikun. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ModelCallBackDelegate <NSObject>
-(void)modelCallBack:(id)data
                 tag:(NSInteger)tag;
@end
