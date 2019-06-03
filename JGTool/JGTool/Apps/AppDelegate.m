//
//  AppDelegate.m
//  JGTool
//
//  Created by 郭军 on 2019/5/25.
//  Copyright © 2019 JG. All rights reserved.
//

#import "AppDelegate.h"
#import "JGTabBarController.h"

@interface AppDelegate ()
@property (nonatomic, strong) Reachability *hostReach;
@end

@implementation AppDelegate



//创建窗口和可视控制器
- (void)createWindowAndVisibleCtr {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    self.window.backgroundColor = [UIColor whiteColor];
    
    
    self.window.rootViewController = [[JGTabBarController alloc] init];
    
    //适配iOS11
    if (@available(iOS 11.0, *)) {
        UITableView.appearance.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        UITableView.appearance.estimatedRowHeight = 0;
        UITableView.appearance.estimatedSectionFooterHeight = 0;
        UITableView.appearance.estimatedSectionHeaderHeight = 0;
    }
    
    [self.window makeKeyAndVisible];
}



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [self createWindowAndVisibleCtr];
    
    //网络监测
    [self judgeNetWorkState];
    
    
    return YES;
}



#pragma mark - 网络监测 -
- (void)judgeNetWorkState {
    
    //先设置网络监测状态为YES
    self.isReachable = YES;
    
    //开启网络状况的监听
    [JGNotification addObserver:self
                       selector:@selector(reachabilityChanged:)
                           name:kReachabilityChangedNotification
                         object:nil];
    self.hostReach = [Reachability reachabilityWithHostname:@"v2.api.dev.fudiandmore.ie"] ;
    [self.hostReach startNotifier];  //开始监听，会启动一个run loop
}

//网络链接改变时会调用的方法
- (void)reachabilityChanged:(NSNotification *)note {
    Reachability *currReach = [note object];
    NSParameterAssert([currReach isKindOfClass:[Reachability class]]);
    
    //对连接改变做出响应处理动作
    NetworkStatus status = [currReach currentReachabilityStatus];
    //如果没有连接到网络就弹出提醒实况
    if(status == NotReachable)
    {
        self.isReachable = NO;
        [QJCustomHUD showError:@"Network connection error, please try again later"];
        JGLog(@"无网====-");
    }
    else
    {
        JGLog(@"有网------");
        self.isReachable = YES;
    }
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
