#import "BaseDefine.h"
#import "GlobalVariables.h"
#import "AppDelegate.h"
//#import "Reachability.h"
//#import "NSDate+MJ.h"

@implementation GlobalVariables

static GlobalVariables *_instance = nil;

+ (GlobalVariables *)shareGlobalVariables 
{
    @synchronized(self)
    {
        if (_instance == nil)
        {
            _instance = [[GlobalVariables alloc] init];
	}
    
        return _instance;
    
    }
}
    

+(void )saveCookie:(NSString *)url
                   {
    
    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL: [NSURL URLWithString:url]];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:cookies];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"cookie"];
}
+(void)setCookie{
    
    //        NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL:[NSURL URLWithString:checkSession]];
    
    NSData *cookiesdata = [[NSUserDefaults standardUserDefaults] objectForKey:@"cookie"];
    if([cookiesdata length]) {
        NSArray *cookies = [NSKeyedUnarchiver unarchiveObjectWithData:cookiesdata];
        NSHTTPCookie *cookie;
        for (cookie in cookies) {
            [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
        }
    }
}

//+(NSString *)userID{
//    
//    return [GlobalVariables shareGlobalVariables].currentUser.ID;
//}
//+(BOOL)stateRealName{
//
//    return [GlobalVariables shareGlobalVariables].currentUser.realNameState;
//    
//}
//+(BOOL)stateAddress{
//    
//    return [GlobalVariables shareGlobalVariables].currentUser.addressState;
//    
//}
//
//+(BOOL)statePayPassword{
//
//    return [GlobalVariables shareGlobalVariables].currentUser.payPasswordState;
//}
//+(BOOL)statebindCard{
//    return [GlobalVariables shareGlobalVariables].currentUser.bindCardState ;
//}
//+(BOOL)stateInvestigation{
//    return [GlobalVariables shareGlobalVariables].currentUser.investigationState;
//}
//
//+(BOOL)stateGesturePassword{
//
//    return [GlobalVariables shareGlobalVariables].currentUser.gesturePasswordState;
//}
+(BOOL)isExistenceNetwork
    {
        struct sockaddr_in zeroAddress1;
        bzero(&zeroAddress1, sizeof(zeroAddress1));
        zeroAddress1.sin_len = sizeof(zeroAddress1);
        zeroAddress1.sin_family = AF_INET;
        
        SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress1);
        SCNetworkReachabilityFlags flags;
        
        BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
        CFRelease(defaultRouteReachability);
        
        if (!didRetrieveFlags) {
            printf("Error. Count not recover network reachability flags\n");
            return NO;
        }
        BOOL isReachable = flags & kSCNetworkFlagsReachable;
        BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
        return (isReachable && !needsConnection) ? YES : NO;
        return YES;
    }
    
NSString* MBNonEmptyString(id obj){
    
    if (obj == nil || obj == [NSNull null] ||
        ([obj isKindOfClass:[NSString class]] && [obj length] == 0)) {
        return @"";
    } else if ([obj isKindOfClass:[NSNumber class]]) {
        return MBNonEmptyString([obj stringValue]);
    }
    return obj;
}

