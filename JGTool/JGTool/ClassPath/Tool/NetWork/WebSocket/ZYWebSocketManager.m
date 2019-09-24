//
//  ZYWebSocketManager.m
//  FD_iPad
//
//  Created by 郭军 on 2019/8/7.
//  Copyright © 2019 ZYWL. All rights reserved.
//

#import "ZYWebSocketManager.h"

@interface ZYWebSocketManager() <SRWebSocketDelegate> {
    
    NSTimeInterval reConnectTime;
}

@property (nonatomic,copy) NSString *urlString;

@property (nonatomic, strong) NSTimer *heartBeatTimer; //心跳定时器

@end


@implementation ZYWebSocketManager


//单例
+ (instancetype)shared {
    static ZYWebSocketManager *_instace = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        _instace = [[self alloc] init];
    });
    return _instace;
}

- (instancetype)init {
    if(self = [super init])  {
        reConnectTime = 0;
        
    }
    return self;
}


//建立长连接
- (void)connectServerWithApi:(NSString *)urlString {
    
    if (!urlString) return;
    
    self.urlString = urlString;
    
    //    if(self.webSocket.readyState == SR_OPEN) return;
    
    //SRWebSocketUrlString 就是websocket的地址 写入自己后台的地址
    self.webSocket = [[SRWebSocket alloc] initWithURL:[NSURL URLWithString:urlString]];
    
    self.webSocket.delegate = self;   //SRWebSocketDelegate 协议
    
    [self SocketOpen];//开始连接
}


- (void)SocketOpen {
    
    if(self.webSocket.readyState == SR_OPEN) return;
    
    [self.webSocket open];//开始连接
}



#pragma mark - NSTimer -
//初始化心跳
- (void)initHeartBeat  {
    //心跳没有被关闭
    if(self.heartBeatTimer)  {
        return;
    }
    
    [self destoryHeartBeat];
    
    WS(weakSelf);
    dispatch_main_async_safe(^{
        weakSelf.heartBeatTimer  = [NSTimer timerWithTimeInterval:10  target:weakSelf selector:@selector(senderheartBeat) userInfo:nil repeats:true];
        [[NSRunLoop currentRunLoop]addTimer:self.heartBeatTimer forMode:NSRunLoopCommonModes];
    });
}



#pragma mark - private -- webSocket相关方法

//发送心跳
- (void)senderheartBeat {
    
    //    NSDictionary *sendDic = @{
    //                              @"event":@"UPLOAD_POSITION"
    //                              };
    //    //将dic 转换为json
    //    NSString *jsonStr = [JGCommonTools convertToJsonData:sendDic];
    JGLog(@"===========保活操作 =============");
    
    //    [self sendData:jsonStr];
}


//发送数据
- (void)sendData:(id)data {
    
    
    WS(weakSelf);
    dispatch_main_async_safe((^{
        
        if(self.webSocket.readyState == SR_OPEN) {
            
            JGLog(@"socketSendData ------- %@",data);
            
            //            [QJCustomHUD showSuccess:@"开始发送坐标数据👌"];
            
            [weakSelf.webSocket send:data];    // 发送数据
        }else if (weakSelf.webSocket.readyState == SR_CONNECTING) {
            JGLog(@"正在连接中，重连后其他方法会去自动同步数据");
            // 每隔2秒检测一次 socket.readyState 状态，检测 10 次左右
            // 只要有一次状态是 SR_OPEN 的就调用 [ws.socket send:data] 发送数据
            // 如果 10 次都还是没连上的，那这个发送请求就丢失了，这种情况是服务器的问题了，小概率的
            // 代码有点长，我就写个逻辑在这里好了
            
        } else if (weakSelf.webSocket.readyState == SR_CLOSING || weakSelf.webSocket.readyState == SR_CLOSED) {
            // websocket 断开了，调用 reConnect 方法重连
            
            [weakSelf reConnectServer];
        }
    }));
}


//取消心跳
- (void)destoryHeartBeat
{
    WS(weakSelf);
    dispatch_main_async_safe(^{
        if(weakSelf.heartBeatTimer)
        {
            [weakSelf.heartBeatTimer invalidate];
            weakSelf.heartBeatTimer = nil;
        }
    });
}


