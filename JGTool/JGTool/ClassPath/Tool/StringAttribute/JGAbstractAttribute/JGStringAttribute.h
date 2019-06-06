//
//  JGStringAttribute.h
//  JGStringAttribute
//
//  Created by 郭军 on 2018/5/29.
//  Copyright © 2018年 LHYD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JGStringAttributeProtocol.h"
#import <UIKit/UIKit.h>

@interface JGStringAttribute : NSObject <JGStringAttributeProtocol>

/**
 *  富文本设置的生效范围
 */
@property (nonatomic) NSRange  effectRange;


@end
