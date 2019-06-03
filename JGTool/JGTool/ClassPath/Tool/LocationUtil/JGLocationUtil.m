//
//  JGLocationUtil.m
//  FD_Rider
//
//  Created by 郭军 on 2019/3/28.
//  Copyright © 2019 zhiyuan. All rights reserved.
//

#import "JGLocationUtil.h"
#import <UIKit/UIKit.h>


@interface JGLocationUtil()<CLLocationManagerDelegate>

@property (strong, nonatomic) CLLocationManager *locationManger;
@property (copy, nonatomic) JGLocationResuleBlock locationResultBlock;
@property (copy, nonatomic) JGLocationResuleBlock locateOnceResultBlock;

@end


@implementation JGLocationUtil


+ (instancetype)sharedLocationUtil
{
    static JGLocationUtil *sharedLocationUtil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedLocationUtil = [[JGLocationUtil alloc] init];
    });
    
    return sharedLocationUtil;
}

- (instancetype)init
{
    if (self = [super init])
    {
        self.locationManger = [[CLLocationManager alloc] init];
        self.locationManger.delegate = self;
        self.locationManger.distanceFilter = kCLDistanceFilterNone;
        //        self.locationManger.distanceFilter = 1;
        self.locationManger.desiredAccuracy = kCLLocationAccuracyBest;
        self.locationManger.pausesLocationUpdatesAutomatically = NO;
        if (@available(iOS 8.0, *))
        {
            //请求一直定位
            [self.locationManger requestAlwaysAuthorization];
            //请求使用中定位
            [self.locationManger requestWhenInUseAuthorization];
        }
        if (@available(iOS 9.0, *))
        {
            self.locationManger.allowsBackgroundLocationUpdates = YES;
        }
        if (@available(iOS 11.0, *))
        {
            self.locationManger.showsBackgroundLocationIndicator = YES;
        }
        
        
    }
    
    return self;
}

#pragma mark - func

+ (void)startUpdateLocationAlwaysWith:(JGLocationResuleBlock)locationResultBlock
{
    [[self sharedLocationUtil] startUpdateLocationAlwaysWith:locationResultBlock];
}

- (void)startUpdateLocationAlwaysWith:(JGLocationResuleBlock)locationResultBlock
{
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied)
    {
        JGLog(@"定位权限未开");
        return;
    }
    
    self.locationResultBlock = locationResultBlock;
    [self.locationManger startUpdatingLocation];
}

+ (void)startLocateOnceWith:(JGLocationResuleBlock)locateOnceResultBlock
{
    [[self sharedLocationUtil] startLocateOnceWith:locateOnceResultBlock];
}

- (void)startLocateOnceWith:(JGLocationResuleBlock)locateOnceResultBlock
{
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied)
    {
        JGLog(@"定位权限未开");
        return;
    }
    
    if (@available(iOS 9.0, *))
    {
        self.locateOnceResultBlock = locateOnceResultBlock;
        [self.locationManger requestLocation];
    }
}


#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    
    !self.locationResultBlock ? : self.locationResultBlock(manager, locations);
    !self.locateOnceResultBlock ? : self.locateOnceResultBlock(manager, locations);
    self.locateOnceResultBlock = nil;
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    switch (status) {
            // 用户还未决定
        case kCLAuthorizationStatusNotDetermined:
        {
            JGLog(@"用户还未决定");
            
            break;
        }
            // 访问受限
        case kCLAuthorizationStatusRestricted:
        {
            JGLog(@"访问受限");
            break;
        }
            // 定位关闭时和对此APP授权为never时调用
        case kCLAuthorizationStatusDenied:
        {
            // 定位是否可用（是否支持定位或者定位是否开启）
            if([CLLocationManager locationServicesEnabled])
            {
                JGLog(@"定位开启，但被拒");
            }else
            {
                JGLog(@"定位关闭，不可用, 请在设置中打开定位服务选项");
            }
            //            JGLog(@"被拒");
            break;
        }
            // 获取前后台定位授权
        case kCLAuthorizationStatusAuthorizedAlways:
        {
            JGLog(@"获取前后台定位授权");
            break;
        }
            // 获得前台定位授权
        case kCLAuthorizationStatusAuthorizedWhenInUse:
        {
            JGLog(@"获得前台定位授权");
            break;
        }
    }
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    JGLog(@"error:%@", error);
}







@end
