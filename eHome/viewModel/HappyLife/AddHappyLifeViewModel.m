//
//  AddHappyLifeViewModel.m
//  eHome
//
//  Created by 秦世帅 on 2017/10/9.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import "AddHappyLifeViewModel.h"
#import "HttpHappyLifeModel.h"
@implementation AddHappyLifeViewModel
-(void)addDiscorveys:(NSArray *) imgArr
            content:(NSString *)content{
    NSMutableDictionary *param =[[NSMutableDictionary alloc] init];
    [param setObject:content forKey:@"content"];
    
    [HttpHappyLifeModel requestAddDiscovery:param success:^(){
        [self callBackWithData:nil tag:tagAddSuccess];
        
    } fromData:^(id<AFMultipartFormData>  _Nonnull formData) {
        int i = 0;
        for (UIImage *image in imgArr) {
            
            NSData *imageData = UIImagePNGRepresentation(image);
            NSString *fileName = [NSString stringWithFormat:@"%d.png",i];
            [formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:@"image/png"];
            i++;
        }
    }];
}
@end
