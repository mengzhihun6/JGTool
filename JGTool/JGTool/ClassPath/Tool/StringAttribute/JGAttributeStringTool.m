//
//  JGAttributeStringTool.m
//  JGStringAttribute
//
//  Created by 郭军 on 2018/5/29.
//  Copyright © 2018年 LHYD. All rights reserved.
//

#import "JGAttributeStringTool.h"

@implementation JGAttributeStringTool

+ (NSMutableAttributedString *)getPriceAttributedStringWithString:(NSString *)showString fullFont:(CGFloat)Font fullColor:(UIColor *)Color partFont:(CGFloat)Font1 partColor:(UIColor *)Color1 {
    
    // 全局设置
    JGFontAttribute *fullFont = [JGFontAttribute new];
    fullFont.font           = [UIFont fontWithName:@"AppleSDGothicNeo-UltraLight" size:Font];
    fullFont.effectRange    = NSMakeRange(0, showString.length);
    
    JGForegroundColorAttribute *fullColor = [JGForegroundColorAttribute new];
    fullColor.color                     = Color;
    fullColor.effectRange               = NSMakeRange(0, showString.length);
    
    // 局部设置
    JGFontAttribute *partFont = [JGFontAttribute new];
    partFont.font           = [UIFont fontWithName:@"AppleSDGothicNeo-UltraLight" size:Font1];
    partFont.effectRange    = NSMakeRange(0, 1);
    
    JGForegroundColorAttribute *partColor = [JGForegroundColorAttribute new];
    partColor.color                     = Color1;
    partColor.effectRange               = NSMakeRange(0, 1);
    
    return [showString mutableAttributedStringWithStringAttributes:@[fullFont,
                                                                     partFont,
                                                                     fullColor,
                                                                     partColor]];
}

@end
