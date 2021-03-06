//
//  EHomeTableView.h
//  eHome
//
//  Created by 秦世帅 on 2017/5/26.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^RequestDataBlock)(NSInteger i);
typedef void (^ComplementBlock)();
@interface EHomeTableView : UITableView
@property(nonatomic,assign) NSInteger currentPage;
@property (nonatomic,strong)RequestDataBlock  requestDataBlock;
@property(nonatomic,assign) BOOL showNoDataView;

-(void)setRequest:(RequestDataBlock)requestDataBlock;
-(void)endRefreshing;
-(void)requestWithData:(NSArray *)requestDataArr
             totalPage:(NSInteger)totalPage
               dataArr:(NSMutableArray *)dataArr
        complemetBlock:(ComplementBlock)complementBlock;
-(void)removeHeaderView;
-(void)removeFooterView;
@end