//重新连接服务器
- (void)reConnectServer {
    
    if(self.webSocket.readyState == SR_OPEN) return;
    
    //    JGLog(@"重连...");
    
    // 重连10次 2^10 = 1024
    if (reConnectTime > 1024) {
        //您的网络状况不是很好，请检查网络后重试
        reConnectTime = 0;
        
        [JGToast showWithText:@"Your network status is not very good, please check the network and try again"];
    }
    
    
    WS(weakSelf);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(reConnectTime *NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        if(weakSelf.webSocket.readyState == SR_OPEN && weakSelf.webSocket.readyState == SR_CONNECTING)
        {
            return;
        }
        
        //        JGLog(@"正在重连...");
        [self connectServerWithApi:self.urlString];
        
        //重连时间2的指数级增长
        if(reConnectTime == 0)  {
            reConnectTime = 2;
        } else  {
            reConnectTime *= 2;
        }
    });
    
}


//关闭连接
- (void)SRWebSocketClose {
    
    if (self.webSocket){
        [self.webSocket close];
        self.webSocket = nil;
        //关闭心跳定时器
        [self destoryHeartBeat];
    }
}


#pragma mark - SRWebSocketDelegate -- webSockect代理
//连接成功回调
- (void)webSocketDidOpen:(SRWebSocket *)webSocket {
    JGLog(@"webSocket ===  连接成功");
    //    [QJCustomHUD showError:@"连接成功😀"];
    
    reConnectTime = 0;
    [self initHeartBeat]; //开启心跳
}

//连接失败回调
- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error {
    [self destoryHeartBeat]; //断开连接时销毁心跳
    
    //    JGLog(@"连接失败，这里可以实现掉线自动重连，要注意以下几点");
    //    JGLog(@"1.判断当前网络环境，如果断网了就不要连了，等待网络到来，在发起重连");
    //    JGLog(@"3.连接次数限制，如果连接失败了，重试10次左右就可以了");
    
    JGLog(@"%@",error);
    //    [QJCustomHUD showError:@"连接失败了😭"];
    //
    //
    //    if (error.code == 504) {
    //        [QJCustomHUD showError:@"😭连接超时😭"];
    //    }
    
    //连接失败就重连
    [self reConnectServer];
}

//连接关闭,注意连接关闭不是连接断开，关闭是 [socket close] 客户端主动关闭，断开可能是断网了，被动断开的。
- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean {
    // 在这里判断 webSocket 的状态 是否为 open , 大家估计会有些奇怪 ，因为我们的服务器都在海外，会有些时间差，经过测试，我们在进行某次连接的时候，上次重连的回调刚好回来，而本次重连又成功了，就会误以为，本次没有重连成功，而再次进行重连，就会出现问题，所以在这里做了一下判断
    if(self.webSocket.readyState == SR_OPEN) return;
    
    JGLog(@"被关闭连接，code:%ld,reason:%@,wasClean:%d",(long)code,reason,wasClean);
    
    //断开连接 同时销毁心跳
    [self SRWebSocketClose];
}

/*
 该函数是接收服务器发送的pong消息，其中最后一个是接受pong消息的，
 在这里就要提一下心跳包，一般情况下建立长连接都会建立一个心跳包，
 用于每隔一段时间通知一次服务端，客户端还是在线，这个心跳包其实就是一个ping消息，
 我的理解就是建立一个定时器，每隔十秒或者十五秒向服务端发送一个ping消息，这个消息可是是空的
 */
-(void)webSocket:(SRWebSocket *)webSocket didReceivePong:(NSData*)pongPayload {
    NSString* reply = [[NSString alloc] initWithData:pongPayload encoding:NSUTF8StringEncoding];
    JGLog(@"reply === 收到后台心跳回复 Data:%@",reply);
}

//收到服务器发过来的数据 这里的数据可以和后台约定一个格式
//我约定的就是一个字符串 收到以后发送通知到外层 根据类型 实现不同的操作
- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message {
    //    NSMutableDictionary *dataDic = [NSMutableDictionary dictionaryWithJsonString:message];
    
    JGLog(@"reply === 收到服务器发来的数据 Data:%@",message);
    
    /*根据具体的业务做具体的处理*/
}




@end
