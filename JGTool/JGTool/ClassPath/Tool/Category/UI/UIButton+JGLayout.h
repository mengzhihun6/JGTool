//
//  UIButton+JGLayout.h
//  FD_Rider
//
//  Created by 郭军 on 2019/3/16.
//  Copyright © 2019年 zhiyuan. All rights reserved.
//



NS_ASSUME_NONNULL_BEGIN

@interface UIButton (JGLayout)

/**
 layout titleLabel and imageView in UIButton
 
 title     :   text in button
 titleFont :   text's font
 image     :   image in button
 gap       :   gap between button and image
 layType   :   0:title---left ,image---right
 1:title---right ,image---left
 2:title---down ,image---up
 */
-(void)layoutButtonForTitle:(NSString *)title
                  titleFont:(UIFont *)titleFont
                      image:(UIImage *)image
                 gapBetween:(CGFloat)gap
                    layType:(NSInteger)layType;

@end

NS_ASSUME_NONNULL_END
