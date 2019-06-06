//
//  NSMutableAttributedString+JGStringAttribute.m
//  JGStringAttribute
//
//  Created by 郭军 on 2018/5/29.
//  Copyright © 2018年 LHYD. All rights reserved.
//

#import "NSMutableAttributedString+JGStringAttribute.h"

@implementation NSMutableAttributedString (JGStringAttribute)

- (void)addStringAttribute:(id <JGStringAttributeProtocol>)stringAttribute {
    
    [self addAttribute:[stringAttribute attributeName]
                 value:[stringAttribute attributeValue]
                 range:[stringAttribute effectiveStringRange]];
}

- (void)removeStringAttribute:(id <JGStringAttributeProtocol>)stringAttribute {
    
    [self removeAttribute:[stringAttribute attributeName]
                    range:[stringAttribute effectiveStringRange]];
}

@end