+(UIViewController *) currentViewController{
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    //app默认windowLevel是UIWindowLevelNormal，如果不是，找到UIWindowLevelNormal的
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    id  nextResponder = nil;
    UIViewController *appRootVC=window.rootViewController;
    //    如果是present上来的appRootVC.presentedViewController 不为nil
    if (appRootVC.presentedViewController) {
        nextResponder = appRootVC.presentedViewController;
    }else{
        UIView *frontView = [[window subviews] objectAtIndex:0];
        nextResponder = [frontView nextResponder];
    }
    if ([nextResponder isKindOfClass:[UIWindow class]]) {
        nextResponder = window.rootViewController;
    }
    if ([nextResponder isKindOfClass:[UITabBarController class]]){
        UITabBarController * tabbar = (UITabBarController *)nextResponder;
        UINavigationController * nav = (UINavigationController *)tabbar.viewControllers[tabbar.selectedIndex];
        //        UINavigationController * nav = tabbar.selectedViewController ; 上下两种写法都行
        result=nav.childViewControllers.lastObject;
    }else if ([nextResponder isKindOfClass:[UINavigationController class]]){
        UIViewController * nav = (UIViewController *)nextResponder;
        result = nav.childViewControllers.lastObject;
    }else{
        result = nextResponder;
    }
    return result;
}
+ (void)setSessionId:(NSString *)sessionId{
    [[NSUserDefaults standardUserDefaults] setValue:sessionId forKey:@"sessionId"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}
+(void)setUserDefault:(NSString *)key
                value:(NSString *)value{
    [[NSUserDefaults standardUserDefaults] setValue:value forKey:key];;
    [[NSUserDefaults standardUserDefaults]  synchronize];
}
+(NSString *)getUserDefault:(NSString *)key{
    return [[NSUserDefaults standardUserDefaults] valueForKey:key];
}


+(void)setStepTimeStamp:(NSInteger)timeStamp{
    [[NSUserDefaults standardUserDefaults] setInteger:timeStamp forKey:@"stepTimeStamp"];;
     [[NSUserDefaults standardUserDefaults]  synchronize];
}
+(NSInteger)getStepTimeStamp{
    return [[NSUserDefaults standardUserDefaults] integerForKey:@"stepTimeStamp"];
}
+ (NSString *)sessionId{
    NSString *sessionId = [[NSUserDefaults standardUserDefaults]valueForKey:@"sessionId"];
    NSString * s =  MBNonEmptyString(sessionId);
    return s;
}

+ (BOOL)compareVersion:(NSString *)needVersion{
    
     NSString *currentVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSArray *currentVersionArr = [currentVersion componentsSeparatedByString:@"."];
    NSArray *needVersionArr = [needVersion componentsSeparatedByString:@"."];

    NSString *currentStr = @"";
    NSString *needStr = @"";
    
    for (int i = 0; i < currentVersionArr.count; i++) {
        
        currentStr = [NSString stringWithFormat:@"%@%@",currentStr,[currentVersionArr objectAtIndex:i]];
    
    }
    for (int i = 0; i < needVersionArr .count; i++) {
        
        needStr = [NSString stringWithFormat:@"%@%@",needStr,[needVersionArr  objectAtIndex:i]];
    }
    if (currentStr.length < 3) {
        currentStr = [NSString stringWithFormat:@"%@%@",currentStr,@"0"];
    }
    if (needStr.length < 3) {
        needStr = [NSString stringWithFormat:@"%@%@",needStr,@"0"];

    }
    if ([currentStr integerValue] >= [needStr integerValue]) {
        return NO;
    }
    else
    {
        return YES;
    }
    
    return YES;
    
}


+ (NSString*)stringWithUUID {
    CFUUIDRef    uuidObj = CFUUIDCreate(nil);//create a new UUID
    //get the string representation of the UUID
    NSString    *uuidString = (NSString*)CFBridgingRelease(CFUUIDCreateString(nil, uuidObj));
    CFRelease(uuidObj);
    return uuidString;
}

+ (NSString *)UpdateRealName:(NSString *)realname;
{
    return [NSString stringWithFormat:@"%@*%@",[realname substringToIndex:1],[realname substringFromIndex:realname.length-1]];
}
+ (NSString *)unixTimeToBJTime:(NSString *)formatString unixtime:(CGFloat)unixtime{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init] ;
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:formatString];
    NSTimeInterval time = unixtime;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    NSString *dateString = [formatter stringFromDate:date];
    return dateString;
}

