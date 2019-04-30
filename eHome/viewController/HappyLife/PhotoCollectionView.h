//
//  PhotoCollectionView.h
//  eHome
//
//  Created by 秦世帅 on 2017/6/13.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"
@interface PhotoCollectionView : UICollectionView<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
typedef void (^ViewPhotoBlock)(NSInteger index);
@property(nonatomic,strong)ViewPhotoBlock viewPhotoBlock;
@property(nonatomic,strong) NSArray *imageArr;
@end
