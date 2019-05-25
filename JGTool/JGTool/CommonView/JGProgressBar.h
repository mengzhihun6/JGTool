//
//  JGProgressBar.h
//  FD_iPad
//
//  Created by 郭军 on 2019/4/25.
//  Copyright © 2019 ZYWL. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JGProgressBar : UIView

/** 进度条背景颜色 默认是白色背景*/
@property (nonatomic, strong) UIColor *ProgressBgColor;
/** 进度条颜色 默认是红色进度 */
@property (nonatomic, strong) UIColor *ProgressColor;
/** 进度条进度 */
@property (nonatomic, assign) CGFloat progress;

@end

NS_ASSUME_NONNULL_END
