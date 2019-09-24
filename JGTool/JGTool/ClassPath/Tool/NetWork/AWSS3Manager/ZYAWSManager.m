//
//  ZYAWSManager.m
//  FD_iPad
//
//  Created by 郭军 on 2019/7/16.
//  Copyright © 2019 ZYWL. All rights reserved.
//

#import "ZYAWSManager.h"
#import <AWSS3/AWSS3.h>

@implementation ZYAWSManager

/**
 使用亚马逊下载HTML模板和富文本html
 扩展:商品详情模板,轮播图模板
 
 @param key 模板key、richtext key
 @param complection 成功回调解析好的字符串
 @param failure  失败回调
 */
+ (void)AWSDownloadWithKey:(NSString *)key
            complectionBlock:(void(^)(NSString *resultStr))complection
                   failBlock:(void(^)(void))failure {
    
    if ([NSString isEmptyString:key]) { //如果为空,直接返回
        failure(); //失败回调
        return;
    }
    
    //    NSString *awsDomain = [NSString stringWithFormat:@"https://s3-eu-west-1.amazonaws.com/fudiandmore/"];
    //    JGLog(@"模板或者资源地址:%@%@",awsDomain,key);
    //Create the completion handler for the transfer
    AWSS3TransferUtilityDownloadCompletionHandlerBlock completionHandler = ^(AWSS3TransferUtilityDownloadTask *task, NSURL *location, NSData *data, NSError *error) {
        dispatch_main_async_safe(^{
            if (error) {
                //JGLog(@"错误:%@",error);
                failure(); //失败回调
            }
            if (data) {
                //NSData 转字符串
                NSString *htmlStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                // JGLog(@"文字内容是:%@",htmlStr);
                //回调下载结果
                if (complection) {
                    complection(htmlStr);
                }
            }
        })
    };
    
    //Create the TransferUtility expression and add the progress block to it.
    //This would be needed to report on progress tracking
    AWSS3TransferUtilityDownloadExpression *expression = [AWSS3TransferUtilityDownloadExpression new];
    expression.progressBlock = ^(AWSS3TransferUtilityTask *task, NSProgress *progress) {
        dispatch_async(dispatch_get_main_queue(), ^{
            // weakSelf.progressView.progress = progress.fractionCompleted;
        });
    };
    
    AWSS3TransferUtility *transferUtility = [AWSS3TransferUtility defaultS3TransferUtility];
    [[transferUtility downloadDataFromBucket:FDAWSS3BucketName
                                         key:key
                                  expression:expression
                           completionHandler:completionHandler] continueWithBlock:^id(AWSTask *task) {
        if (task.error) {
            //JGLog(@"Error: %@", task.error);
        }
        if (task.result) {
            dispatch_async(dispatch_get_main_queue(), ^{
                //JGLog(@"下载中.....");
            });
        }
        return nil;
    }];
}


/**
 将html模板字符串保存到本地
 
 @param tempHtml 模板字符串
 查看模板字符串的内容 https://s3-eu-west-1.amazonaws.com/fudiandmore/public/f3c7a213b1d342298481f147db1e31d0
 下载模板内容字符串url: https://s3-eu-west-1.amazonaws.com/fudiandmore/public/5a621ee0a64442dbbdedc9cba7b40bbc
 */
+ (void)AWSSaveTemplateHtml:(NSString *)tempHtml {
    //模板字符串为空,操作无效
    if ([NSString isEmptyString:tempHtml]) return;
    //保存
    [JGCommonTools saveToUserDefaults:tempHtml key:FDTempHTMLStr];
}

/**
 替换模板 html 字符串中的 ${content}
 
 @param htmlStr 要替换的html字符串
 */
+ (NSString *)AWSReplaceTemplateHtmlMainDivContentWithHtmlStr:(NSString *)htmlStr {
    //拿到模板字符串
    NSString *templatehtmlStr = [JGCommonTools getUserDefaultsWithKey:FDTempHTMLStr];
    //模板字符串不存在操作无效
    if ([NSString isEmptyString:templatehtmlStr]) return @"";
    //内容字符串不存在操作无效
    if ([NSString isEmptyString:htmlStr]) return @"";
    return  [templatehtmlStr stringByReplacingOccurrencesOfString:@"${content}" withString:htmlStr];
}


@end
