//
//  EditInfoViewModel.h
//  eHome
//
//  Created by 秦世帅 on 2017/10/17.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import "EHomeViewModel.h"

@interface EditInfoViewModel : EHomeViewModel
-(void)requestUpdateInfo:(NSString *)postion
                birthday:(NSString *)birthday
                   email:(NSString *)email;
@end
