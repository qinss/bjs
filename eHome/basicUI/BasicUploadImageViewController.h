//
//  BasicUploadImageViewController.h
//  eHome
//
//  Created by 秦世帅 on 2017/6/6.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import "BasicViewController.h"
typedef NS_ENUM(NSInteger, ActionSheetTag)
{
    ActionSheetTagAddPhoto,
    ActionSheetTagDeletePhoto
};
@interface BasicUploadImageViewController : BasicViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>

@property(nonatomic,strong) UIActionSheet *actionSheet;
- (void)checkCamera;
- (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize;
-(UIImage *)reduceImage:(UIImage *)image percent:(float)percent;
-(void)localPhoto;
-(void)takePhoto;
- (void)doAddPhoto:(UIImage *)image;
@end
