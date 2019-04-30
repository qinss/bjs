//
//  FindviewModel.m
//  eHome
//
//  Created by 秦世帅 on 2017/5/31.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import "FindviewModel.h"
#import "HttpHappyLifeModel.h"

@implementation FindviewModel
-(id)initWithDelegate:(id<ModelCallBackDelegate>)delegate{
    
    self = [super initWithDelegate:delegate];
//    self.dataArray  =@[@"给他揉了了艰苦奋斗了失落感高谈阔论人；你不能明白感觉结果 i 就开了个电话过来发的健康甘尽苦来能力；gtgthyyy放假快乐的；结果看了份 ",@"你是🐷吗"];
    self.heightArr = [[NSMutableArray alloc] init];
    self.ifOpendic = [[NSMutableDictionary alloc] init];
    self.commentHeightArr = [[NSMutableArray alloc] init];
    return self;
}


-(void)requestInfo:(NSInteger)page{
    NSMutableDictionary  *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@(page) forKey:@"page"];
    [dic setObject:@(10) forKey:@"pagesize"];
    if ([self.title isEqualToString:@"发现了没"]) {
        [dic setObject:@(1) forKey:@"type"];
    }
    else{
        //我的微论坛
        [dic setObject:@(2) forKey:@"type"];
    }
    
    if (self.dataArr == nil) {
        self.dataArr = [[NSMutableArray alloc] init];
    }
    [HttpHappyLifeModel requestDiscorveyList:dic success:^(NSArray *dataArr,NSInteger totalPage){
         self.totalPage = totalPage;
         [self callBackWithData:dataArr tag:tagGetListSuccess];
     }];
}
-(NSArray *)getImageArr:(NSString *)imageString{
    
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    
    NSArray *imgArr = [imageString componentsSeparatedByString:@","];
    for (NSString * str in imgArr) {
        if (![str isEqualToString:@""]) {
            NSString *imageUrl = [NSString stringWithFormat:@"%@%@",DefaultUrl,str];
            [arr addObject:imageUrl];
        }
    }
    
    return  arr;
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
@end
