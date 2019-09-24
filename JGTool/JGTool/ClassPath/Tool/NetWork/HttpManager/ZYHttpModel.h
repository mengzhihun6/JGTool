//
//  ZYHttpModel.h
//  FD_Rider
//
//  Created by 郭军 on 2019/3/18.
//  Copyright © 2019年 zhiyuan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZYHttpModel : NSObject

@property (copy, nonatomic) NSString *event;

@property (copy, nonatomic) NSString *describe;

@property (strong, nonatomic) id data;

- (instancetype)initWithObject:(id)object;

@end

NS_ASSUME_NONNULL_END
