
#import "AFNetWorkingAPI.h"
#import "SVProgressHUD.h"
#import "BaseDefine.h"
#import "BJSALertView.h"
#import "LoginViewController.h"
#import "FDNavigationController.h"
@implementation AFNetWorkingAPI

+(AFNetWorkingAPI *)shareAFNetworking
{
    static dispatch_once_t once;
    static AFNetWorkingAPI *share;
    dispatch_once(&once, ^{
        share = [[AFNetWorkingAPI alloc] init];
    });
    return share;
}
-(id)init
{
    self = [super init];
    if (self != nil) {
        self.timeoutInterval = 10;//默认是不限时
    }
    return self;
}

-(void) setHeader:(AFHTTPRequestOperationManager *) manager {
    
    
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
//     [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
//    [manager.requestSerializer setValue:VERSION forHTTPHeaderField:@"appVersion"];
//    [manager.requestSerializer setValue:@"IOS" forHTTPHeaderField:@"Device"];
//    [manager.requestSerializer setValue:@"1" forHTTPHeaderField:@"apiVersion"];
//    [manager.requestSerializer setValue:[[UIDevice currentDevice] systemVersion] forHTTPHeaderField:@"systemVersion"];
}
    -(void)pushtToLoginViewContrller:(NSDictionary *)dic{
        NSInteger flag = [[dic objectForKey:@"flag"] integerValue];
        if (flag == 1 ) {
    LoginViewController * login =[[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
    FDNavigationController  * navi =[[FDNavigationController alloc]initWithRootViewController:login];
    UIViewController *cur = [GlobalVariables currentViewController] ;
      [cur presentViewController:navi animated:YES completion:nil];
        }
}
#pragma mark--
#pragma mark-- 检查网络 ，并弹出提示框
+(BOOL)checkWith:(BOOL)isShow
{
    
    if (![GlobalVariables isExistenceNetwork]) {
        BJSALertView *alertView = [[BJSALertView alloc] init];
        [alertView showOnlyCommitAlertView:@"提示" message:@"请检查网络" commitButtonTitle:@"确定" commitBlock:nil];
        return NO;
    }
    else{
        if (isShow) {
            [SVProgressHUD showWithStatus:@"加载中···" maskType:2];
        }
        return YES;
    }
    
 }

#pragma mark--
#pragma mark--取消请求
+(void)cancel{
    [[self shareAFNetworking] cancel];
}
-(void)cancel
{
    if (requestOperationManager) {
        [requestOperationManager.operationQueue cancelAllOperations];
        requestOperationManager = nil;
    }
    if (sessionManager) {
        [sessionManager.operationQueue cancelAllOperations];
        sessionManager = nil;
    }
    if ([SVProgressHUD isVisible]) {
        [SVProgressHUD dismiss];
    }
}

#pragma mark--
#pragma mark--取消HUD，延迟1秒取消
-(void)dismissHUD
{
    double delayInSeconds = 1.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int16_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
    });
}
/***************************************************************/
/************************ Class  method ************************/
/***************************************************************/
#pragma mark-- Class method
#pragma mark-- GET Request
+(void)getHttp:(NSString *)url
    parameters:(NSMutableDictionary *)parameters
       showHUD:(BOOL)isShow
       success:(AFNetworkingSuccessBlock)success
       failure:(AFNetworkingFailureBlock)failure
{
    if (![self checkWith:isShow]) {
        return ;
    }
    [[self shareAFNetworking] getHttp:url parameters:parameters success:success failure:failure];
}
#pragma mark-- Class method
#pragma mark-- POST URL-Form-Encoded Request
+(void) postHttp:(NSString *)url
         showHUD:(BOOL)isShow
      parameters:(NSMutableDictionary *)parameters
         success:(AFNetworkingSuccessBlock)success
         failure:(AFNetworkingFailureBlock)failure
{
    if (![self checkWith:isShow]) {
        return ;
    }
    [[self shareAFNetworking] postHttp:url parameters:parameters success:success failure:failure];
    
    
}
+(void) putHttp:(NSString *)url
         showHUD:(BOOL)isShow
      parameters:(NSMutableDictionary *)parameters
         success:(AFNetworkingSuccessBlock)success
         failure:(AFNetworkingFailureBlock)failure
{
    if (![self checkWith:isShow]) {
        return ;
    }
    [[self shareAFNetworking] putHttp:url parameters:parameters success:success failure:failure];
    
}
#pragma mark-- Class method
#pragma mark-- POST Multi-Part Request (only image now)
+(void)postHttp:(NSString *)url
        showHUD:(BOOL)isShow
      bodyImage:(UIImage *)image
     parameters:(NSMutableDictionary *)parameters
        success:(AFNetworkingSuccessBlock)success
        failure:(AFNetworkingFailureBlock)failure
{
    if (![self checkWith:isShow]) {
        return ;
    }
    [[self shareAFNetworking] postHttp:url
                             bodyImage:image
                            parameters:parameters
                               success:success
                               failure:failure];
}
#pragma mark-- Class method
#pragma mark-- Creating an Upload Task
+(void)uploadHttpUrl:(NSString *)url
            fileData:(NSData *)data
             showHUD:(BOOL)isShow
             success:(AFNetworkingSuccessBlock)success
             failure:(AFNetworkingFailureBlock)failure
{
    if (![self checkWith:isShow]) {
        return ;
    }
    [[self shareAFNetworking] uploadHttpUrl:url fileData:data success:success failure:failure];
}
#pragma mark-- Class method
#pragma mark-- Creating a Download Task
+(void)downloadUrl:(NSString *)url
           showHUD:(BOOL)isShow
        completion:(void (^)(NSString *, NSError *))block
{
    if (![self checkWith:isShow]) {
        return ;
    }
    [[self shareAFNetworking] downloadUrl:url completion:block];
}


