//
//  ZYHttpManager.m
//  FD_Rider
//
//  Created by 郭军 on 2019/3/18.
//  Copyright © 2019年 zhiyuan. All rights reserved.
//

#import "ZYHttpManager.h"
#import "AFNetworking.h"
#import "ZYHttpModel.h"


static AFHTTPSessionManager *manager;


@implementation ZYHttpManager


+ (AFHTTPSessionManager *)manager {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager = [AFHTTPSessionManager manager];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json", @"charset=utf-8", nil];
        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        manager.requestSerializer.timeoutInterval = 30.f;//设置请求超时时间
        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    });
    
    return manager;
}


/**
 *  创建一个不带蒙版的http请求
 *
 *  @param url        请求连接
 *  @param parameters 请求参数
 *  @param httpMthod  GET 或 POST
 *  @param success    成功回调
 *  @param failure    失败回调
 */
+ (void)HttpRequestDataWithApi:(NSString *)api
                    Aarameters:(NSDictionary *)parameters
                     httpMthod:(ZYHttpMthod)httpMthod
                       Success:(success)success
                       failure:(failure)failure {
    [self HttpMethodRequestDataWithApi:api Aarameters:parameters httpMthod:httpMthod isShow:NO Success:success failure:failure];
}


/**
 *  创建一个带蒙版的http请求
 *
 *  @param api        请求连接
 *  @param parameters 请求参数
 *  @param httpMthod  GET 或 POST
 *  @param success    成功回调
 *  @param failure    失败回调
 */
+ (void)LoadingHttpRequestDataWithApi:(NSString *)api
                           Aarameters:(NSDictionary *)parameters
                            httpMthod:(ZYHttpMthod)httpMthod
                              Success:(success)success
                              failure:(failure)failure {
    
    [self HttpMethodRequestDataWithApi:api Aarameters:parameters httpMthod:httpMthod isShow:YES Success:success failure:failure];
}


/**
 创建一个http请求

 *  @param api        请求连接
 *  @param parameters 请求参数
 *  @param httpMthod  GET 或 POST
 *  @param isShow 是否显示蒙版
 *  @param success    成功回调
 *  @param failure    失败回调
 */
+ (void)HttpMethodRequestDataWithApi:(NSString *)api
                          Aarameters:(NSDictionary *)parameters
                           httpMthod:(ZYHttpMthod)httpMthod
                              isShow:(BOOL)isShow
                             Success:(success)success
                             failure:(failure)failure {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    });
    
    //检查网络状态
    if (![JGCommonTools isNetWorkReachable])  {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        return;
    };
    
    if (isShow) {
        [MBProgressHUD showMessage:@"正在加载..."];
    }

    if (httpMthod == POST) { //POST 请求
        
        [self HttpRequestWithApi:api parameters:parameters isShow:isShow  progress:nil sueeess:success failure:failure];
    }else {  //GET 请求

    }
}


#pragma mark - 公有方法 -
////////////////////////////////////////////////////////////////////////////////////
/***********************************  公有方法   ************************************/
////////////////////////////////////////////////////////////////////////////////////
/**
 *  创建一个http请求  请求方法  POST
 *
 *  @param api         请求URL字符串
 *  @param parameters     请求参数
 *  @param progress       请求进度(可忽略)
 *  @param success        请求成功的回调
 *  @param failure        请求失败的回调
 */