+ (UIImage *)ResizeImage:(NSString *)name
{
    UIImage *normal = [UIImage imageNamed:name];
    CGFloat w = normal.size.width * 0.5;
    CGFloat h = normal.size.height * 0.5;
    return [normal resizableImageWithCapInsets:UIEdgeInsetsMake(h, w, h, w)];
}


#pragma mark - Error handle

+(void)handleErrorByError:(NSError *)error
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:[[error userInfo] objectForKey:@"error"] message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [alertView show];
}

+(void)handleErrorByString:(NSString *)errorString
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:errorString message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [alertView show];
}

#pragma mark - Private

+ (UIImage*)imageWithImageSimple:(UIImage*)image
{
    CGSize newSize = CGSizeMake(image.size.width/4, image.size.height/4);
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+ (UIImage *)circleImage:(UIImage*) oldImage borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor
{
    // 1.加载原图
//    UIImage *oldImage = [UIImage imageNamed:name];
    
    // 2.开启上下文
    CGFloat imageW = oldImage.size.width + 2 * borderWidth;
    CGFloat imageH = oldImage.size.height + 2 * borderWidth;
    CGSize imageSize = CGSizeMake(imageW, imageH);
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);
    
    // 3.取得当前的上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 4.画边框(大圆)
    [borderColor set];
    CGFloat bigRadius = imageW * 0.5; // 大圆半径
    CGFloat centerX = bigRadius; // 圆心
    CGFloat centerY = bigRadius;
    CGContextAddArc(ctx, centerX, centerY, bigRadius, 0, M_PI * 2, 0);
    CGContextFillPath(ctx); // 画圆
    
    // 5.小圆
    CGFloat smallRadius = bigRadius - borderWidth;
    CGContextAddArc(ctx, centerX, centerY, smallRadius, 0, M_PI * 2, 0);
    // 裁剪(后面画的东西才会受裁剪的影响)
    CGContextClip(ctx);
    
    // 6.画图
    [oldImage drawInRect:CGRectMake(borderWidth, borderWidth, oldImage.size.width, oldImage.size.height)];
    
    // 7.取图
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 8.结束上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}

+(CGRect)getRectWith:(CGSize)size content:(NSString *)content andFont:(CGFloat)fontsize{
    CGRect rect =[content boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:fontsize]} context:nil];
    
    return rect;
}

+(NSString *)checkStringValue:(id)str{
    if (!str || [str isKindOfClass:[NSNull class]]) {
        return @"";
    }
    else{
        return str;
    }
}
//把字典的空值都换成“”，不考虑数组；

+(NSDictionary *)changeNullToSpace:(NSDictionary *)dict{
    NSMutableDictionary * orignalDic =[[NSMutableDictionary alloc]initWithDictionary:dict];
    NSArray * keys =[orignalDic allKeys];
    for (NSString * keyStr in keys) {
        id  value =[GlobalVariables checkStringValue:[orignalDic objectForKey:keyStr]];
        
        [orignalDic setObject:value forKey:keyStr];
        
        if ([value isKindOfClass:[NSDictionary class]]) {
            NSDictionary * subdict=  [GlobalVariables changeNullToSpace:value];
            [orignalDic setObject:subdict forKey:keyStr];
        }
    }
    
    return orignalDic;
}
//检查输入框内容是否为空
+(BOOL)InputIsemptyOrNot:(NSString *)string{
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

/**
 *  色值转换（CSS ---RGB）
 */
+(UIColor *)CSSToRGBColorChange: (NSString *) stringToConvert;
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    
    if ([cString length] < 6) return [UIColor blackColor];
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return [UIColor blackColor];
    
    // Separate into r, g, b substrings
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    if (r==255&&g==255&&b==255)
    {
        return  [UIColor whiteColor];
    }
    else
    {
        return [UIColor colorWithRed:((float) r / 255.0f)
                               green:((float) g / 255.0f)
                                blue:((float) b / 255.0f)
                               alpha:1.0f];
    }
    
}


