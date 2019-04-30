//
//  BookDetailViewModel.h
//  eHome
//
//  Created by 秦世帅 on 2017/9/26.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import "EHomeViewModel.h"
typedef NS_ENUM(NSInteger,tag){
    
    tagGetInfoSuccess = 0,
    tagChangeCollectionSuccess = 1,
    tagChangeSupportSuccess = 2
};
@interface BookDetailViewModel : EHomeViewModel
-(void)requestBookInfo:(NSString *)bookId;
-(void)changeCollection:(NSInteger )ststus
                     book_id:(NSInteger) book_id;
-(void)changeSupport:(NSInteger )ststus
                book_id:(NSInteger) book_id;
@end