+ (void)HttpRequestWithApi:(NSString *)api
                parameters:(NSDictionary *)parameters
                    isShow:(BOOL)isShow
                  progress:(void (^)(NSProgress * _Nonnull))progress
                   sueeess:(success)success
                   failure:(failure)failure {
    
    AFHTTPSessionManager *manager = [self manager];
    
    //时间戳 ：一定要传一样的
    NSString *timeStampStr = [JGCommonTools currentTimeStr];
    //版本号
    NSString *Version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    //如果有token就传，没有就传空
    NSString *token = USER_TOKEN;
    if (!token.length) token = @"";
    //拼接 device + timeStamp+ version
    NSString *dtvValue = [NSString stringWithFormat:@"%@\n%@\n%@",@"ios",timeStampStr,Version];
    //签名
    NSString *signatureStr = [NSString HmacSha1:api data:dtvValue];
    //拼接 base 编码
    NSString *signBaseStr = [[NSString stringWithFormat:@"%@:%@",token,signatureStr] rb_base64EncodingString];
    //提纯
    NSString *AuthStr = [NSString pureStrWithOriginStr:signBaseStr];
    //授权信息
    [manager.requestSerializer setValue:AuthStr forHTTPHeaderField:@"Authorization"];
    //操作系统，如：ios、android
    [manager.requestSerializer setValue:@"ios" forHTTPHeaderField:@"authorization-device"];
    //客户端版本号
    [manager.requestSerializer setValue:Version forHTTPHeaderField:@"Authorization-Version"];
    //当前发起请求的13位时间戳
    [manager.requestSerializer setValue:timeStampStr forHTTPHeaderField:@"Authorization-Timestamp"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSString *UrlStr = [NSString stringWithFormat:@"%@%@",HttpBaseUrl, api];
    
    //开始发送网络请求
    [manager POST:UrlStr parameters:parameters progress:progress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self responseSuccessHandleWithResponseObject:responseObject isShow:isShow success:success failure:failure];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(@"网络请求失败");
        [self hideHudWithIsShow:isShow];

        //隐藏小菊花
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            });
        });
    }];
}


+(void)hideHudWithIsShow:(BOOL)isShow {
    
    if (isShow) {
        [MBProgressHUD hideHUD];
    }
}

/**
 *  创建一个请求H5的GET请求
 *
 *   @param api 请求链接
 *  @param success    成功回调
 *  @param failure    失败回调
 */
+ (void)GetHtmlWithApi:(NSString *)api
               Success:(success)success
               failure:(failure)failure {
    
    AFHTTPSessionManager *manager = [self manager];

    [manager GET:api parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString * str  =[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        success(str,@"成功");
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(@"网络请求失败");
    }];
}



/**
 *  处理请求成功的方法
 *
 *  @param responseObject JSON 对象
 *  @param success        成功回调
 *  @param failure        失败回调（不是网络请求的失败，而是服务端返回的失败。例:参数错误，未登录等）
 */
+ (void)responseSuccessHandleWithResponseObject:(id)responseObject
                                         isShow:(BOOL)isShow
                                        success:(success)success
                                        failure:(failure)failure {
    
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
    
    //隐藏小菊花
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        });
    });
    
    ZYHttpModel *baseModel = [[ZYHttpModel alloc] initWithObject:dict];
    
    //处理蒙版
    [self hideHudWithIsShow:isShow];

    //客户端请求失败，服务端服务端未能正常处理业务，此时“describe”字段中会包含错误描述信息
    if ([baseModel.event isEqualToString:@"SUCCESS"]) {
        
        //客户端请求成功，服务端正常处理/响应请求
        success(baseModel.data,baseModel.describe);
    }else if ([baseModel.event isEqualToString:@"ERROR"]) {
        
        JGLog(@"加载错误");
        failure(baseModel.describe);
    } else if ([baseModel.event isEqualToString:@"EXCEPTION"]) { //系统繁忙
        
        JGLog(@"系统繁忙");
        failure(baseModel.describe);
    } else if ([baseModel.event isEqualToString:@"UNAUTHORIZED"]) { //请求未授权
        
        JGLog(@"请求未授权");
        [JGNotification postNotificationName:JGNeedShowLoginCtrlNotification object:nil];
        [JGCommonTools saveToUserDefaults:@"" key:@"token"];
        failure(baseModel.describe);
    } else if ([baseModel.event isEqualToString:@"UNROLE"]) { //请求未授权
        
        JGLog(@"请求未授权");
        [JGNotification postNotificationName:JGNeedShowLoginCtrlNotification object:nil];
        [JGCommonTools saveToUserDefaults:@"" key:@"token"];
        failure(baseModel.describe);
    } else {
        
    }
}




@end
