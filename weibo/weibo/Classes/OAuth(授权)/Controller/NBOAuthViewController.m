//
//  NBOAuthViewController.m
//  weibo
//
//  Created by yoga on 15/8/27.
//  Copyright (c) 2015年 ioslearning. All rights reserved.
//

#import "NBOAuthViewController.h"
#import "MBProgressHUD+MJ.h"
#import "NBTabBarController.h"
#import "NBNewfeatureViewController.h"
#import "NBControllerTool.h"
#import "NBAccountTool.h"
#import "NBAccount.h"
#import "NBAccessTokenParam.h"

@interface NBOAuthViewController () <UIWebViewDelegate>

@end

@implementation NBOAuthViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 创建UIWebView
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = self.view.bounds;
    [self.view addSubview:webView];
    
    // 加载登录页面
//    NSString *client_id = @"655430234";
//    NSString *redirect_uri = @"http://www.cnblogs.com/chenjianjun/";
//    NSString *urlStr = @"https://api.weibo.com/oauth2/authorize?client_id=655430234&redirect_uri=http://www.cnblogs.com/chenjianjun/";
    NSString *urlStr = [NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@", NBAppKey, NBRedirectURI];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    
    // 设置代理
    webView.delegate = self;
}

#pragma mark - UIWebViewDelegate
/**
 *  UIWebView每当发送一个请求之前，都会先调用这个代理方法（询问代理允不允许加载这个请求）
 *
 *  @param request        即将发送的请求
 
 *  @return YES : 允许加载， NO : 禁止加载
 */
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    // 1.获得请求地址
    NSString *url = request.URL.absoluteString;
//    NSString *url = [request.URL absoluteString];
//    NBLog(@"%@", url);
    
//    NSRange range = [url rangeOfString:@"http://www.cnblogs.com/chenjianjun/"];
//    NSString *urlStr = [url substringFromIndex:range.location];
//    if (urlStr) {
//        return NO;
 
//    }
    
    // 2.判断url是否为回调地址
    /**
     url = http://www.itheima.com/?code=a3db74011c311e629bafce3e50c25339
     range.location == 0
     range.length > 0
     */
    /**
     url =  https://api.weibo.com/oauth2/authorize
     range.location == NSNotFound
     range.length == 0
     */
    NSRange range = [url rangeOfString:[NSString stringWithFormat:@"%@?code=", NBRedirectURI]];
    if (range.location != NSNotFound) { // 是回调地址
        //    if (range.length != 0)
        
        // 截取授权成功后的请求标记
//        NBLog(@"%d - -- - %d", range.location, range.length);
        int from = (int)range.location + (int)range.length;
        NSString *code = [url substringFromIndex:from];
        
        // 根据code获得一个accessToken
        [self accessTokenWithCode:code];
        
        // 禁止加载回调页面
        return NO;
    }
    
    return YES;
}

/**
 *  根据code获得一个accessToken
 *
 *  @param code 授权成功后的请求标记
 */
- (void)accessTokenWithCode:(NSString *)code
{
    // 1.封装请求参数
    NBAccessTokenParam *param = [[NBAccessTokenParam alloc] init];
    param.client_id = NBAppKey;
    param.client_secret = NBAppSecret;
    param.redirect_uri = NBRedirectURI;
    param.grant_type = @"authorization_code";
    param.code = code;
    
    // 2.获得accessToken
    [NBAccountTool accessTokenWithParam:param success:^(NBAccount *account) {
        NBLog(@"请求成功");
        // 隐藏HUD
        [MBProgressHUD hideHUD];
        
        // 存储帐号模型
        [NBAccountTool save:account];
        
        // 切换控制器(可能去新特性\tabbar)
        [NBControllerTool chooseRootViewController];
    } failure:^(NSError *error) {
        // 隐藏HUD
        [MBProgressHUD hideHUD];
        
        NBLog(@"accessTokenWithCode请求失败--%@", error);
    }];

}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [MBProgressHUD showMessage:@"正在加载网页"];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUD];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
//    [MBProgressHUD showError:@"请检查手机网络"];
    [MBProgressHUD hideHUD];
}

@end