+ (NSString *)stringCreateHTMLData: (NSString *)BAK
{
    ////
    NSString * js = @"<script language='Javascript'> "
    "function ResizeImages() { "
    "var myimg,oldwidth;"
    "var maxwidth=300;" //缩放系数
    "for(i=0;i <document.images.length;i++){"
    "myimg = document.images[i];"
    //"alert('Old'+myimg.width+'  '+myimg.height);"
    "if(myimg.width > maxwidth){"
    "oldwidth = myimg.width;"
    "myimg.width = maxwidth;"
    //"alert('New'+myimg.width+'  '+(myimg.height*maxwidth/oldwidth)+' '+myimg.height+'  '+maxwidth+'  '+oldwidth);"
    //"myimg.height = myimg.height*(maxwidth/oldwidth);"
    //"alert('New2 '+myimg.width+'  '+myimg.height+' '+maxwidth);"
    "}"
    "}"
    "} "
    "window.onload = function(){ResizeImages();};"
    "</script>";
    
    NSString * HTMLData =  [NSString stringWithFormat:@"<!DOCTYPE html><html lang='zh-cn'><head><meta name='viewport' content='width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no'>  </head><body role='document'> %@ %@</body></html>",BAK,js];
    
    
    return HTMLData;
    
}


+ (NSString *)stringCreateJavaScript
{
    return @"var tagHead =document.documentElement.firstChild;"
    "var tagStyle = document.createElement(\"style\");"
    "tagStyle.setAttribute(\"type\", \"text/css\");"
    "tagStyle.appendChild(document.createTextNode(\"BODY{padding: 20pt 15pt}\"));"
    "var tagHeadAdd = tagHead.appendChild(tagStyle);";
}


+ (BOOL)isEmptyOrNull:(NSString *)string
{
    if (string == nil)
    {
        return YES;
    }
    if (string == NULL)
    {
        return YES;
    }
    
    if ([string isKindOfClass:[NSNull class]])
    {
        return YES;
    }
    if ([string isEqualToString:@""])
    {
        return YES;
    }
    
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0)
    {
        return YES;
    }
    return NO;
}


