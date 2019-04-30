//
//  RecommendBookViewModel.m
//  eHome
//
//  Created by 秦世帅 on 2017/9/20.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import "RecommendBookViewModel.h"
#import "HttpInteractiveBarModel.h"
@implementation RecommendBookViewModel
-(void)addBook:(UIImage *)img
          name:(NSString *)name
        author:(NSString *)author
         press:(NSString *)press
          date:(NSString *)date
         bulub:(NSString *)blurb
        reason:(NSString *)reason
        review:(NSString *)review{
    NSMutableDictionary *param =[[NSMutableDictionary alloc] init];
    [param setObject:name forKey:@"name"];
     [param setObject:author forKey:@"author"];
     [param setObject:press forKey:@"press"];
     [param setObject:date forKey:@"date"];
     [param setObject:blurb forKey:@"blurb"];
     [param setObject:reason forKey:@"reason"];
     [param setObject:review forKey:@"review"];
    [HttpInteractiveBarModel requestAddBook:param success:^(){
        [self callBackWithData:nil tag:tagAddBookSuccess];
        
    } fromData:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData *imageData = UIImagePNGRepresentation(img);
        [formData appendPartWithFileData:imageData name:@"file" fileName:@"3.png" mimeType:@"image/png"];
    }];
}
@end
