//
//  JZJWebViewController.m
//  JZJTraveller
//
//  Created by tarena on 15/12/8.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import "JZJWebViewController.h"
#import "JZJBooks.h"
@interface JZJWebViewController ()<UIWebViewDelegate>
@property (nonatomic,strong) UIWebView* webView;
@end

@implementation JZJWebViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.webView=[[UIWebView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:self.webView];
    
    NSURL* URL=[NSURL URLWithString:self.book.bookUrl];
    NSURLRequest* request=[NSURLRequest requestWithURL:URL];
    [self.webView loadRequest:request];
    self.webView.delegate=self;
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [[UIApplication sharedApplication]setNetworkActivityIndicatorVisible:NO];
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [[UIApplication sharedApplication]setNetworkActivityIndicatorVisible:YES];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [[UIApplication sharedApplication]setNetworkActivityIndicatorVisible:NO];
    NSLog(@"loadingFailed:%@",error.userInfo);
}

-(void)viewWillDisappear:(BOOL)animated
{
    [[UIApplication sharedApplication]setNetworkActivityIndicatorVisible:NO];
}
@end
