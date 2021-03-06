//
//  DiscussionViewModel.m
//  eHome
//
//  Created by 秦世帅 on 2017/5/31.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import "DiscussionViewModel.h"
#import "HttpCommonModel.h"
@implementation DiscussionViewModel
-(id)initWithDelegate:(id<ModelCallBackDelegate>)delegate{
    
    self = [super initWithDelegate:delegate];
//    self.dataArray  =@[@"修改密码发挥了广泛交流日哦你发了几百块奋斗史健康；vnk.jk；奋斗史",@"给他揉了了艰苦奋斗了失落感高谈阔论人；你不能明白感觉结果 i 就开了个电话过来发的健康甘尽苦来能力；放假快乐的；结果看了份 i",@"我的收藏机构加快了推特肉鹅和规范；的",@"我的点赞",@"我的推送消息",@"版本升级"];
    return self;
}
-(void)requestInfo:(NSInteger)page{
    NSMutableDictionary  *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@(page) forKey:@"page"];
    [dic setObject:@(10) forKey:@"pagesize"];
    
    if (self.dataArr == nil) {
        self.dataArr = [[NSMutableArray alloc] init];
    }
    [HttpCommonModel requestCommentList:dic success:^(NSArray *dataArr,NSInteger totalPage){
        self.totalPage = totalPage;
        [self callBackWithData:dataArr tag:tagGetCommentListSuccess];}];
}
@end
