//
//  JGTimeTool.m
//  FD_iPad
//
//  Created by 郭军 on 2019/7/31.
//  Copyright © 2019 ZYWL. All rights reserved.
//

#import "JGTimeTool.h"

@implementation JGTimeTool

// 获取当前时间戳
+ (long long)getCurrentTimeInterval {
    NSDate* datenow = [NSDate dateWithTimeIntervalSinceNow:0];//获取当前时间0秒后的时间
    //时间转时间戳的方法:
    NSInteger timeSp = [[NSNumber numberWithDouble:[datenow timeIntervalSince1970]] integerValue];
    return timeSp;
}

//获取当前时间戳
+ (NSString *)currentTimeStr {
    
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];//获取当前时间0秒后的时间
    NSTimeInterval time=[date timeIntervalSince1970]*1000;// *1000 是精确到毫秒，不乘就是精确到秒
    NSString *timeString = [NSString stringWithFormat:@"%.0f", time];
    return timeString;
}



//时间戳转换日期
+ (NSString *)timeWithTimeIntervalString:(long long)time dateFormatter:(NSString *)formatter {
    
    NSString *timeStr = [NSString stringWithFormat:@"%lld",time];
    
    if (timeStr.length == 13) {
        time = time / 1000.0;
    }
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    if (!formatter) {
        formatter = @"yyyy-MM-dd HH:mm:ss";
    }
    [dateFormatter setDateFormat:formatter];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}


/** NSDate转时间戳*/
+(long long)getDateTimeTOMilliSeconds:(NSDate *)datetime {
    NSTimeInterval interval = [datetime timeIntervalSince1970];
    long long totalMilliseconds = interval*1000 ;
//    JGLog(@"totalMilliseconds=%llu",totalMilliseconds);
    return totalMilliseconds;
}

+(NSInteger)timeSwitchTimestamp:(NSString *)formatTime andFormatter:(NSString *)format{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:format]; //(@"YYYY-MM-dd hh:mm:ss") ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    
    [formatter setTimeZone:timeZone];
    
    NSDate* date = [formatter dateFromString:formatTime]; //------------将字符串按formatter转成nsdate
    
    //时间转时间戳的方法:
    NSInteger timeSp = [[NSNumber numberWithDouble:[date timeIntervalSince1970]] integerValue];
    
    JGLog(@"将某个时间转化成 时间戳&&&&&&&timeSp:%ld",(long)timeSp); //时间戳的值
    
    return timeSp;
}


/**时间戳转NSDate*/
+(NSDate *)timeValueTODate:(long)timeValue{
    long date = timeValue / 1000;
    NSDate *dates = [NSDate dateWithTimeIntervalSince1970:date];
    return dates;
}

+(long )getPriousorLaterDateFromDate:(long long)timeStamp withMonth:(int)month{
    
    NSDate *date   = [NSDate dateWithTimeIntervalSince1970:timeStamp];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setMonth:month];
    NSCalendar *calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];// NSGregorianCalendar
    NSDate *mDate = [calender dateByAddingComponents:comps toDate:date options:0];
    return [mDate timeIntervalSince1970];
}


@end