#pragma mark-- Instance method
#pragma mark-- GET Request
-(void)getHttp:(NSString *)url
    parameters:(NSMutableDictionary *)parameters
       success:(AFNetworkingSuccessBlock)success
       failure:(AFNetworkingFailureBlock)failure
{
    requestOperationManager = [AFHTTPRequestOperationManager manager];
    if (self.timeoutInterval != 0) {
        requestOperationManager.requestSerializer.timeoutInterval = self.timeoutInterval;
    }
    //申明返回的结果是json类型
    requestOperationManager.responseSerializer = [AFJSONResponseSerializer serializer];
    //申明请求的数据是json类型
    requestOperationManager.requestSerializer= [AFJSONRequestSerializer serializer];
    //如果报接受类型不一致请替换一致text/html或别的
    
    [self setHeader:requestOperationManager];
    requestOperationManager.responseSerializer.acceptableContentTypes =
    [NSSet setWithObjects:@"text/html",@"text/json",@"application/json",@"text/plain", nil];
   
    [requestOperationManager GET:url
                      parameters:parameters
                         success:^(AFHTTPRequestOperation *operation, id responseObject) {
                             dispatch_async(dispatch_get_main_queue(), ^{
                                 if (success) {
                                     if (responseObject) {
                                         NSData *jsonData = nil;
                                         if (responseObject != nil)
                                         {
                                             jsonData =[NSJSONSerialization dataWithJSONObject:responseObject
                                                                                       options:NSJSONWritingPrettyPrinted error:nil];
                                         }
                                         
                                         NSMutableDictionary *dataResponse = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
//                                         [SVProgressHUD dismiss];
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         NSInteger statusCode =  [operation.response statusCode] ;
                                         [dataResponse  setValue:@(statusCode)   forKey:@"statusCode"];
                                         success(dataResponse);
                                     }
                                     else{
                                         
                                     }
                                 }
                             });
                         }
                         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                             NSLog(@"Error: %@", error);
                             dispatch_async(dispatch_get_main_queue(), ^{
                                 if (failure) {
                                    NSInteger statusCode =  [operation.response statusCode] ;
                                     [SVProgressHUD dismiss];
                                     NSString *message =  [self showMessage:statusCode error:error];
                                     failure(message,statusCode);
                                 }
                             });
                         }];
}



-(NSString *)showMessage:(NSInteger)statusCode
             error:(NSError *)error{
    
    NSData *errorData = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
    if(errorData == nil)
    {
        return @"网络请求失败！";
    }
    NSDictionary *serializedData = [NSJSONSerialization JSONObjectWithData: errorData options:kNilOptions error:nil];
    NSString *message = [serializedData objectForKey:@"message"];
    NSString *code = [serializedData objectForKey:@"code"];
                      
    if ([message isKindOfClass:[NSNull class]]) {
        message = @"网络请求失败！";
    }
//    if (statusCode == 404) {
//        message = @"网络请求失败！";
//    }
    if ([code  isEqual: @"login_first"]) {
            message = @"请先登录";
    }
    [SVProgressHUD dismiss];
    return message;
}




