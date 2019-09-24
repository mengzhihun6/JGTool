//
//  ZYAWSManager.h
//  FD_iPad
//
//  Created by 郭军 on 2019/7/16.
//  Copyright © 2019 ZYWL. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZYAWSManager : NSObject

/**
 使用亚马逊下载HTML模板和富文本html
 扩展:商品详情模板,轮播图模板
 
 @param key 模板key、richtext key
 @param complection 成功回调解析好的字符串
 @param failure  失败回调
 */
+ (void)AWSDownloadWithKey:(NSString *)key
            complectionBlock:(void(^)(NSString *resultStr))complection
                   failBlock:(void(^)(void))failure;

/**
 将html模板字符串保存到本地
 
 @param tempHtml 模板字符串
 */
+ (void)AWSSaveTemplateHtml:(NSString *)tempHtml;


/**
 替换模板 html 字符串中的 ${content}
 
 @param htmlStr 要替换的html字符串
 */
+ (NSString *)AWSReplaceTemplateHtmlMainDivContentWithHtmlStr:(NSString *)htmlStr;


@end

NS_ASSUME_NONNULL_END
