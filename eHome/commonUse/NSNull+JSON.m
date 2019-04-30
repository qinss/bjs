//
//  NSNull+JSON.m
//  eHome
//
//  Created by 秦世帅 on 2017/9/20.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import "NSNull+JSON.h"

@implementation NSNull (JSON)
- (NSUInteger)length { return 0; }

- (NSInteger)integerValue { return 0; };

- (float)floatValue { return 0; };

- (NSString *)description { return @"0(NSNull)"; }

- (NSArray *)componentsSeparatedByString:(NSString *)separator {return @[]; }

- (id)objectForKey:(id)key { return nil; }

- (BOOL)boolValue { return NO; }

- (NSRange)rangeOfCharacterFromSet:(NSCharacterSet *)aSet{
    NSRange nullRange = {NSNotFound, 0};
    return nullRange;
}


@end
