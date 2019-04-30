//
//  PhotoCollectionView.m
//  eHome
//
//  Created by 秦世帅 on 2017/6/13.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import "PhotoCollectionView.h"
#import "PhotoCollectionViewCell.h"
#import "BaseDefine.h"
#define CELL_IDENTIFIER @"photoCollectionCell"
@implementation PhotoCollectionView
- (id)initWithFrame:(CGRect)frame
{
     UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        UINib *nib = [UINib nibWithNibName:@"PhotoCollectionViewCell" bundle:nil];
        self.backgroundColor = [UIColor whiteColor];
        [self registerNib:nib forCellWithReuseIdentifier:CELL_IDENTIFIER];
    }
    return self;
}
/******************************************************************************
 *  UICollectionViewDataSource  Implementation
 ******************************************************************************/
#pragma mark -- UICollectionViewDataSource

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.imageArr.count;
}

-(NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PhotoCollectionViewCell *cell = (PhotoCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CELL_IDENTIFIER forIndexPath:indexPath];
//    if (indexPath.row == self.photoArr.count) {
    
        cell.btnDelete.hidden = YES;
    NSString *url = [_imageArr objectAtIndex:indexPath.row];
     [cell.image sd_setImageWithURL:[NSURL URLWithString: url]];
    
    CGFloat with = (ScreenWidth - 80)/3;
    cell.contentView.frame = CGRectMake(0, 0, with, with);
    cell.contentView.backgroundColor = [UIColor redColor];
    return cell;
}


/******************************************************************************
 *  UICollectionViewDelegateFlowLayout  Implementation
 ******************************************************************************/
#pragma mark --UICollectionViewDelegateFlowLayout


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat with = (ScreenWidth - 100)/3;
    return CGSizeMake(with, with);
}
//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 0, 5, 0);
}






#pragma mark --UICollectionViewDelegate

//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.viewPhotoBlock) {
        
        self.viewPhotoBlock(indexPath.row);
    }
    
//    [self.txtContent resignFirstResponder];
//    if (indexPath.row == self.photoArr.count)
//    {
//        self.actionSheet = [[UIActionSheet alloc] initWithTitle:@"选择图片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相册", @"拍照", nil, nil];
//        self.actionSheet.tag = ActionSheetTagAddPhoto;
//        [self.actionSheet showInView:self.view];
//    }
}
//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
@end
