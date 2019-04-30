#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"
#import "BaseDefine.h"
#import "UserInfoModel.h"
#import "Reachability.h"
@interface GlobalVariables : NSObject

+ (GlobalVariables *)shareGlobalVariables;
NSString* MBNonEmptyString(id obj);
@property BOOL isInDisabledTabState;

//@property UserInfoModel * currentUser;
@property UserInfoModel *currentUser;
//@property(nonatomic,strong) UserInfoModel *currentUser;
//@property (nonatomic,retain) UserModel *userModel;

/*
 // 设置手势返回的犯法
 - (void)GestureBackperiousVC
 {
 if (SYFMobileSystemVersion>= 7.0) {
 self.navigationController.interactivePopGestureRecognizer.enabled = YES;
 self.navigationController.interactivePopGestureRecognizer.delegate = self;
 }
 }
 */
/*
 *RSA 加密
 */

+(UIViewController *) currentViewController;

+ (NSString *)sessionId;
+(NSString *)userID;
+(NSInteger)isPayingState;
+ (void)setSessionId:(NSString *)sessionId;
+(void)setIsPayingState:(NSInteger)state;
+ (void)showNoNetWorkView;


+(void)setStepTimeStamp:(NSInteger)timeStamp;
+(NSInteger)getStepTimeStamp;
/*
 * 130****3333类型的 手机号码
 */

+ (NSString *)unixTimeToBJTime:(NSString *)formatString unixtime:(CGFloat)unixtime;
    
+(void )saveCookie:(NSString *)url;
+(void)setCookie;
+ (NSString *)phoneNumberWithCenterHidden;
+ (NSString*)stringWithUUID;
+(BOOL)stateAddress;
+(BOOL)stateRealName;
+(BOOL)statePayPassword;
+(BOOL)statebindCard;
+(BOOL)stateGesturePassword;
+(BOOL)stateInvestigation;
+ (BOOL)compareVersion:(NSString *)needVersion;
/*
 *  提示框
 */
+(void)handleErrorByError:(NSError *)error;

+(void)handleErrorByString:(NSString *)errorString;

//上官云清 ---> 上*清
+ (NSString *)UpdateRealName:(NSString *)realname;


/*
 *  检查是否存在网络
 */
+(BOOL)isExistenceNetwork;

/*
 *  判断输入框是否为空
 */
+(BOOL)InputIsemptyOrNot:(NSString *)string;

/*
 *  获取自适应高度
 */
+(CGRect)getRectWith:(CGSize)size content:(NSString *)content andFont:(CGFloat)fontsize;

/*
 *  检查字符串是否为NUll转为@""
 */
+(NSString *)checkStringValue:(id)str;

/*
 *  把返回值中的null都转成空字符串
 */
+(NSDictionary *)changeNullToSpace:(NSDictionary *)orignalDic;

+ (UIImage*)imageWithImageSimple:(UIImage*)image;

+ (UIImage *)circleImage:(UIImage*) oldImage borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

/*
 *  1、色值转换（CSS ---RGB）
 */
+(UIColor *)CSSToRGBColorChange: (NSString *) stringToConvert;

/*
 *  2、中心拉伸图片
 */
+ (UIImage *)ResizeImage:(NSString *)name;


/*
 *  3、Webview 的自适应宽度 加载HTML
 */
+ (NSString *)stringCreateHTMLData: (NSString *)BAK;
+ (NSString *)stringCreateJavaScript;


/*
 * 4.字符串 为空(nil)的验证
 */
+ (BOOL)isEmptyOrNull:(NSString *)string;

/*
 *  5、计算 label 文字的尺寸
 */
+ (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize;

/*
 *  6、处理金钱字符串（加逗号）
 */
+(NSString *)SYFCountNumAndChangeformat:(NSString *)num;

/*
 *  7、判断设备是否联网
 */
+ (BOOL)xianshiTIXing: (UIViewController *)VC;

/*
 *  8、把字典和数组转换成json字符串
 */
+(NSString *)objectToJson:(id)temps;

/*
 *  9、把json字符串转换成字典
 */
+(NSMutableDictionary *)jsonToDictionary:(NSString *)jsonString;

/*
 *  10、字符串转标准json字符串,string->json
 */
+(NSString *)stringToJsonString:(NSString *)string;

/*
 *  11、判断是否是合法手机号
 */
+(BOOL)isMobileNumber:(NSString *)mobileNum;

/*
 *  12、判断验证码是否是四位数字
 */
+(BOOL)isVerifyCode:(NSString *)verifyCode;

/*
 *  13、空格
 */
+(BOOL)isEmpty:(NSString *)str;

/*
 *  14、将图片压缩到指定尺寸
 */
+ (NSData *)imageWithImage:(UIImage*)image
              scaledToSize:(CGSize)newSize;

/*
 *  15、unix时间戳专成当前时间
 */

+ (NSString *)unixTimeToBeiJingTime:(NSString *)formatString unixtime:(CGFloat)unixtime;

/*
 *  16、大型金额显示
 */

+ (NSString *)showMoneyString:(CGFloat)value;

/*
 *  17、判断是几天前
 */
+ (NSString *)SYFCustomTime:(NSString *)sevriceTime;

+(void)quitApp;
+(void)setUserDefault:(NSString *)key
                value:(NSString *)value;
+(NSString *)getUserDefault:(NSString *)key;
@end
