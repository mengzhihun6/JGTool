//
//  JGLocationUtil.h
//  FD_Rider
//
//  Created by 郭军 on 2019/3/28.
//  Copyright © 2019 zhiyuan. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CoreLocation/CoreLocation.h>

typedef void(^JGLocationResuleBlock)(CLLocationManager * _Nonnull locationManager, NSArray<CLLocation *> * _Nonnull updateLocations);


NS_ASSUME_NONNULL_BEGIN

@interface JGLocationUtil : NSObject


+ (void)startUpdateLocationAlwaysWith:(JGLocationResuleBlock)locationResultBlock;

+ (void)startLocateOnceWith:(JGLocationResuleBlock)locateOnceResultBlock API_AVAILABLE(ios(9.0));





@end

NS_ASSUME_NONNULL_END
