//
//  JGBaseViewController.h
//  JGTool
//
//  Created by 郭军 on 2019/6/3.
//  Copyright © 2019 JG. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JGBaseViewController : UIViewController

@property (nonatomic, assign) BOOL isHideBackItem;

///右滑返回功能，默认开启（YES）
- (BOOL)gestureRecognizerShouldBegin;

-(NSString *)backItemImageName;

@end

NS_ASSUME_NONNULL_END
