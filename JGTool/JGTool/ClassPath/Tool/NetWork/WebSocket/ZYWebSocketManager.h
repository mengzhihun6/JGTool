//
//  ZYWebSocketManager.h
//  FD_iPad
//
//  Created by 郭军 on 2019/8/7.
//  Copyright © 2019 ZYWL. All rights reserved.
//  商品同步这部分不用手动配置ip和端口

#import <Foundation/Foundation.h>
#import <SRWebSocket.h> //websocket

NS_ASSUME_NONNULL_BEGIN

@interface ZYWebSocketManager : NSObject

@property (nonatomic, strong) SRWebSocket *webSocket;

/** 单例 */
+ (instancetype)shared;

/** 开始连接 */
- (void)connectServerWithApi:(NSString *)urlString;

/** 关闭连接 */
- (void)SRWebSocketClose;

/** 发送数据 */
- (void)sendData:(id)data;

@end

NS_ASSUME_NONNULL_END
