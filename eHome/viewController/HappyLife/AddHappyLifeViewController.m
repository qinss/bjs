//
//  AddHappyLifeViewController.m
//  eHome
//
//  Created by 秦世帅 on 2017/6/6.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import "AddHappyLifeViewController.h"
#import "PhotoCollectionViewCell.h"
#import <CTAssetsPickerController/CTAssetsPickerController.h>
#define CELL_IDENTIFIER @"photoCollectionCell"
#import "AddHappyLifeViewModel.h"
@interface AddHappyLifeViewController()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,CTAssetsPickerControllerDelegate>

@property (strong,nonatomic) NSMutableArray *photoArr;
@property (assign,nonatomic) NSInteger deleteIndex;
@property(nonatomic,strong) AddHappyLifeViewModel *model;

@end

@implementation AddHappyLifeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNavigationBar:@"发表"];
    self.txtContent.text = @"";
    self.photoArr = [[NSMutableArray alloc] init];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.txtContent.placeholderText = @"说点什么吧...";
    UINib *nib = [UINib nibWithNibName:@"PhotoCollectionViewCell" bundle:nil];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:CELL_IDENTIFIER];
    self.model = [[AddHappyLifeViewModel alloc] initWithDelegate:self];
    [self addSaveButton];
}
-(void)addSaveButton{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:self action:@selector(saveDiscorvey) forControlEvents:UIControlEventTouchUpInside];
    btn.bounds = CGRectMake(0, 0,60, 30);
    btn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    [btn setImage:[UIImage imageNamed:@"icon_Save"] forState:UIControlStateNormal];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = item;
}
-(void)saveDiscorvey{
    if (!(_txtContent.text.length > 0)) {
         [self.view makeToast:@"内容不能为空!"];
        return;
    }
    [self.model addDiscorveys:self.photoArr content:_txtContent.text];
}
- (void)btnDeleteTouchUpInside:(UIButton *)sender{
   
    
    self.deleteIndex = sender.tag - 100;
    self.actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                   delegate:self
                                          cancelButtonTitle:@"取消"
                                     destructiveButtonTitle:@"删除"
                                          otherButtonTitles:nil];
    self.actionSheet.tag = ActionSheetTagDeletePhoto;
    [self.actionSheet showInView:self.view];
}
-(void)localPhotos{
    
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        //如果用户不允许访问相册,就直接返回
        if (status != PHAuthorizationStatusAuthorized) return;
        dispatch_async(dispatch_get_main_queue(), ^{
            //创建第三方框架提供的控制器
            CTAssetsPickerController *picker = [[CTAssetsPickerController alloc] init];
            //设置代理
            picker.delegate = self;
            //设置相册的类型 : 相机胶卷 + 自定义相册
            picker.assetCollectionSubtypes = @[
                                               @(PHAssetCollectionSubtypeSmartAlbumUserLibrary),
                                               @(PHAssetCollectionSubtypeAlbumRegular)
                                               
                                               ];
            //并且不要显示空的相册
            picker.showsEmptyAlbums = NO;
            //设置所选照片的索引
            picker.showsSelectionIndex = YES;
            [self presentViewController:picker animated:YES completion:nil];
        });
    }];
}

-(void)deletePhoto{
    [self.photoArr removeObjectAtIndex:self.deleteIndex];
    //    [self.photoUrls removeObjectAtIndex:self.deleteIndex];
    [self.collectionView reloadData];
}
-(void)doAddPhoto:(UIImage *)image{
    [self.photoArr addObject:image];
    [self.collectionView reloadData];
}

-(void)modelCallBack:(id)data tag:(NSInteger)tag{
    if (tagAddSuccess == tag) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
/******************************************************************************
 *  UIActionSheetDelegate Call Back Implementation
 ******************************************************************************/

#pragma mark -
#pragma mark UIActionSheetDelegate Call Back Implementation

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (ActionSheetTagAddPhoto == actionSheet.tag)
    {
        if (0 == buttonIndex)
        {
            [self localPhotos];
        }
        else if(1 == buttonIndex)
        {
            [self takePhoto];
        }
    }
    else if(ActionSheetTagDeletePhoto == actionSheet.tag)
    {
        if (0 == buttonIndex)
        {
            [self deletePhoto];
        }
    }
}
/******************************************************************************
 *  UICollectionViewDataSource  Implementation
 ******************************************************************************/