#pragma mark-- Instance method
#pragma mark-- POST URL-Form-Encoded Request
-(void) postHttp:(NSString *)url
      parameters:(NSMutableDictionary *)parameters
         success:(AFNetworkingSuccessBlock)success
         failure:(AFNetworkingFailureBlock)failure
{
    NSString* str = @"";
    NSMutableArray * paraArr = [[NSMutableArray alloc]init];
    for (NSString *key in parameters) {
        NSString * strsub =[NSString stringWithFormat:@"%@=%@",key,parameters[key]];
        [paraArr addObject:strsub];
    }
    str = [paraArr componentsJoinedByString:@"&"];
    NSLog(@"post请求：%@?%@",url,str);
    requestOperationManager = [AFHTTPRequestOperationManager manager];
    if (self.timeoutInterval != 0) {
        requestOperationManager.requestSerializer.timeoutInterval = self.timeoutInterval;
        [requestOperationManager.requestSerializer setTimeoutInterval:self.timeoutInterval];
    }
    //    requestOperationManager.responseSerialize
    //申明返回的结果是json类型
    //requestOperationManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    requestOperationManager.responseSerializer = [AFJSONResponseSerializer serializer];
    //申明请求的数据是json类型
    requestOperationManager.requestSerializer=[AFHTTPRequestSerializer serializer];
;
    [self setHeader:requestOperationManager];
    //如果报接受类型不一致请替换一致text/html或别的
    requestOperationManager.responseSerializer.acceptableContentTypes =

    [NSSet setWithObjects:@"text/plain",@"text/json",@"application/json",@"text/javascript",@"text/html",nil];
    [requestOperationManager POST:url
                       parameters:parameters
                          success:^(AFHTTPRequestOperation *operation, id responseObject) {
                              dispatch_async(dispatch_get_main_queue(), ^
                              {
                                  if (success) {
                                       NSLog(@" operation___________%@", operation.request.allHTTPHeaderFields);
                                      NSData* jsonData = nil;
                                      NSMutableDictionary *dataResponse = [[NSMutableDictionary alloc] init];
                                      if (responseObject != nil) {
                                          jsonData =[NSJSONSerialization dataWithJSONObject:responseObject
                                                                                    options:NSJSONWritingPrettyPrinted error:nil];
                                           dataResponse = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
                                      }
                                    
//                                      NSInteger statusCode =  [operation.response statusCode] ;
//                                      [dataResponse  setValue:@(statusCode)   forKey:@"statusCode"];
                                      [SVProgressHUD dismiss];

                                      success(dataResponse);
                                  }
                              });
                          }
                          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                              
                              
                              NSLog(@"Error:%@",error);
                              dispatch_async(dispatch_get_main_queue(), ^{
                                  if (failure) {
                                      
                                      NSInteger statusCode =  [operation.response statusCode] ;
                                      NSString *message =  [self showMessage:statusCode error:error];
                                      [SVProgressHUD dismiss];
                                      failure(message,statusCode);
                                     
                                  }
                              });
                          }];
    
    
}
-(void) putHttp:(NSString *)url
      parameters:(NSMutableDictionary *)parameters
         success:(AFNetworkingSuccessBlock)success
         failure:(AFNetworkingFailureBlock)failure
{
    NSString* str = @"";
    NSMutableArray * paraArr = [[NSMutableArray alloc]init];
    for (NSString *key in parameters) {
        NSString * strsub =[NSString stringWithFormat:@"%@=%@",key,parameters[key]];
        [paraArr addObject:strsub];
    }
    str = [paraArr componentsJoinedByString:@"&"];
    NSLog(@"post请求：%@?%@",url,str);
    requestOperationManager = [AFHTTPRequestOperationManager manager];
    if (self.timeoutInterval != 0) {
        requestOperationManager.requestSerializer.timeoutInterval = self.timeoutInterval;
        [requestOperationManager.requestSerializer setTimeoutInterval:self.timeoutInterval];
    }
    //    requestOperationManager.responseSerializer
    //申明返回的结果是json类型
    //requestOperationManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    requestOperationManager.responseSerializer = [AFJSONResponseSerializer serializer];
    //申明请求的数据是json类型
    requestOperationManager.requestSerializer=[AFJSONRequestSerializer serializer];
     [self setHeader:requestOperationManager];
    //如果报接受类型不一致请替换一致text/html或别的
    requestOperationManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/json",@"text/plain",@"application/json" ,nil];
    [requestOperationManager PUT:url
                       parameters:parameters
                          success:^(AFHTTPRequestOperation *operation, id responseObject) {
                              dispatch_async(dispatch_get_main_queue(), ^{
                                  if (success) {
                                      NSLog(@" operation___________%@", operation.request.allHTTPHeaderFields);
                                      
                                      NSData* jsonData =[NSJSONSerialization dataWithJSONObject:responseObject
                                                                                        options:NSJSONWritingPrettyPrinted error:nil];
                                      NSMutableDictionary *dataResponse = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
                                      NSInteger statusCode =  [operation.response statusCode] ;
                                      [dataResponse  setValue:@(statusCode)   forKey:@"statusCode"];
                                      [SVProgressHUD dismiss];
                                      [self pushtToLoginViewContrller:dataResponse];
                                      success(dataResponse);
                                  }
                              });
                          }
                          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                              
                              
                              NSLog(@"Error:%@",error);
                              dispatch_async(dispatch_get_main_queue(), ^{
                                  if (failure) {
                                      
                                      NSInteger statusCode =  [operation.response statusCode] ;
                                      NSString *message =  [self showMessage:statusCode error:error];
                                      [SVProgressHUD dismiss];
                                      failure(message,statusCode);
                                      
                                  }
                              });
                          }];
}

