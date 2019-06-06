//
//  NSString+JGStringAttribute.h
//  JGStringAttribute
//
//  Created by 郭军 on 2018/5/29.
//  Copyright © 2018年 LHYD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JGStringAttributeProtocol.h"

@interface NSString (JGStringAttribute)

/**
 *  创建可变富文本(可以设置富文本局部的值,协议对象的range值有效)
 *
 *  @param attributes 所有实现了StringAttributeProtocol协议的对象(协议中的对象需要设置range值)
 *
 *  @return 可变富文本
 */
- (NSMutableAttributedString *)mutableAttributedStringWithStringAttributes:(NSArray *)attributes;

/**
 *  创建不可变富文本(所有的设置都是全局设置,协议对象的range值无效)
 *
 *  @param attributes 所有实现了StringAttributeProtocol协议的对象(协议中的对象不需要设置range值)
 *
 *  @return 不可变富文本
 */
- (NSAttributedString *)attributedStringWithStringAttributes:(NSArray *)attributes;

@end
