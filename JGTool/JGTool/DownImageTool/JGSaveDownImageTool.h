//
//  JGSaveDownImageTool.h
//  FD
//
//  Created by 郭军 on 2019/5/21.
//  Copyright © 2019 ZhiYuan Network. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    AdvertisingImage,
    DeliveryOptionsType,
} SaveDownImageType;


NS_ASSUME_NONNULL_BEGIN

@interface JGSaveDownImageTool : NSObject

/**
 *  初始化广告页面
 */
+ (void)getDownImageWithType:(SaveDownImageType)type;


/**
 *  判断文件是否存在
 */
+ (BOOL)isFileExistWithFilePath:(NSString *)filePath;


/**
 *  根据图片名拼接文件路径
 */
+ (NSString *)getFilePathWithImageName:(NSString *)imageName;


/**
 *  根据存储图片的key拼接文件路径
 */
+ (NSString *)getFilePathWithImageKey:(NSString *)imageKey;

@end

NS_ASSUME_NONNULL_END
