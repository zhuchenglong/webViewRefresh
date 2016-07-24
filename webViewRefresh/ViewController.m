//
//  ViewController.m
//  webViewRefresh
//
//  Created by CrabMan on 16/5/25.
//  Copyright © 2016年 CrabMan. All rights reserved.
//

#import "ViewController.h"
#import "MJRefresh.h"
@interface ViewController ()<UIWebViewDelegate>

@property (nonatomic,strong) UIWebView *webView;

@property (nonatomic,strong) NSURL *url;
@end

@implementation ViewController
-(UIWebView *)webView {

    if (!_webView) {
        _webView = [[UIWebView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _webView.delegate = self;
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://news.163.com"]]];
        // 添加下拉刷新控件
        _webView.scrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            // 进入刷新状态后会自动调用这个block
        [_webView loadRequest:[NSURLRequest requestWithURL:self.url]];
        }];
    }
    return _webView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
  
    [self.view addSubview:self.webView];
}


#pragma --- UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView {
    
    NSLog(@"---- 执行加载----");

}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{

    //页面是否被点击
    if (navigationType == UIWebViewNavigationTypeLinkClicked)
    {
        self.url = request.URL;
        return NO;
    }else{
    
        return YES;
    }
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {

    [_webView.scrollView.mj_header endRefreshing];
    
     self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [_webView.scrollView.mj_header endRefreshing];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
