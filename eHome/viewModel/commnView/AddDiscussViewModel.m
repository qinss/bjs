//
//  AddDiscussViewModel.m
//  eHome
//
//  Created by 秦世帅 on 2017/9/27.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import "AddDiscussViewModel.h"
#import "HttpCommonModel.h"
@implementation AddDiscussViewModel
-(void)requestAddComment:(NSInteger)comment_infoid
                    type:(NSInteger)type
                 content:(NSString *)content{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@(comment_infoid) forKey:@"id"];
    [dic setObject:@(type) forKey:@"type"];
    [dic setObject:content forKey:@"content"];
    NSLog(@"aaa+++++++=%@",content);
    [HttpCommonModel requestAddComment:dic success:^(){
        [self callBackWithData:nil tag:tagAddCommentSuccess];
    }];
    
}
@end
