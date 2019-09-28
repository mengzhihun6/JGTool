//
//  JGSocketRocketUtility.h
//  SUN
//
//  Created by 孙俊 on 17/2/16.
//  Copyright © 2017年 SUN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SocketRocket.h>

extern NSString * const kNeedPayOrderNote;
extern NSString * const kWebSocketDidOpenNote;
extern NSString * const kWebSocketDidCloseNote;
extern NSString * const kWebSocketdidReceiveMessageNote;

@interface JGSocketRocketUtility : NSObject

/** 获取连接状态 */
@property (nonatomic,assign,readonly) SRReadyState socketReadyState;

/** 开始连接 */
- (void)SRWebSocketOpenWithURLString:(NSString *)urlString;

/** 关闭连接 */
- (void)SRWebSocketClose;

/** 发送数据 */
- (void)sendData:(id)data;

+ (JGSocketRocketUtility *)instance;

@end


/*
 在 UIViewController 中使用
 
 - (void)viewDidLoad {
 [super viewDidLoad];
 
 [[SocketRocketUtility instance] SRWebSocketOpenWithURLString:@"ws://10.10.10.10:663"];
 [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(SRWebSocketDidOpen) name:kWebSocketDidOpenNote object:nil];
 [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(SRWebSocketDidReceiveMsg:) name:kWebSocketDidCloseNote object:nil];
 
 
 //    [[SocketRocketUtility instance] SRWebSocketClose]; 在需要得地方 关闭socket
 }
 
 - (void)SRWebSocketDidOpen {
 NSLog(@"开启成功");
 //在成功后需要做的操作。。。
 
 }
 
 - (void)SRWebSocketDidReceiveMsg:(NSNotification *)note {
 //收到服务端发送过来的消息
 NSString * message = note.object;
 NSLog(@"%@",message);
 }
 
 */
