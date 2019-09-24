//
//  ZYHttpManager.h
//  FD_Rider
//
//  Created by 郭军 on 2019/3/18.
//  Copyright © 2019年 zhiyuan. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef enum : NSUInteger {
    POST,
    GET,
} ZYHttpMthod;


typedef void(^success)(id _Nonnull data, NSString * _Nonnull message);
typedef void(^failure)( NSString * _Nonnull message);



NS_ASSUME_NONNULL_BEGIN

@interface ZYHttpManager : NSObject


/**
 *  创建一个http请求
 *
 *  @param api        请求连接
 *  @param parameters 请求参数
 *  @param httpMthod  GET 或 POST
 *  @param success    成功回调
 *  @param failure    失败回调
 */
+ (void)HttpRequestDataWithApi:(NSString *)api
                          Aarameters:(NSDictionary *)parameters
                           httpMthod:(ZYHttpMthod)httpMthod
                             Success:(success)success
                             failure:(failure)failure;


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
                       failure:(failure)failure;



/**
 *  创建一个请求H5的GET请求
 *
 *   @param api 请求链接
 *  @param success    成功回调
 *  @param failure    失败回调
 */
+ (void)GetHtmlWithApi:(NSString *)api
               Success:(success)success
               failure:(failure)failure;


@end

NS_ASSUME_NONNULL_END
