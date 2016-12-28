//
//  WebViewController.m
//  SearchGithubReposDemo
//
//  Created by 牟华 on 16/12/27.
//  Copyright © 2016年 牟华. All rights reserved.
//

#import "WebViewController.h"

@interface UIView (DBExtention)

@property (nonatomic, assign) CGFloat db_x;
@property (nonatomic, assign) CGFloat db_y;
@property (nonatomic, assign) CGFloat db_width;
@property (nonatomic, assign) CGFloat db_height;

@end

@interface WebViewController () <UIWebViewDelegate>

@property (weak, nonatomic) UIWebView *webView;

@property (strong, nonatomic) UIView *lineView;

@end

@implementation WebViewController

- (UIView *)lineView
{
    if (!_lineView) {
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, 40, 5)];
        _lineView.backgroundColor = [UIColor orangeColor];
        [self.view addSubview:_lineView];
    }
    return _lineView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIWebView *webView = [[UIWebView alloc] init];
    webView.delegate = self;
    [self.view addSubview:webView];
    self.webView = webView;
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.webView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    if (self.loadUrlStr) {
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:self.loadUrlStr] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:20];
        [self.webView loadRequest:request];
    }
    if (self.loadStr) {
        NSString *htmlStr = [NSString stringWithFormat:@"<head>\
                             <meta charset=\"UTF-8\">\
                             <title>错误网页</title>\
                             <style>\
                             body{\
                             text-align: center;\
                             }\
                             p {\
                             margin-top: 20px;\
                             text-align: center;\
                             font-family: \"Hiragino Mincho ProN\";\
                             font-size: 15px;\
                             font-weight: bold;\
                             }\
                             </style>\
                             </head>\
                             <body>\
                             <p>%@</p>\
                             </body>", self.loadStr];
        [self.webView loadHTMLString:htmlStr baseURL:nil];
    }
}

/**
 *  WebView代理方法
 */
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    __weak typeof(self) weakSelf = self;
    self.lineView.alpha = 1.0;
    weakSelf.lineView.db_width = 40;
    [UIView animateWithDuration:1.0 animations:^{
        weakSelf.lineView.db_width = weakSelf.view.db_width - 50;
    }];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.4 animations:^{
        weakSelf.lineView.db_width = weakSelf.view.db_width;
    } completion:^(BOOL finished) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [UIView animateWithDuration:0.1 animations:^{
                    weakSelf.lineView.alpha = 0.0;
                }];
                
            });
        });
    }];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error
{
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.4 animations:^{
        weakSelf.lineView.db_width = weakSelf.view.db_width;
    } completion:^(BOOL finished) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.1 animations:^{
                weakSelf.lineView.alpha = 0.0;
            }];
            
        });
    }];
    
}

@end
