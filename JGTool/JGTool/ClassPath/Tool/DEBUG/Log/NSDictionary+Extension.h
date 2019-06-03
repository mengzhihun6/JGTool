//
//  NSString+Extension.h
//
//  Created by apple on 14-4-2.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSDictionary (Extension)
/**
 *  返回json字符串
 */
@property (nonatomic,copy) NSString* json;
- (NSString*)tojson:(NSDictionary*)dic;
@end