#pragma mark -- UICollectionViewDataSource

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.photoArr.count < 9) {
        return self.photoArr.count  + 1;
    }
    else
    {
        return self.photoArr.count ;
    }
}

-(NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PhotoCollectionViewCell *cell = (PhotoCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CELL_IDENTIFIER forIndexPath:indexPath];
    if (indexPath.row == self.photoArr.count) {
        cell.image.image = [UIImage imageNamed:@"icon_addImage"];
        cell.btnDelete.hidden = YES;
    }
    else
    {
        [cell.btnDelete addTarget:self action:@selector(btnDeleteTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
        cell.image.image = [self.photoArr objectAtIndex:indexPath.row];
        cell.btnDelete.hidden = NO;
        cell.btnDelete.tag = indexPath.row + 100;
    }
    return cell;
}
/******************************************************************************
 *  UICollectionViewDelegateFlowLayout  Implementation
 ******************************************************************************/
#pragma mark --UICollectionViewDelegateFlowLayout


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(50, 50);
}
//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 0);
}


#pragma mark --UICollectionViewDelegate

//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.txtContent resignFirstResponder];
    if (indexPath.row == self.photoArr.count)
    {
        self.actionSheet = [[UIActionSheet alloc] initWithTitle:@"选择图片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相册", @"拍照", nil, nil];
        self.actionSheet.tag = ActionSheetTagAddPhoto;
        [self.actionSheet showInView:self.view];
    }
}
//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


/******************************************************************************
 * CTAssetsPickerControllerDelegate  Implementation
 ******************************************************************************/
#pragma mark - CTAssetsPickerControllerDelegate


-(BOOL)assetsPickerController:(CTAssetsPickerController *)picker shouldSelectAsset:(PHAsset *)asset
{
    NSInteger max = 9 - self.photoArr.count;
    
    if (picker.selectedAssets.count >= max) {
        
        //提示用户最多只能选择的张数
        NSString *massage = [NSString stringWithFormat:@"最多还能能选%zd张",max];
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:massage preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
        
        [alert addAction:action1];
        
        //这里不能使用self来modal别的控制器,因为此时self.view不在window上,如果A想modal出B,那么A必须要在窗口上
        //用self会报警告
        /*
         Warning: Attempt to present <UIAlertController: 0x7fb8f1f3bab0> on <ViewController: 0x7fb8f1c207a0> whose view is not in the window hierarchy!
         
         */
        [picker presentViewController:alert animated:YES completion:nil];
        
        return NO;
    }
    return YES;
    
}

-(void)assetsPickerController:(CTAssetsPickerController *)picker didFinishPickingAssets:(NSArray *)assets{
    
    [picker dismissViewControllerAnimated:YES completion:^{
        CGFloat scale = [UIScreen mainScreen].scale;
        PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
        options.resizeMode = PHImageRequestOptionsResizeModeExact;
        options.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
        NSInteger __block count = 0;
        /** 遍历选择的所有图片*/
        for (NSInteger i = 0; i < assets.count; i++) {
            PHAsset *asset = assets[i];
            CGSize size = CGSizeMake(asset.pixelWidth / scale, asset.pixelHeight / scale);
            
            /** 获取图片*/
            [[PHImageManager defaultManager] requestImageForAsset:asset
                                                       targetSize:size
                                                      contentMode:PHImageContentModeDefault
                                                          options:options
                                                    resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info)
             {
                 UIImage *image = [result fixOrientation];
                 image = [self reduceImage:image percent:0.1];
                 CGSize imageSize = image.size;
                 imageSize.height = 320;
                 imageSize.width = 320;
                 image = [self imageWithImageSimple:image scaledToSize:imageSize];
                 [self.photoArr addObject:image];
                 count++;
                 if (assets.count == count) {
                     [self.collectionView reloadData];
                 }
             }];
        }
    }];
}
@end
