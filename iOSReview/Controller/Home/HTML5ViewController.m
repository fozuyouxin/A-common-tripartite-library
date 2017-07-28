//
//  HTML5ViewController.m
//  iOSReview
//
//  Created by Apple on 2017/7/28.
//  Copyright © 2017年 KennyHito. All rights reserved.
//

#import "HTML5ViewController.h"
#import <JavaScriptCore/JSContext.h>

@interface HTML5ViewController ()<UIWebViewDelegate>

@property (strong, nonatomic) UIWebView * webView;

@end

@implementation HTML5ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, HitoScreenW, HitoScreenH)];
    self.webView.delegate = self;
    [self.view addSubview:self.webView];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"html"];
    NSURL *url = [NSURL fileURLWithPath:path];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    JSContext *content = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    content[@"niu"] = ^{
        
        UIAlertController *alertCtl = [UIAlertController alertControllerWithTitle:@"交互" message:@"跳转成功" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alertCtl addAction:action];
        [self presentViewController:alertCtl animated:YES completion:nil];
        
    };
    
}



@end
