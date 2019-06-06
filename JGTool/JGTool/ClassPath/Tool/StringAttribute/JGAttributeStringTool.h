//
//  JGAttributeStringTool.h
//  JGStringAttribute
//
//  Created by 郭军 on 2018/5/29.
//  Copyright © 2018年 LHYD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JGStringAttributeHelper.h"

@interface JGAttributeStringTool : NSObject

/*
 使用案例:
 // 显示的label
 UILabel *label       = [[UILabel alloc] initWithFrame:CGRectMake(0, 200, 300, 30)];
 label.center         = self.view.center;
 label.textAlignment  = NSTextAlignmentCenter;
 label.attributedText = [JGAttributeStringTool getPriceAttributedStringWithString:@"¥199.0" fullFont:32.0f fullColor:[UIColor blackColor] partFont:20.0f partColor:[UIColor redColor]];
 
 [self.view addSubview:label];
 */

+ (NSMutableAttributedString *)getPriceAttributedStringWithString:(NSString *)showString fullFont:(CGFloat)Font fullColor:(UIColor *)Color partFont:(CGFloat)Font1 partColor:(UIColor *)Color1;


@end
