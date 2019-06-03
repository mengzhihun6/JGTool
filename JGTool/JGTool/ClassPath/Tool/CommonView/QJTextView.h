//
//  QJTextView.h
//  LH_QJ
//
//  Created by 郭军 on 2018/5/7.
//  Copyright © 2018年 LHYD. All rights reserved.
//  带有占位文字的 textView

/*
 使用
 self.textView = [[QJTextView alloc] initWithFrame:CGRectMake(15, 100, [UIScreen mainScreen].bounds.size.width-30, 100)];
 self.textView.placeholderColor = [UIColor grayColor];
 self.textView.placeholderFont = 15;
 self.textView.placeholder = @"我是打酱油的";
 [self.view addSubview:self.textView];
 NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
 paragraphStyle.lineSpacing = 10;
 self.textView.typingAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:15],NSParagraphStyleAttributeName:paragraphStyle};
 self.textView.layer.borderWidth = 0.5;
 self.textView.layer.borderColor = [UIColor redColor].CGColor;
 
 */


#import <UIKit/UIKit.h>


@interface QJTextView : UITextView
/** 占位文字 */
@property (weak, nonatomic) NSString *placeholder;
/** 占位文字颜色 */
@property (nonatomic, strong) UIColor *placeholderColor;
/** 占位文字大小 */
@property (nonatomic, assign) CGFloat placeholderFont;

@end
