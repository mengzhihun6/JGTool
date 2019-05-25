//
//  JGModelFileTool.m
//  FD_Rider
//
//  Created by 郭军 on 2019/3/29.
//  Copyright © 2019 zhiyuan. All rights reserved.
//

#import "JGModelFileTool.h"
#import "YBModelFile.h"

@implementation JGModelFileTool




+ (void)BeginCreateModelFileWithFileName:(NSString *)fileName andData:(id)data  {
    
    
    
    /* 全局公用配置 (只需设置在使用工具之前就行了) */
    
    //属性或方法是否空行
    //        [YBMFConfig shareConfig].fileHHandler.ybmf_skipLine = YES;
    //        [YBMFConfig shareConfig].fileMHandler.ybmf_skipLine = YES;
    //是否需要实现 NSCoding 或 NSCopying 协议
    //        [YBMFConfig shareConfig].needCoding = NO;
    //        [YBMFConfig shareConfig].needCopying = NO;
    //设置类名公用后缀
    //        [YBMFConfig shareConfig].fileSuffix = @"File";
    //设置忽略类型
    //        [YBMFConfig shareConfig].ignoreType = YBMFIgnoreTypeAllDigital | YBMFIgnoreTypeMutable;
    //设置文件划分策略
    //        [YBMFConfig shareConfig].filePartitionMode = YBMFFilePartitionModeApart;
    //设置工程用的字典转模型框架
    //        [YBMFConfig shareConfig].framework = YBMFFrameworkMJ;
    
    
    [YBMFConfig shareConfig].fileHHandler.ybmf_skipLine = YES;
    [YBMFConfig shareConfig].fileMHandler.ybmf_skipLine = YES;
    [YBMFConfig shareConfig].needCoding = NO;
    [YBMFConfig shareConfig].needCopying = NO;
    
    [YBMFConfig shareConfig].framework = YBMFFrameworkMJ;
    
    
    //解析 json 数据
    [YBModelFile createFileWithName:fileName data:data];
}







@end
