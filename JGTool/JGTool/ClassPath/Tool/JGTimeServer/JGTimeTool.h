//
//  JGTimeTool.h
//  FD_iPad
//
//  Created by 郭军 on 2019/7/31.
//  Copyright © 2019 ZYWL. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JGTimeTool : NSObject


// 获取当前时间戳
+ (long long)getCurrentTimeInterval;

//获取当前时间戳  精确到毫秒
+ (NSString *)currentTimeStr;

//时间戳转换日期
+ (NSString *)timeWithTimeIntervalString:(long long)time dateFormatter:(NSString *)formatter;

/** NSDate转时间戳*/
+(long long)getDateTimeTOMilliSeconds:(NSDate *)datetime;

/**将某个时间转化成 时间戳*/
+(NSInteger)timeSwitchTimestamp:(NSString *)formatTime andFormatter:(NSString *)format;


/**时间戳转NSDate*/
+(NSDate *)timeValueTODate:(long)timeValue;

/**
 根据传入的时间戳返回N月后的时间戳
 
 @param timeStamp 传入的时间戳
 @param month N月
 @return N月后的时间戳
 */
+(long )getPriousorLaterDateFromDate:(long long)timeStamp withMonth:(int)month;





@end

NS_ASSUME_NONNULL_END
