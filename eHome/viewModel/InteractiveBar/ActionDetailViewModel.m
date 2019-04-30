//
//  ActionDetailViewModel.m
//  eHome
//
//  Created by 秦世帅 on 2017/10/18.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import "ActionDetailViewModel.h"
#import "HttpInteractiveBarModel.h"
#import "HttpCommonModel.h"
@implementation ActionDetailViewModel
-(void)requestActionInfo:(NSInteger)action_id{
    NSMutableDictionary  *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@(action_id) forKey:@"action_id"];
    [HttpInteractiveBarModel requestActionInfo:dic success:^(NSDictionary *dataDic){
        
        self.supportCount = [MBNonEmptyString([dataDic objectForKey:@"supportCount"]) integerValue];
        self.supportStatus = [MBNonEmptyString([dataDic objectForKey:@"supportStatus"]) integerValue];
         self.commentCount = [MBNonEmptyString([dataDic objectForKey:@"commentCount"]) integerValue];
        self.commentList = [dataDic objectForKey:@"commentList"];

        [self callBackWithData:0 tag:tagGetDetailSuccess];
    }];
}

-(CGFloat) getLblCommentHeight:(NSDictionary *)commentDic{
    UILabel *lblComment = [[UILabel alloc] initWithFrame:CGRectMake(55, 0, ScreenWidth - 55 -30, 30)];
    lblComment.numberOfLines = 0;
    lblComment.font = [UIFont systemFontOfSize:lblCommentFont];
    NSString *name = MBNonEmptyString([commentDic objectForKey:@"name"]);
    NSString *content = MBNonEmptyString([commentDic objectForKey:@"comment_content"]);
    NSString *contentString = [NSString stringWithFormat:@"%@:%@",name,content];
    lblComment.text = contentString;
    CGSize size = [lblComment sizeThatFits:CGSizeMake(ScreenWidth-55-30, MAXFLOAT)];
    return size.height;
}
-(NSString *) getLblCommentString:(NSDictionary *)commentDic{
    NSString *name = MBNonEmptyString([commentDic objectForKey:@"name"]);
    NSString *content = MBNonEmptyString([commentDic objectForKey:@"comment_content"]);
    NSString *contentString = [NSString stringWithFormat:@"%@:%@",name,content];
    return contentString;
}

-(void)changeSupport:(NSInteger )ststus
             book_id:(NSInteger) book_id{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@(ststus) forKey:@"status"];
    [dic setObject:@(book_id) forKey:@"id"];
    [dic setObject:@(0) forKey:@"type"];
    [HttpCommonModel requestChangeSupport:dic success:^(){
        
        [self callBackWithData:nil tag:tagChangeSupportSuccess];
    }];
}
@end
