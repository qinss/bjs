//
//  EditInfoViewModel.m
//  eHome
//
//  Created by 秦世帅 on 2017/10/17.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import "EditInfoViewModel.h"
#import "HttpCenterModel.h"
@implementation EditInfoViewModel
-(void)requestUpdateInfo:(NSString *)postion
                birthday:(NSString *)birthday
                   email:(NSString *)email{
    
    NSMutableDictionary  *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:postion forKey:@"postion"];
    [dic setObject:birthday forKey:@"birthday"];
    [dic setObject:email forKey:@"email"];
    [HttpCenterModel requestUpdateInfo:dic success:^(){
        [self callBackWithData:0 tag:0];

    }]
    ;
    
    
    
    
}
@end
