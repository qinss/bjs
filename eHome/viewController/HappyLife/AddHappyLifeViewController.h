//
//  AddHappyLifeViewController.h
//  eHome
//
//  Created by 秦世帅 on 2017/6/6.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#import "BasicUploadImageViewController.h"
#import "EHomeTextView.h"
@interface AddHappyLifeViewController : BasicUploadImageViewController
@property (weak, nonatomic) IBOutlet EHomeTextView *txtContent;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end
