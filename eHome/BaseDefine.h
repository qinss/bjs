//
//  BaseDefine.h
//  eHome
//
//  Created by 秦世帅 on 2017/5/23.
//  Copyright © 2017年 whsmwy. All rights reserved.
//

#ifndef BaseDefine_h
#define BaseDefine_h

#import "UrlDefine.h"
#import "GlobalVariables.h"


#define WeakObj(o) autoreleasepool{} __weak typeof(o) o##Weak = o;
#define StrongObj(o) autoreleasepool{} __strong typeof(o) o = o##Weak;
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define  RGBColor(x,y,z)  [UIColor colorWithRed:x/255.0 green:y/255.0 blue:z/255.0 alpha:1.0]

#define iPhone4        (ScreenHeight==480)
#define iPhone5        (ScreenHeight==568)
#define iPhone66       (ScreenHeight==667)
#define iPhone6p       (ScreenHeight==736)

#define ColorRedColor RGBColor(236,69,46) //红色字体

#define SELECT_RED_COLOR RGBColor(236,69,46)//QCSlideSwitchView
#define NOSELECT_BLACK_COLOR RGBColor(102,102,102)
#define WhiteMainColor RGBColor(246,246,246)
#define ColorLightGray RGBColor(220,220,220)//浅灰色背景

#define ColorBlue RGBColor(0,111,200)
#define defaultHeaderImage @"bar10"
#import "UIView+ViewFrame.h"
#endif /* BaseDefine_h */
