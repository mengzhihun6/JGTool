//
//  JGProgressBar.m
//  FD_iPad
//
//  Created by 郭军 on 2019/4/25.
//  Copyright © 2019 ZYWL. All rights reserved.
//

#import "JGProgressBar.h"


@interface JGProgressBar ()

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UIView *tView;

@end


@implementation JGProgressBar


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //边框
        _bgView = [[UIView alloc] initWithFrame:self.bounds];
        CGFloat heigth = self.bounds.size.height;
        _bgView.layer.cornerRadius = heigth * 0.5f;
        _bgView.layer.masksToBounds = YES;
        _bgView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_bgView];
        
        
        //进度
        _tView = [[UIView alloc] init];
        _tView.backgroundColor = [UIColor redColor];
        _tView.layer.cornerRadius = heigth * 0.5f;
        _tView.layer.masksToBounds = YES;
        [self addSubview:_tView];
    }
    
    return self;
}


- (void)setProgressBgColor:(UIColor *)ProgressBgColor {
    _ProgressBgColor = ProgressBgColor;
    _bgView.backgroundColor = ProgressBgColor;
}


- (void)setProgressColor:(UIColor *)ProgressColor {
    _ProgressColor = ProgressColor;
    _tView.backgroundColor = ProgressColor;
}




- (void)setProgress:(CGFloat)progress
{
    _progress = progress;
    
    CGFloat maxWidth = self.bounds.size.width;
    CGFloat heigth = self.bounds.size.height;
    
    _tView.frame = CGRectMake(0, 0, maxWidth * progress, heigth);
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
