//
//  ZYWebSocketHeader.h
//  FD_iPad
//
//  Created by 郭军 on 2019/8/19.
//  Copyright © 2019 ZYWL. All rights reserved.
//

#ifndef ZYWebSocketHeader_h
#define ZYWebSocketHeader_h

//局域网路径 10.10.10.10
#define PRINT_SERVER_PATH [JGCommonTools getUserDefaultsWithKey:FDPrintNetworkIP]
//局域网端口 321
#define PRINT_SERVER_PORT [JGCommonTools getUserDefaultsWithKey:FDPrintNetworkPort]
//链接路径
#define PRINT_SOCKET_PATH  [NSString stringWithFormat:@"ws://%@:%@/websocket/print",PRINT_SERVER_PATH,PRINT_SERVER_PORT]






#import "ZYPrintWebSocketManager.h" // 打印WebSocket
#import "ZYWebSocketManager.h" //同步商品信息WebSocket


#endif /* ZYWebSocketHeader_h */
