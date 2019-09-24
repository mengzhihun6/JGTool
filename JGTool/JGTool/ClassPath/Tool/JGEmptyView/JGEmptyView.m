//
//  JGEmptyView.m
//  FD_Rider
//
//  Created by 郭军 on 2019/3/25.
//  Copyright © 2019 zhiyuan. All rights reserved.
//

#import "JGEmptyView.h"

@implementation JGEmptyView


/**
 构造方法4 - 创建一个自定义的emptyView
 
 @return 返回一个自定义内容的emptyView
 */
+ (instancetype)diyImageEmptyView {
    
    UILabel *InfoLbl = [UILabel new];
    InfoLbl.text = @"暂无数据";
    InfoLbl.textColor = [UIColor blackColor];
    InfoLbl.font = JGFont(18);
    [InfoLbl sizeToFit];
    return [JGEmptyView emptyViewWithCustomView:InfoLbl];
}





- (void)prepare{
    [super prepare];
    
    self.autoShowEmptyView = NO;
    
    self.contentViewY = 180;
    
    //    self.titleLabTextColor = JGRGBColor(180, 30, 50);
    //    self.titleLabFont = [UIFont systemFontOfSize:18];
    //
    //    self.detailLabTextColor = JGRGBColor(80, 80, 80);
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