#pragma mark  计算文字尺寸
+ (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

+(NSString *)SYFCountNumAndChangeformat:(NSString *)num
{
    int count = 0;
    long long int a = num.longLongValue;
    while (a != 0)
    {
        count++;
        a /= 10;
    }
    NSMutableString *string = [NSMutableString stringWithString:num];
    NSMutableString *newstring = [NSMutableString string];
    while (count > 3)
    {
        count -= 3;
        NSRange rang = NSMakeRange(string.length - 3, 3);
        NSString *str = [string substringWithRange:rang];
        [newstring insertString:str atIndex:0];
        [newstring insertString:@"," atIndex:0];
        [string deleteCharactersInRange:rang];
    }
    [newstring insertString:string atIndex:0];
    return newstring;
}


#pragma mark--把字典和数组转换成json字符串
+(NSString *)objectToJson:(id)temps
{
    NSData* jsonData =[NSJSONSerialization dataWithJSONObject:temps options:NSJSONWritingPrettyPrinted error:nil];
    NSString *strs=[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return strs;
}
#pragma mark--把json字符串转换成字典
+(NSMutableDictionary *)jsonToDictionary:(NSString *)jsonString
{
    NSMutableDictionary *dic =[NSMutableDictionary dictionaryWithCapacity:0];
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    return dic;
}

#pragma mark--字符串转标准json字符串
+(NSString *)stringToJsonString:(NSString *)string
{
    NSString *jsonString =string;
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"'" withString:@"\""];
    return jsonString;
}

+(BOOL)isMobileNumber:(NSString *)mobileNum
{
    NSString * MOBILE = @"^1\\d{10}$";
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    
    if ([regextestct evaluateWithObject:mobileNum] == YES)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

+(BOOL)isVerifyCode:(NSString *)verifyCode
{
    NSString * MOBILE = @"\\d{4}";
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    
    if ([regextestct evaluateWithObject:verifyCode] == YES)
    {
        return YES;
    }
    return NO;
}

+(BOOL)isEmpty:(NSString *)str
{
    if (!str)
    {
        return true;
    } else
    {
        NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        NSString *trimedString = [str stringByTrimmingCharactersInSet:set];
        
        if ([trimedString length] == 0)
        {
            return true;
        }else
        {
            return false;
        }
    }
}

+ (NSData *)imageWithImage:(UIImage*)image
              scaledToSize:(CGSize)newSize;
{
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return UIImageJPEGRepresentation(newImage, 0.5);
}

+ (NSString *)getUniqueStrByUUID
{
    CFUUIDRef    uuidObj = CFUUIDCreate(nil);//create a new UUID
    
    //get the string representation of the UUID
    
    NSString    *uuidString = (__bridge_transfer NSString *)CFUUIDCreateString(nil, uuidObj);
    
    CFRelease(uuidObj);
    
    return uuidString ;
}

/*unix时间戳转化成标准时间，需要传入时间格式 */

+ (NSString *)unixTimeToBeiJingTime:(NSString *)formatString unixtime:(CGFloat)unixtime
{
    NSTimeInterval time=unixtime;//因为时差问题要加8小时 == 28800 sec
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
//    NSLog(@"date:%@",[detaildate description]);
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [dateFormatter setTimeZone:timeZone];
    
    [dateFormatter setDateFormat:formatString];
    
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
    return currentDateStr;

}

+(NSString *)showMoneyString:(CGFloat)value
{
   
    NSMutableString * finalStr =[NSMutableString stringWithFormat:@"%.0f",value];
    for (NSInteger i =finalStr.length-3; i>=1; i=i-3)
    {
        [finalStr insertString:@"," atIndex:i];
       
    }
    
    return finalStr;
}

+ (void)showNoNetWorkView{
    
    
}
+ (NSString *)SYFCustomTime:(NSString *)sevriceTime
{
    
//    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
//    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
//
//#warning 真机调试下, 必须加上这段
//    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
//    NSDate * createdDate = [fmt dateFromString:sevriceTime];
//    
//    // 2..判断发送时间 和 现在时间 的差距
//    if ([NSDate isToday:createdDate]) { // 今天
//        if (createdDate.deltaWithNow.hour >= 1)
//        {
//            return [NSString stringWithFormat:@"%d小时前", (int)createdDate.deltaWithNow.hour];
//        } else if (createdDate.deltaWithNow.minute >= 1)
//        {
//            return [NSString stringWithFormat:@"%d分钟前", (int)createdDate.deltaWithNow.minute];
//        } else
//        {
//            return @"刚刚";
//        }
//        
//    }
//    else if([NSDate isThisMonth:createdDate])
//    {
//        int days =  (int)createdDate.deltaWithNow.day +1;
//        return [NSString stringWithFormat:@"%d天前", days];
//    }
//    else
//    {
//        NSString * str1 = [sevriceTime substringWithRange:NSMakeRange(5,2)];
//        NSString * str2 = [sevriceTime substringWithRange:NSMakeRange(8,2)];
//        NSString * str = [NSString stringWithFormat:@"%@月%@日",str1,str2];
//        return str;
//    }
//    
 return @"";
    
}

+(void)quitApp
{
//    [GlobalVariables shareGlobalVariables].currentUser =nil;
//    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"session"];
//    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"IsPaying"];
//    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"loginnameValue"];
//    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"realnameValue"];
//    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"minilogoModel"];
//    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"headlogo"];
//    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"loginkeyValue"];
//    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"loginimei"];
//     [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"baojinsuo"];
//   
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:gestureFinalSaveKey];
//    [[NSUserDefaults standardUserDefaults]synchronize];
    
}



@end