#pragma mark-- Instance method
#pragma mark-- POST Multi-Part Request (only image now)
-(void)postHttp:(NSString *)url
      bodyImage:(UIImage *)image
     parameters:(NSMutableDictionary *)parameters
        success:(AFNetworkingSuccessBlock)success
        failure:(AFNetworkingFailureBlock)failure
{
    requestOperationManager = [AFHTTPRequestOperationManager manager];
    if (self.timeoutInterval != 0) {
        requestOperationManager.requestSerializer.timeoutInterval = self.timeoutInterval;
    }
    //申明返回的结果是json类型
    requestOperationManager.responseSerializer = [AFJSONResponseSerializer serializer];
    //申明请求的数据是json类型
    requestOperationManager.requestSerializer=[AFJSONRequestSerializer serializer];
    //如果报接受类型不一致请替换一致text/html或别的
    //requestOperationManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    requestOperationManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
     [self setHeader:requestOperationManager];
    
    [requestOperationManager POST:url
                       parameters:parameters
        constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
           // NSData *data = UIImageJPEGRepresentation(image, 0.5);
            //[formData appendPartWithFormData:data name:@"image"];
           // [formData appendPartWithFileData:data name:@"image" fileName:@"png" mimeType:@"image/png"];
            
            NSData *data = UIImageJPEGRepresentation(image, 0.4);
            NSString * fileName = [NSString stringWithFormat:@"fileName-%d.jpeg",1];
            [formData appendPartWithFileData:data name:@"file" fileName:fileName mimeType:@"image/jpeg"];
            
        }
                          success:^(AFHTTPRequestOperation *operation, id responseObject) {
                              
                              dispatch_async(dispatch_get_main_queue(), ^{
                                  if (success) {
                                      NSData* jsonData =[NSJSONSerialization dataWithJSONObject:responseObject
                                                                                        options:NSJSONWritingPrettyPrinted error:nil];
                                      NSMutableDictionary *dataResponse = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
                                      NSInteger statusCode =  [operation.response statusCode] ;
                                      [dataResponse  setValue:@(statusCode)   forKey:@"statusCode"];
                                      [self pushtToLoginViewContrller:dataResponse];
                                      success(dataResponse);
//                                      [self dismissHUD];
                                  }
                              });
                          }
                          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                              NSLog(@"Error: %@", error);
                              dispatch_async(dispatch_get_main_queue(), ^{
                                  if (failure) {
                                      NSInteger statusCode =  [operation.response statusCode] ;
                                      NSString *message =  [self showMessage:statusCode error:error];
                                      failure(message,statusCode);
                                    
                                  }
                              });
                          }];
}
#pragma mark-- Instance method
#pragma mark-- Creating an Upload Task
-(void)uploadHttpUrl:(NSString *)url
            fileData:(NSData *)data
             success:(AFNetworkingSuccessBlock)success
             failure:(AFNetworkingFailureBlock)failure
{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    if (self.timeoutInterval != 0) {
        configuration.timeoutIntervalForRequest = self.timeoutInterval;
    }
    sessionManager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:url];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionUploadTask *uploadTask = [sessionManager uploadTaskWithRequest:request
                                                                      fromData:data
                                                                      progress:nil
                                                             completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
                                                                 dispatch_async(dispatch_get_main_queue(), ^{
                                                                     if (error) {
                                                                         NSLog(@"Upload Task Error: %@", error);
                                                                         failure(@"",0);
                                                                     } else {
                                                                         NSLog(@"Upload Task Success: %@ %@", response, responseObject);
                                                                         NSMutableDictionary *jsonData =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                                             success(jsonData);
                                                                     }                                                              [self dismissHUD];
                                                                 });
                                                             }];
    [uploadTask resume];
}
#pragma mark-- Instance method
#pragma mark-- Creating a Download Task
-(void)downloadUrl:(NSString *)url completion:(void (^)(NSString *, NSError *))block
{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    if (self.timeoutInterval != 0) {
        configuration.timeoutIntervalForRequest = self.timeoutInterval;
    }
    sessionManager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    //@"https://github.com/AFNetworking/AFNetworking/archive/master.zip"
    NSURL *URL = [NSURL URLWithString:url];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDownloadTask *downloadTask =
    [sessionManager downloadTaskWithRequest:request
                                   progress:nil
                                destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
                                    NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
                                    return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
                                }
                          completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
                              dispatch_async(dispatch_get_main_queue(), ^{
                                  if (block) {
                                      NSString *file = [NSString stringWithFormat:@"%@",filePath];
                                      file = [file stringByReplacingOccurrencesOfString:@"file://" withString:@""];
                                      file = [file stringByReplacingOccurrencesOfString:@"%20" withString:@" "];
                                      block(file,error);
                                      [self dismissHUD];
                                  }
                              });
                              
                              
                          }];
    [downloadTask resume];
}

