//
//  JGWKWebViewController.h
//  JGTool
//
//  Created by 郭军 on 2019/6/3.
//  Copyright © 2019 JG. All rights reserved.
//

#import "JGBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface JGWKWebViewController : JGBaseViewController

/** url 网址 */
@property (nonatomic, copy) NSString *webViewUrl;
/* 进度条颜色设置 */
@property (nonatomic, copy) NSString *webViewBarTintColor;
/* 可以自定义进度条 */
@property (nonatomic, retain) UIView *progressView;

@end

NS_ASSUME_NONNULL_END
