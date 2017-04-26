//
//  VtcWebViewController.m
//  Baisibudejie
//
//  Created by Vincent Rowe on 2017/3/5.
//  Copyright © 2017年 Vincent. All rights reserved.
//

#import "VtcWebViewController.h"
#import <WebKit/WebKit.h>

@interface VtcWebViewController ()
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (nonatomic, weak) WKWebView *webView;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *backItem;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *forwardItem;

@property (weak, nonatomic) IBOutlet UIProgressView *progressView;

@end

@implementation VtcWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加webView
    WKWebView *webView = [[WKWebView alloc] init];
    
    _webView = webView;
    
    [self.contentView addSubview:webView];
    
    // 展示数据
    NSURLRequest *request = [NSURLRequest requestWithURL:_url];
    
    [webView loadRequest:request];
    
    // KVO监听属性改变
    /**
     addObserver

     @param NSObject 观察者
     @param NSString(forKeyPath) 观察webView哪个属性
     @param options 观察新值得改变
     
     KVO注意点：一定要记得移除
     */
    [webView addObserver:self forKeyPath:@"canGoBack" options:NSKeyValueObservingOptionNew context:nil];
    [webView addObserver:self forKeyPath:@"canGoForward" options:NSKeyValueObservingOptionNew context:nil];
    
    [webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    
    [webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
}
#pragma mark - 只要观察者属性有新值就会调用
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {

    self.backItem.enabled = self.webView.canGoBack;
    self.forwardItem.enabled = self.webView.canGoForward;
    
    self.title = self.webView.title;
    
    self.progressView.progress = self.webView.estimatedProgress;
    self.progressView.hidden = self.webView.estimatedProgress >= 1;
}

#pragma mark - 销毁观察者（KVO）
- (void)dealloc {

    [self.webView removeObserver:self forKeyPath:@"canGoBack"];
    [self.webView removeObserver:self forKeyPath:@"canGoForward"];
    
    [self.webView removeObserver:self forKeyPath:@"title"];
    
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
    
}

#pragma mark - 设置尺寸
- (void)viewDidLayoutSubviews {

    [super viewDidLayoutSubviews];
    
    _webView.frame = self.contentView.bounds;
}


#pragma mark - 前进按钮
- (IBAction)goBack:(id)sender {
    
    [self.webView goBack];
}


#pragma mark - 后退按钮
- (IBAction)goForward:(id)sender {
    
    [self.webView goForward];
}


#pragma mark - 刷新按钮
- (IBAction)reload:(id)sender {
    
    [self.webView reload];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
