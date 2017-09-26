//
//  MXWebViewController.m
//  MXBase
//
//  Created by maRk on 2017/9/21.
//  Copyright © 2017年 maRk. All rights reserved.
//

#import "MXWebViewController.h"
#import <WebKit/WebKit.h>

@interface MXWebViewController ()

@property (nonatomic, strong) WKWebView *webView;

@end

@implementation MXWebViewController

- (instancetype)initWithURl:(NSString *)url {
    if (self = [super init]) {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews {
    _webView = [[WKWebView alloc] init];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
