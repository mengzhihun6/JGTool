//
//  NSMutableAttributedString+JGStringAttribute.h
//  JGStringAttribute
//
//  Created by 郭军 on 2018/5/29.
//  Copyright © 2018年 LHYD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JGStringAttributeProtocol.h"

@interface NSMutableAttributedString (JGStringAttribute)

/**
 *  添加富文本对象
 *
 *  @param stringAttribute 实现了StringAttributeProtocol协议的对象
 */
- (void)addStringAttribute:(id <JGStringAttributeProtocol>)stringAttribute;

/**
 *  消除指定的富文本对象
 *
 *  @param stringAttribute 实现了StringAttributeProtocol协议的对象
 */
- (void)removeStringAttribute:(id <JGStringAttributeProtocol>)stringAttribute;

@end
