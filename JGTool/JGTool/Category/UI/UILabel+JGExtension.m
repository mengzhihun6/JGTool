//
//  UILabel+JGExtension.m
//  FD_iPad
//
//  Created by 郭军 on 2019/5/5.
//  Copyright © 2019 ZYWL. All rights reserved.
//

#import "UILabel+JGExtension.h"
#import "objc/Runtime.h"

@implementation UILabel (JGExtension)

- (NSString *)verticalText{
    // 利用runtime添加属性
    return objc_getAssociatedObject(self, @selector(verticalText));
}

- (void)setVerticalText:(NSString *)verticalText{
    objc_setAssociatedObject(self, &verticalText, verticalText, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    NSMutableString *str = [[NSMutableString alloc] initWithString:verticalText];
    NSInteger count = str.length;
    for (int i = 1; i < count; i ++) {
        [str insertString:@"\n" atIndex:i*2-1];
    }
    self.text = str;
    self.numberOfLines = 0;
}

@end
