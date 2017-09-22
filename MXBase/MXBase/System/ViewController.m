//
//  ViewController.m
//  MXBase
//
//  Created by maRk on 2017/9/21.
//  Copyright © 2017年 maRk. All rights reserved.
//

#import "ViewController.h"
#import "MXBaseViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    MXBaseViewController *bvc = [[MXBaseViewController alloc] init];
    [bvc setDefaultNetErrorPageShowing:YES];
    [self.navigationController pushViewController:bvc animated:YES];
}
@end