//#pragma mark - POST 苹果自带 NSURLConnection
//-(void) postConnection:(NSString *)url showHUD:(BOOL)isShow parameters:(id)parameters success:(AFNetworkingSuccessBlock)success failure:(AFNetworkingFailureBlock)failure {
//    
////    if (![self checkWith:isShow]) {
////        return ;
////    }
//    
//    NSMutableArray * paraArr = [NSMutableArray array];
//    for (NSString *key in parameters) {
//        NSString * strsub =[NSString stringWithFormat:@"%@=%@",key,parameters[key]];
//        [paraArr addObject:strsub];
//    }
//    NSString* jsonStr = [paraArr componentsJoinedByString:@"&"];
//    
//    //URL
//    NSURL *main_url = [NSURL URLWithString:url];
//    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:main_url];
//    [urlRequest setTimeoutInterval:30.0f];
//    [urlRequest setHTTPMethod:@"POST"];
//    NSString *body = jsonStr;
//    [urlRequest setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
////    
////    if ([SingletonClass shareInstance].isTakeAuthKey) {
////        NSString *authKey = [NSString stringWithFormat:@"Basic %@",[HSFunction getUserAuthKey]];
////        [urlRequest setValue:authKey forHTTPHeaderField:@"Authorization"];
////        
////        [SingletonClass shareInstance].isTakeAuthKey = NO;
////    }
//    NSLog(@"HTTPHeaderField:%@",urlRequest.allHTTPHeaderFields);
//    
//    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
//    [NSURLConnection sendAsynchronousRequest:urlRequest queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
//        
//        if ([data length] >0 && connectionError == nil){
//            NSString *html = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//            NSMutableDictionary *responseDic = [GlobalVariables jsonToDictionary:html];
//            NSLog(@"dic = %@", responseDic);
//            
//            dispatch_async(dispatch_get_main_queue(), ^{
//                if (success) {
//                    success(responseDic);
//                }
//            });
//        }
//        else if ([data length] == 0 && connectionError == nil){
//            dispatch_async(dispatch_get_main_queue(), ^{
//                if (failure) {
//                    failure(@"",0);
//                    [self dismissHUD];
//                }
//            });
//        }
//        else if (connectionError != nil){
//            dispatch_async(dispatch_get_main_queue(), ^{
//                if (failure) {
//                    failure(@"",0);
//                    [self dismissHUD];
//                }
//            });
//        }
//    }];
//}
+(void) postConnection:(NSString *)url
                showHUD:(BOOL)isShow
             parameters:(id)parameters
                success:(AFNetworkingSuccessBlock)success
                failure:(AFNetworkingFailureBlock)failure{
    [[AFNetWorkingAPI shareAFNetworking]postConnection:url showHUD:isShow parameters:parameters success:success failure:failure];
}
@end
