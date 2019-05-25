//
//  UIView+JGExtension.m
//  百思
//
//  Created by JUN on 16/5/16.
//  Copyright © 2016年 JUN. All rights reserved.
//

#import "UIView+JGExtension.h"

@implementation UIView (JGExtension)

- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (void)setX:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (void)setY:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

-(void)setBottom:(CGFloat)bottom{
    CGRect frame = self.frame;
    CGFloat diff = bottom - (self.frame.origin.y + self.frame.size.height);
    frame.origin.y += diff;
    self.frame = frame;
    
}

-(void)setRight:(CGFloat)right{
    CGRect frame = self.frame;
    CGFloat diff = right - (self.frame.origin.x + self.frame.size.width);
    frame.origin.x += diff;
    self.frame = frame;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

-(CGFloat)bottom{
    return self.frame.origin.y + self.frame.size.height;
}

- (CGSize)size {
    return self.frame.size;
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (CGFloat)x {
    return self.frame.origin.x;
}

- (CGFloat)y {
    return self.frame.origin.y;
}

-(CGFloat)right{
    return self.frame.origin.x + self.frame.size.width;
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (CGFloat)centerX
{
    return self.center.x;
}

//加载同名的xib
+ (instancetype)viewFromXib
{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
}


//判断两个视图在同一窗口是否有重叠
- (BOOL)intersectWithView:(UIView *)view
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    CGRect selfRect = [self convertRect:self.bounds toView:window];
    CGRect viewRect = [view convertRect:view.bounds toView:window];
    return CGRectIntersectsRect(selfRect, viewRect);
}




#pragma mark - 实现虚线功能  -
- (void)addBorderDottedLinewithColor:(UIColor *)color {
    
    CAShapeLayer *border = [CAShapeLayer layer];
    //  线条颜色
    border.strokeColor = color.CGColor;
    
    border.fillColor = nil;
    
    
    UIBezierPath *pat = [UIBezierPath bezierPath];
    [pat moveToPoint:CGPointMake(0, 0)];
    if (CGRectGetWidth(self.frame) > CGRectGetHeight(self.frame)) {
        [pat addLineToPoint:CGPointMake(self.bounds.size.width, 0)];
    }else{
        [pat addLineToPoint:CGPointMake(0, self.bounds.size.height)];
    }
    border.path = pat.CGPath;
    
    border.frame = self.bounds;
    
    // 不要设太大 不然看不出效果
    border.lineWidth = 0.5;
    border.lineCap = @"butt";
    
    //  第一个是 线条长度   第二个是间距    nil时为实线
    border.lineDashPattern = @[@4, @3];
    
    [self.layer addSublayer:border];
    
    
}



@end
