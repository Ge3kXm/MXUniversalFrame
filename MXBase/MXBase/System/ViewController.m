//
//  ViewController.m
//  MXBase
//
//  Created by maRk on 2017/9/21.
//  Copyright © 2017年 maRk. All rights reserved.
//

#import "ViewController.h"
#import "MXTestVC1.h"

@import MXBaseUtils;

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"%@",@__FILE__);
    MXTuple *tuple = MXTupleCreate(@"1", @"#", @"3");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    MXTestVC1 *bvc = [[MXTestVC1 alloc] init];
//    [bvc setDefaultNetErrorPageShowing:YES];
    [self.navigationController pushViewController:bvc animated:YES];
}
@end
