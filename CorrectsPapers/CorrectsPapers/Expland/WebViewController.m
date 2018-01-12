//
//  WebViewController.m
//  News Of History
//
//  Created by apple on 2017/8/3.
//  Copyright © 2017年 付耀辉. All rights reserved.
//

#import "WebViewController.h"
//#import "SVProgressHUD.h"
#import "UIView+Common.h"
@interface WebViewController ()<UIWebViewDelegate,UIGestureRecognizerDelegate>
@end

@implementation WebViewController


- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self.view beginLoading];
    
    self.navigationItem.title = _theTitle;
    
    
    UIWebView *webView=[[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64)];
    
    webView.delegate=self;
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_webUrl]]];
    [self.view addSubview:webView];

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back_icon_default"] style:UIBarButtonItemStyleDone target:self action:@selector(backActionnn:)];
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    self.navigationController.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    
}

//    返回事件
-(void)backActionnn:(UIBarButtonItem *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    return YES;
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [self.view endLoading];
}


-(void)webViewDidStartLoad:(UIWebView *)webView{
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
