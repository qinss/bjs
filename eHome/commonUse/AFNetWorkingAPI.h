#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import <UIKit/UIKit.h>
/*
 请求完成后，回调block
 responseDic:请求完成服务器返回的字段，字典
 */
typedef void (^AFNetworkingSuccessBlock)(NSMutableDictionary *responseDic);
typedef void (^AFNetworkingFailureBlock)(NSString *message,NSInteger statusCode);


@protocol LoginDelegate <NSObject>
@required
-(void)jumpToLoginViewController;

@end


@interface AFNetWorkingAPI : NSObject{
    AFHTTPRequestOperationManager  * requestOperationManager;
    AFURLSessionManager            * sessionManager;
}
@property(assign,nonatomic) NSTimeInterval timeoutInterval;
@property (nonatomic, weak) id<LoginDelegate> delegate;

/**
 取消请求
 */
+(void)cancel;
-(void)cancel;
/************************ Class method ************************/

/**
 GET Request,parameters:参数，isShow:是否显示HUD
 */
+(void)getHttp:(NSString *)url
    parameters:(NSMutableDictionary *)parameters
       showHUD:(BOOL)isShow
       success:(AFNetworkingSuccessBlock)success
       failure:(AFNetworkingFailureBlock)failure;


/**
 POST URL-Form-Encoded Request，,parameters:参数，isShow:是否显示HUD
 */
#pragma mark--POST URL-Form-Encoded Request
+(void) postHttp:(NSString *)url
         showHUD:(BOOL)isShow
      parameters:(NSMutableDictionary *)parameters
         success:(AFNetworkingSuccessBlock)success
         failure:(AFNetworkingFailureBlock)failure;


+(void) putHttp:(NSString *)url
        showHUD:(BOOL)isShow
     parameters:(NSMutableDictionary *)parameters
        success:(AFNetworkingSuccessBlock)success
        failure:(AFNetworkingFailureBlock)failure;

/**
 POST Multi-Part Request (only image now)
 */
#pragma mark--POST Multi-Part Request (only image now)
+(void)postHttp:(NSString *)url
        showHUD:(BOOL)isShow
      bodyImage:(UIImage *)image
     parameters:(NSMutableDictionary *)parameters
        success:(AFNetworkingSuccessBlock)success
        failure:(AFNetworkingFailureBlock)failure;

/**
 Creating an Upload Task
 */
#pragma mark--Creating an Upload Task
+(void)uploadHttpUrl:(NSString *)url
            fileData:(NSData *)data
             showHUD:(BOOL)isShow
             success:(AFNetworkingSuccessBlock)success
             failure:(AFNetworkingFailureBlock)failure;

/**
 Creating a Download Task
 */
#pragma mark-- Creating a Download Task
+(void)downloadUrl:(NSString *)url
           showHUD:(BOOL)isShow
        completion:(void(^)(NSString *filePath,NSError *error))block;


/************************ Instance method ************************/
/**
 GET Request
 */
#pragma mark-- GET Request
-(void)getHttp:(NSString *)url
    parameters:(NSMutableDictionary *)parameters
       success:(AFNetworkingSuccessBlock)success
       failure:(AFNetworkingFailureBlock)failure;


/**
 POST URL-Form-Encoded Request
 */
#pragma mark-- PUT URL-Form-Encoded Request
-(void)putHttp:(NSString *)url
     parameters:(NSMutableDictionary *)parameters
        success:(AFNetworkingSuccessBlock)success
        failure:(AFNetworkingFailureBlock)failure;

/**
 POST URL-Form-Encoded Request
 */
#pragma mark-- POST URL-Form-Encoded Request
-(void)postHttp:(NSString *)url
      parameters:(NSMutableDictionary *)parameters
         success:(AFNetworkingSuccessBlock)success
         failure:(AFNetworkingFailureBlock)failure;

/**
 POST Multi-Part Request (only image now)
 */
#pragma mark-- POST Multi-Part Request (only image now)
-(void)postHttp:(NSString *)url
      bodyImage:(UIImage *)image
     parameters:(NSMutableDictionary *)parameters
        success:(AFNetworkingSuccessBlock)success
        failure:(AFNetworkingFailureBlock)failure;

/**
 Creating an Upload Task
 */
#pragma mark-- Creating an Upload Task
-(void)uploadHttpUrl:(NSString *)url
            fileData:(NSData *)data
             success:(AFNetworkingSuccessBlock)success
             failure:(AFNetworkingFailureBlock)failure;

/**
 Creating a Download Task
 */
#pragma mark-- Creating a Download Task
-(void)downloadUrl:(NSString *)url completion:(void (^)(NSString *, NSError *))block;

/**POST 苹果自带NSURLConnection*/
+(void) postConnection:(NSString *)url
               showHUD:(BOOL)isShow
            parameters:(id)parameters
               success:(AFNetworkingSuccessBlock)success
               failure:(AFNetworkingFailureBlock)failure;
/**POST 苹果自带NSURLConnection*/
-(void) postConnection:(NSString *)url
               showHUD:(BOOL)isShow
            parameters:(id)parameters
               success:(AFNetworkingSuccessBlock)success
               failure:(AFNetworkingFailureBlock)failure;

@end
