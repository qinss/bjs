//
//  MyInfoViewModel.m
//  eHome
//
//  Created by 秦世帅 on 2017/10/17.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import "MyInfoViewModel.h"
#import "HttpCenterModel.h"
@implementation MyInfoViewModel
-(void)requestAddImage:(UIImage *)img{
    [HttpCenterModel requestAddHeaderImage:nil success:^(){
        [self callBackWithData:nil tag:0];
    } fromData:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData *imageData = UIImagePNGRepresentation(img);
        [formData appendPartWithFileData:imageData name:@"file" fileName:@"3.png" mimeType:@"image/png"];
    }];
} -(void)requestLoginout{
}
@end
