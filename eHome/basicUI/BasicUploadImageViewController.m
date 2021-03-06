//
//  BasicUploadImageViewController.m
//  eHome
//
//  Created by 秦世帅 on 2017/6/6.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import "BasicUploadImageViewController.h"
#import <AVFoundation/AVFoundation.h>
@interface BasicUploadImageViewController ()

@end

@implementation BasicUploadImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.actionSheet = [[UIActionSheet alloc] initWithTitle:@"选择图片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相册", @"拍照", nil, nil];
    self.actionSheet.tag = ActionSheetTagAddPhoto;

}

//压缩图片质量
-(UIImage *)reduceImage:(UIImage *)image percent:(float)percent
{
    NSData *imageData = UIImageJPEGRepresentation(image, percent);
    UIImage *newImage = [UIImage imageWithData:imageData];
    return newImage;
}
//压缩图片尺寸
- (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (void)checkCamera
{
    NSString *mediaType = AVMediaTypeVideo;
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    if(AVAuthorizationStatusRestricted == authStatus ||
       AVAuthorizationStatusDenied == authStatus)
    {
        [self showMessage:@"请在iPhone的“设置-隐私-相机”选项中，允许本应用程序访问你的相机。"];
    }
}

// 开始拍照
-(void)takePhoto
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.delegate = self;
        //设置拍照后的图片可被编辑
        //        picker.allowsEditing = self.isPhotoEditEnable;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:picker animated:YES completion:^{
            [self checkCamera];
        }];
    }
}
// 打开本地相册
-(void)localPhoto
{
    //    [self hidePopView];
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    //设置选择后的图片可被编辑
    //    picker.allowsEditing = self.isPhotoEditEnable;
    [self presentViewController:picker animated:YES completion:nil];
}


// 供子类继承
- (void)doDeletePhoto
{
    
}

// 供子类继承
- (void)doAddPhoto:(UIImage *)image
{
    
}
/******************************************************************************
 *  UIImagePickerControllerDelegate Call Back Implementation
 ******************************************************************************/

#pragma mark -
#pragma mark UIImagePickerControllerDelegate Call Back Implementation

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
    //当选择的类型是图片
    if ([type isEqualToString:@"public.image"])
    {
        NSString *key = nil;
        
//        if (self.isPhotoEditEnable)
//        {
//            key = @"UIImagePickerControllerEditedImage";
//        }
//        else
//        {
            key = @"UIImagePickerControllerOriginalImage";
//        }
        //先把图片转成NSData
        UIImage *image = [info objectForKey:key];
        // 固定方向
        if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
            image = [image fixOrientation];
            image = [self reduceImage:image percent:0.1];
            CGSize imageSize = image.size;
            imageSize.height = 320;
            imageSize.width = 320;
            image = [self imageWithImageSimple:image scaledToSize:imageSize];
        }
        [self doAddPhoto:image];
        //关闭相册界面
        [picker dismissViewControllerAnimated:YES completion:^{
        }];
    }
}

@end
