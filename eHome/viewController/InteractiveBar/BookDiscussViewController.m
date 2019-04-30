//
//  BookDiscussViewController.m
//  eHome
//
//  Created by 秦世帅 on 2017/6/1.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import "BookDiscussViewController.h"
#import "AddDiscussViewController.h"
#import "BookDiscussViewModel.h"
#import "DiscussionTableViewCell.h"
#import "CommentModel.h"
@interface BookDiscussViewController ()
@property(nonatomic,strong) BookDiscussViewModel *model;
@property(nonatomic,strong) DiscussionTableViewCell *cell;
@end

@implementation BookDiscussViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNavigationBar:@"评论"];
    self.model = [[BookDiscussViewModel alloc] initWithDelegate:self];
    [self creatTableView:CGRectMake(0, 64, ScreenWidth, ScreenHeight -45-64)];

     [self.tableView registerNib:[UINib nibWithNibName:@"DiscussionTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"discussionTableViewCell"];
      self.cell = [self.tableView dequeueReusableCellWithIdentifier:@"discussionTableViewCell"];
    
     @WeakObj(self);
    [self.tableView setRequest:^(NSInteger i){[selfWeak.model requestInfo:i book_id:selfWeak.book_id];}];
//    [self.model requestInfo:1 book_id:self.book_id];

}
-(void)viewWillAppear:(BOOL)animated{
     [self.model requestInfo:1 book_id:self.book_id];
}
- (IBAction)btnAddDiscussionTouchUpInside:(UIButton *)sender {
    
    AddDiscussViewController *vc = [[AddDiscussViewController alloc] init];
    vc.info_id = self.book_id;
    vc.type = 3;
//    vc.placeHolder = @"请输入您的评论";
    [self.navigationController pushViewController:vc animated:YES];
    
}
-(void)modelCallBack:(id)data tag:(NSInteger)tag{
    if (tag == tagGetCommentListSuccess){
        [self.tableView endRefreshing];
        @WeakObj(self);
        [self.tableView requestWithData:data totalPage:selfWeak.model.totalPage dataArr:selfWeak.model.dataArr complemetBlock:nil];
    }
}


/******************************************************************************
 *  TableViewDelegate Implementation
 ******************************************************************************/
#pragma mark -
#pragma mark TableViewDelegate Implementation
#pragma mark - tableView的代理方法

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 120;
    CommentModel *commentModel = [self.model.dataArr objectAtIndex:indexPath.row];
    self.cell.lblContent.text = commentModel.comment_content;
    CGSize size = [self.cell.lblContent sizeThatFits:CGSizeMake(self.cell.lblContent.frame.size.width, MAXFLOAT)];
    if (size.height < 40) {
        return 100;
    }
    else{
        return  100 + (size.height - 40);
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.model.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DiscussionTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"discussionTableViewCell"];
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"DiscussionTableViewCell" owner:self options:nil]lastObject];
    }
    CommentModel *commentModel = [self.model.dataArr objectAtIndex:indexPath.row];
    [cell makeCellWithModel:commentModel];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    BookModel *bookModel = [self.model.dataArr objectAtIndex:indexPath.section];
//    [self pushToBookDetailViewController:bookModel];
    
}
@end
