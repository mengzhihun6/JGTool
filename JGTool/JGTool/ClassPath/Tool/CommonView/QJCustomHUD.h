//
//  QJCustomHUD.h
//  LH_QJ
//
//  Created by 郭军 on 2018/4/21.
//  Copyright © 2018年 LHYD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QJCustomHUD : UIView


@property(nonatomic ,strong)UIActivityIndicatorView *activityView;
@property(nonatomic ,strong)UIView  *bgView;
@property(nonatomic ,strong)UILabel *contentlabel;

/**
 *  单例
 *
 *  @return 返回实例对象
 */
+(QJCustomHUD *)shareCustomHud;

/**
 *  快速显示蒙版
 */
+ (void)showMessage:(NSString *)message;

/**
 *  快速显示正确
 */
+ (void)showSuccess:(NSString *)message;

/**
 *  快速显示错误
 */
+ (void)showError:(NSString *)message;

/**
 *  停止并隐藏
 */
+(void)hideHUD;

/**
 *  设置显示内容以及等待时间
 *
 *  @param time    等待时间
 *  @param content 显示内容
 */
+(void)createHudCustomTime:(CGFloat)time showContent:(NSString *)content;

/**
 *  设置显示内容
 *
 *  @param content 显示内容
 */
+(void)createHudCustomShowContent:(NSString *)content;

/**
 *  仅显示提示语
 *
 *  @param content 提示语
 *  @param time    设置隐藏时间
 */
+(void)createShowContent:(NSString *)content hiddenTime:(CGFloat)time;





@end
