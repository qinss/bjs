//
//  FindviewModel.h
//  eHome
//
//  Created by 秦世帅 on 2017/5/31.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import "EHomeViewModel.h"
typedef NS_ENUM(NSInteger,tag){
    
    tagGetListSuccess = 0
};
#define lblCommentFont 13.0
@interface FindviewModel : EHomeViewModel
//@property(nonatomic,strong) NSArray *dataArray;
@property(nonatomic,strong) NSMutableDictionary *ifOpendic;
@property(nonatomic,strong) NSMutableArray *heightArr;

@property(nonatomic,strong) NSMutableArray *commentHeightArr;
@property(nonatomic,strong) NSMutableArray *dataArr;
@property(nonatomic,assign) NSInteger totalPage;
@property(nonatomic,strong) NSString *title;
-(void)requestInfo:(NSInteger)page;
-(NSArray *)getImageArr:(NSString *)imageString;
-(CGFloat) getLblCommentHeight:(NSDictionary *)commentDic;
-(NSString *) getLblCommentString:(NSDictionary *)commentDic;
@end
