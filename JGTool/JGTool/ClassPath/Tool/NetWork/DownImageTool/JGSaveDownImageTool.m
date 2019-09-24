//
//  JGSaveDownImageTool.m
//  FD
//
//  Created by 郭军 on 2019/5/21.
//  Copyright © 2019 ZhiYuan Network. All rights reserved.
//

#import "JGSaveDownImageTool.h"

@implementation JGSaveDownImageTool

/**
 *  判断文件是否存在
 */
+ (BOOL)isFileExistWithFilePath:(NSString *)filePath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDirectory = FALSE;
    return [fileManager fileExistsAtPath:filePath isDirectory:&isDirectory];
}

/**
 *  初始化广告页面  LoginPageBgImageName
 */
+ (void)getDownImageWithType:(SaveDownImageType)type {
    
    
    NSString *Api;
    
    if (type == AdvertisingImage) {
        Api = @"";
    }else if (type == DeliveryOptionsType) {
        Api = @"";
    }
    
    
    // TODO 请求广告接口
//    WEAKSELF;
//    [ZYHttpManager HttpRequestDataWithApi:Api Aarameters:@{} httpMthod:POST Success:^(id data, NSString *event, NSString *message) {
//
//        //{"event":"SUCCESS","data":{"image":"public/470ddd141a93440a8195d6583a9db585"},"describe":""}
//        NSString *imageUrl = data[@"image"];
//
//        // 获取图片名:43-130P5122Z60-50.jpg
//        NSArray *stringArr = [imageUrl componentsSeparatedByString:@"/"];
//        NSString *imageName = stringArr.lastObject;
//
//        // 拼接沙盒路径
//        NSString *filePath = [self getFilePathWithImageName:imageName];
//        BOOL isExist = [self isFileExistWithFilePath:filePath];
//        if (!isExist){// 如果该图片不存在，则删除老图片，下载新图片
//
//            [weakSelf downloadAdImageWithUrl:imageUrl imageName:imageName WithType:type];
//        }
//
//    } failure:^(NSString *event, NSString *message) {
//
//    }];
    
}

/**
 *  下载新图片
 */
+ (void)downloadAdImageWithUrl:(NSString *)imageUrl imageName:(NSString *)imageName WithType:(SaveDownImageType)type {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", kPicDomain ,imageUrl]]];
        UIImage *image = [UIImage imageWithData:data];
        
        NSString *filePath = [self getFilePathWithImageName:imageName]; // 保存文件的名称
        
        if ([UIImagePNGRepresentation(image) writeToFile:filePath atomically:YES]) {// 保存成功
            JGLog(@"保存成功");
            
            NSString *ImageKey;
            if (type == AdvertisingImage) {
                ImageKey = @"";
            }else if (type == DeliveryOptionsType) {
                ImageKey = @"";
            }
            
            [self deleteOldImageWithImageName:ImageKey];
            [JGUserDefaults setValue:imageName forKey:ImageKey];
            [JGUserDefaults synchronize];
            // 如果有广告链接，将广告链接也保存下来
        }else{
            JGLog(@"保存失败");
        }
    });
}

/**
 *  删除旧图片
 */
+ (void)deleteOldImageWithImageName:(NSString *)ImageKey
{
    NSString *imageName = [JGUserDefaults valueForKey:ImageKey];
    if (imageName) {
        NSString *filePath = [self getFilePathWithImageName:imageName];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        [fileManager removeItemAtPath:filePath error:nil];
    }
}

/**
 *  根据图片名拼接文件路径
 */
+ (NSString *)getFilePathWithImageName:(NSString *)imageName
{
    if (imageName) {
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES);
        NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:imageName];
        
        return filePath;
    }
    
    return nil;
}


/**
 *  根据存储图片的key拼接文件路径
 */
+ (NSString *)getFilePathWithImageKey:(NSString *)imageKey {
    return [self getFilePathWithImageName:[JGUserDefaults valueForKey:imageKey]];
}





@end
