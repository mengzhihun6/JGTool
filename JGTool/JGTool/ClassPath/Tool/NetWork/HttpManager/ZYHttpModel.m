//
//  ZYHttpModel.m
//  FD_Rider
//
//  Created by 郭军 on 2019/3/18.
//  Copyright © 2019年 zhiyuan. All rights reserved.
//

#import "ZYHttpModel.h"

@implementation ZYHttpModel

- (instancetype)initWithObject:(id)object {
    if (self = [super init]) {
        self.event        =     [object valueForKey:@"event"];
        self.describe   =     [object valueForKey:@"describe"];
        self.data          =     [object valueForKey:@"data"];
    }
    return self;
}



@end
