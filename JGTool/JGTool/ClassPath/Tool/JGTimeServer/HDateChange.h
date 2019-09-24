//
//  HDateChange.h
//  Here
//
//  Created by 常旺伟 on 2018/1/25.
//  Copyright © 2018年 DUC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ios-ntp.h"
@interface HDateChange : NSObject
/**获取当前时间的 时间戳*/
+(long long)getNowTimestamp;
/**将某个时间戳转化成 时间*/
+(NSString *)timestampSwitchTime:(NSInteger)timestamp andFormatter:(NSString *)format;
/**将某个时间转化成 时间戳*/
+(NSInteger)timeSwitchTimestamp:(NSString *)formatTime andFormatter:(NSString *)format;
/** NSDate转时间戳*/
+(long long)getDateTimeTOMilliSeconds:(NSDate *)datetime;
/**时间戳转NSDate*/
+(NSDate *)timeValueTODate:(long)timeValue;
/**从国际服务器来获取网络时间*/
+ (NSDate *)getInternetDate;
@end
