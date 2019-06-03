//
//  JGWKWebViewController.m
//  JGTool
//
//  Created by 郭军 on 2019/6/3.
//  Copyright © 2019 JG. All rights reserved.
//

#import "JGWKWebViewController.h"
#import <WebKit/WebKit.h>

@interface JGWKWebViewController () <WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler>

/** 网页加载控件 */
@property (nonatomic, strong) WKWebView *wkWebView;
/** 进度条 */
@property (nonatomic,weak) CALayer *progressLayer;
/** 关闭按钮 */
@property (nonatomic,retain) UIBarButtonItem *closeButtonitem;
/** 返回按钮 */
@property (nonatomic,retain) UIBarButtonItem *customBackBarItem;

@end

@implementation JGWKWebViewController

#pragma mark -- lazyLoad
- (WKWebView *)wkWebView
{
    if (_wkWebView==nil) {
        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
        config.selectionGranularity = WKSelectionGranularityDynamic;
        config.allowsInlineMediaPlayback = YES;
        WKPreferences *preferences = [WKPreferences new];
        //是否支持JavaScript
        preferences.javaScriptEnabled = YES;
        //不通过用户交互，是否可以打开窗口
        preferences.javaScriptCanOpenWindowsAutomatically = YES;
        config.preferences = preferences;
        
        /* 添加用户与js交互的方法
         name: 方法名（JS只能向原生传递一个参数，所以如果有多个参数需要传递，可以让JS传递对象或者JSON字符串即可。）
         */
        [config.userContentController addScriptMessageHandler:self name:@"HelloWorld"];
        
        // 原生调用js方法
        //[webview evaluateJavaScript:“JS语句” completionHandler:^(id _Nullable data, NSError * _Nullable error) {
        //    }];
        _wkWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHight) configuration:config];
        /* 加载服务器url的方法*/
        NSString *url = self.webViewUrl;
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
        [_wkWebView loadRequest:request];
        _wkWebView.navigationDelegate = self;
        _wkWebView.UIDelegate = self;
        // 允许手势返回上级页面
        _wkWebView.allowsBackForwardNavigationGestures = YES;
        [self.view addSubview:_wkWebView];
    }
    return _wkWebView;
}

- (UIView *)progressView
{
    if (_progressView == nil) {
        _progressView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,kDeviceWidth , 3)];
        _progressView.backgroundColor = [UIColor clearColor];
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, 0, 0, 3);
        layer.backgroundColor = [UIColor colorWithHexCode:self.webViewBarTintColor].CGColor;
        [_progressView.layer addSublayer:layer];
        self.progressLayer = layer;
    }
    return _progressView;
}

// 返回按钮
-(UIBarButtonItem*)customBackBarItem
{
    if (!_customBackBarItem) {
        UIImage *backItemImage = [[UIImage imageNamed:@"staff_list_return_arrow"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        UIImage *backItemHlImage = [[UIImage imageNamed:@"staff_list_return_arrow"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        
        UIButton* backButton = [[UIButton alloc] init];
        [backButton setTitle:@"返回" forState:UIControlStateNormal];
        [backButton setTitleColor:self.navigationController.navigationBar.tintColor forState:UIControlStateNormal];
        [backButton setTitleColor:[self.navigationController.navigationBar.tintColor colorWithAlphaComponent:0.5] forState:UIControlStateHighlighted];
        [backButton.titleLabel setFont:[UIFont systemFontOfSize:17]];
        [backButton setImage:backItemImage forState:UIControlStateNormal];
        [backButton setImage:backItemHlImage forState:UIControlStateHighlighted];
        [backButton sizeToFit];
        
        [backButton addTarget:self action:@selector(customBackItemClicked) forControlEvents:UIControlEventTouchUpInside];
        _customBackBarItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    }
    return _customBackBarItem;
}
#pragma mark -- 返回按钮点击调用
- (void)customBackItemClicked
{
    [self.wkWebView goBack];
}
#pragma mark -- 关闭
- (UIBarButtonItem *)closeButtonitem
{
    if (_closeButtonitem == nil)
    {
        _closeButtonitem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(closeItemClick:)];
    }
    return _closeButtonitem;
}
#pragma mark -- 关闭按钮点击调用
- (void)closeItemClick:(UIBarButtonItem *)closeButtonItem
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark -- lifeStyle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // KVO监听
    [self.wkWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    [self.wkWebView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];
    [self.view addSubview:self.progressView];
}
#pragma mark - KVO回馈
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    [self updataNavigationitems];
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        self.progressLayer.opacity = 1;
        if ([change[@"new"] floatValue] <[change[@"old"] floatValue]) {
            return;
        }
        self.progressLayer.frame = CGRectMake(0, 0, self.view.frame.size.width*[change[@"new"] floatValue], 3);
        if ([change[@"new"]floatValue] == 1.0) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.progressLayer.opacity = 0;
                self.progressLayer.frame = CGRectMake(0, 0, 0, 3);
            });
        }
    } else if ([keyPath isEqualToString:@"title"]){
        self.title = change[@"new"];
    }
}
#pragma mark - WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController
      didReceiveScriptMessage:(WKScriptMessage *)message
{
    if ([message.name isEqualToString:@"HelloWorld"]) {
        [self HelloWorld];
        JGLog(@"self.helloWorld === %@",message.body);
    }
}

- (void)HelloWorld
{
    
}
#pragma mark - WKNavigationDelegate
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    
}
#pragma  mark - updata nav items
- (void)updataNavigationitems
{
    if (self.wkWebView.canGoBack) {
        UIBarButtonItem *spaceButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        spaceButtonItem.width = -6.5;
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
        [self.navigationItem setLeftBarButtonItems:@[self.closeButtonitem] animated:NO];
        
        // 弃用customBackBarItem，使用原生backButtonItem
        [self.navigationItem setLeftBarButtonItems:@[spaceButtonItem,self.customBackBarItem,self.closeButtonitem] animated:NO];
    }else{
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        [self.navigationItem setLeftBarButtonItems:nil];
    }
}

- (void)dealloc
{
    [self.wkWebView removeObserver:self forKeyPath:@"estimatedProgress"];
    [self.wkWebView removeObserver:self forKeyPath:@"title"];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
