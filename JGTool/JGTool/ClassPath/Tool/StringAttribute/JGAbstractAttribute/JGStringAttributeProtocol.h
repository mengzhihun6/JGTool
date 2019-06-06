//
//  JGStringAttributeProtocol.h
//  JGStringAttribute
//
//  Created by 郭军 on 2018/5/29.
//  Copyright © 2018年 LHYD. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol JGStringAttributeProtocol <NSObject>


#pragma mark - 必须实现
@required

/**
 *  属性名字
 *
 *  @return 属性名字
 */
- (NSString *)attributeName;

/**
 *  属性对应的值
 *
 *  @return 对应的值
 */
- (id)attributeValue;

@optional

#pragma mark - 可选实现
/**
 *  属性设置生效范围
 *
 *  @return 生效的范围
 */
- (NSRange)effectiveStringRange;


@end
