//
//  QJTextView.m
//  LH_QJ
//
//  Created by 郭军 on 2018/5/7.
//  Copyright © 2018年 LHYD. All rights reserved.
//

#import "QJTextView.h"

@implementation QJTextView


- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    // 添加监听器，监听自己的文字改变通知
    [JGNotification addObserver:self selector:@selector(textChange) name:UITextViewTextDidChangeNotification object:nil];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 添加监听器，监听自己的文字改变通知
        [JGNotification addObserver:self selector:@selector(textChange) name:UITextViewTextDidChangeNotification object:nil];
    }
    
    return self;
}


#pragma mark -- 调用 drawRect 方法
// 时刻监听文字键盘文字的变化，文字一旦改变便调用setNeedsDisplay方法
- (void)textChange {
    
    [self setNeedsDisplay];  // 该方法会调用drawRect:方法，立即重新绘制占位文字
}


#pragma mark -- 绘制占位文字
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    if (self.hasText) return;
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[NSFontAttributeName] = [UIFont systemFontOfSize:self.placeholderFont];
    dic[NSForegroundColorAttributeName] = self.placeholderColor;
    [self.placeholder drawInRect:CGRectMake(4, 8, self.bounds.size.width, self.bounds.size.height) withAttributes:dic];
}

#pragma mark -- 设置索引的位置和大小
- (CGRect)caretRectForPosition:(UITextPosition *)position {
    
    CGRect originalRect = [super caretRectForPosition:position];
    
    originalRect.size.height = self.font.lineHeight + 2;
    originalRect.size.width = 1.5;
    
    return originalRect;
}

// 占位文字的setter方法
- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    // 文字一旦改变，立马重写绘制（内部会调drawRect:方法）
    [self setNeedsDisplay];
    
}

- (void)setPlaceholderFont:(CGFloat)placeholderFont {
    
    _placeholderFont = placeholderFont;
    [self setNeedsDisplay];
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    
    _placeholderColor = placeholderColor;
    [self setNeedsDisplay];
}

// 字体属性setter方法
- (void)setFont:(UIFont *)font {
    [super setFont:font];
    [self setNeedsDisplay];
}


- (void)dealloc
{
    [JGNotification removeObserver:self];
}


@end
