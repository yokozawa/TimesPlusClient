//
//  TPCViewController.m
//  TimesPlusClient
//
//  Created by yoko_net on 2014/03/02.
//  Copyright (c) 2014年 yoko_net. All rights reserved.
//

#import "TPCViewController.h"
#import "Defaults.h"
#import "UIColor+ColorWithHex.h"

#import "InvalidTooltipView.h"
#import "TooltipView.h"
#import "ValidatorRules.h"

#define kLoginUrl @"https://api.timesclub.jp/view/pc/tpLogin.jsp"
#define kRedirectPath @"https://plus.timescar.jp/view/sp/member/mypage.jsp"
#define kSiteKbn @"TP"
#define kDoa @"ON"

@interface TPCViewController ()

#define kUIBarButtonSystemItemBack 101
#define kUIBarButtonSystemItemForward 102

@property TooltipView *toolTipView;
@property UIWebView *webView;
@property UIBarButtonItem *barBtnBack;
@property UIBarButtonItem *barBtnForward;
@property UIBarButtonItem *barBtnReload;

@end

@implementation TPCViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    _tfCard1.delegate = self;
    _tfCard1.delegate = self;
    _tfPassword.delegate = self;
    
    if ([Defaults getCardNo1] != nil) {
        _tfCard1.text = [Defaults getCardNo1];
        _tfCard2.text = [Defaults getCardNo2];
        _tfPassword.text = [Defaults getPassword];
    }
    
    [_btnGo bk_addEventHandler:^(id sender) {
        [_tfPassword resignFirstResponder];
        [self doValidation];
    } forControlEvents:UIControlEventTouchUpInside];

    [_btnReset bk_addEventHandler:^(id sender) {
        [Defaults setCardNo1:nil];
        [Defaults setCardNo2:nil];
        [Defaults setPassword:nil];
        _tfCard1.text = @"";
        _tfCard2.text = @"";
        _tfPassword.text = @"";
    } forControlEvents:UIControlEventTouchUpInside];
    
    self.title = @"ログイン";
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexString:@"FCD100" alpha:1.0f];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] bk_initWithTitle:@"ログインに戻る" style:UIBarButtonSystemItemDone handler:^(id sender) {
        for (UIView *view in [self.view subviews]) {
            if([view isKindOfClass:[UIWebView class]]) {
                [view removeFromSuperview];
            }
        }
        _toolBar.hidden = YES;

    }];
    [self doSetToolBar];
    _toolBar.hidden = YES;
}

- (void)doValidation
{
    if (_toolTipView != nil)
    {
        [_toolTipView removeFromSuperview];
        _toolTipView = nil;
    }
    
    Validator *validator = [[Validator alloc] init];
    validator.delegate   = self;
    
    [validator putRule:[Rules minLength:4 withFailureString:NSLocalizedString(@"validateRequire", @"") forTextField:_tfCard1]];

    [validator putRule:[Rules minLength:6 withFailureString:NSLocalizedString(@"validateRequire", @"") forTextField:_tfCard2]];
    
    [validator putRule:[Rules minLength:1 withFailureString:NSLocalizedString(@"validateRequire", @"") forTextField:_tfPassword]];
    
    [validator validate];
}

- (void)doConnection
{
    CGRect frame = self.navigationController.view.frame;
    frame.size.height = (self.view.frame.size.height - _toolBar.frame.size.height);
    _webView = [[UIWebView alloc] initWithFrame:frame];
    _webView.delegate = self;
    NSString *strUrl = [NSString stringWithFormat:@"%@?siteKbn=%@&doa=%@&redirectPath=%@", kLoginUrl, kSiteKbn, kDoa, kRedirectPath];
    NSURL *url = [NSURL URLWithString:strUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [_webView loadRequest:request];
    
    _toolBar.hidden = NO;
    
    [self.view addSubview:_webView];
}

- (void)doSetToolBar
{
    _barBtnBack = [[UIBarButtonItem alloc] bk_initWithBarButtonSystemItem:kUIBarButtonSystemItemBack handler:^(id sender){
        [_webView goBack];
    }];
    
    _barBtnForward = [[UIBarButtonItem alloc] bk_initWithBarButtonSystemItem:kUIBarButtonSystemItemForward handler:^(id sender) {
        [_webView goForward];
    }];
    
    _barBtnReload = [[UIBarButtonItem alloc] bk_initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh handler:^(id sender) {
        [_webView reload];
    }];
    
    UIBarButtonItem *flexibleSpaceItem = [[UIBarButtonItem alloc]
                                          initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                          target:nil
                                          action:nil];
    
    _toolBar.items = @[_barBtnBack, flexibleSpaceItem, _barBtnReload, flexibleSpaceItem, _barBtnForward];
}

#pragma ValidatorDelegate - Delegate methods

- (void)preValidation
{
    for (UIView *view in [self.view subviews]) {
        if([view isKindOfClass:[UITextField class]]) {
            view.layer.borderWidth = 0;
        }
    }
}

- (void)onSuccess
{
    if (_toolTipView != nil)
    {
        [_toolTipView removeFromSuperview];
        _toolTipView  = nil;
    }

    [Defaults setCardNo1:_tfCard1.text];
    [Defaults setCardNo2:_tfCard2.text];
    [Defaults setPassword:_tfPassword.text];
    
    [self doConnection];
}

- (void)onFailure:(Rule *)failedRule
{
    failedRule.textField.layer.borderColor   = [[UIColor redColor] CGColor];
    failedRule.textField.layer.cornerRadius  = 5;
    failedRule.textField.layer.borderWidth   = 2;
    
    CGPoint point = [failedRule.textField convertPoint:CGPointMake(0.0, failedRule.textField.frame.size.height - 4.0) toView:self.view];
    CGRect tooltipViewFrame = CGRectMake(6.0, point.y, 309.0, _toolTipView.frame.size.height);
    
    _toolTipView       = [[InvalidTooltipView alloc] init];
    _toolTipView.frame = tooltipViewFrame;
    _toolTipView.text  = [NSString stringWithFormat:@"%@",failedRule.failureMessage];
    _toolTipView.rule  = failedRule;
    [self.view addSubview:_toolTipView];
}

#pragma UIWebViewDelegate - Delegate methods

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSString *cardNo1 = [NSString stringWithFormat:@"document.getElementById('cardNo1').value='%@'", [Defaults getCardNo1]];
    [webView stringByEvaluatingJavaScriptFromString:cardNo1];

    NSString *cardNo2 = [NSString stringWithFormat:@"document.getElementById('cardNo2').value='%@'", [Defaults getCardNo2]];
    [webView stringByEvaluatingJavaScriptFromString:cardNo2];
    
    NSString *password = [NSString stringWithFormat:@"document.getElementById('tpPassword').value='%@'", [Defaults getPassword]];
    [webView stringByEvaluatingJavaScriptFromString:password];
    
    NSString *post = @"document.getElementById('doLoginForTp').click()";
    [webView stringByEvaluatingJavaScriptFromString:post];
    
    _barBtnBack.enabled = [webView canGoBack];
    _barBtnForward.enabled = [webView canGoForward];
    
    NSString *title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    self.title = title;
}

@end
