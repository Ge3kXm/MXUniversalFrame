//
//  MXTestVC1.m
//  MXBase
//
//  Created by maRk on 2017/9/25.
//  Copyright © 2017年 maRk. All rights reserved.
//

#import "MXTestVC1.h"

@interface MXTestVC1 ()

@end

@implementation MXTestVC1

- (void)viewDidLoad {
    [super viewDidLoad];

    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(100, 300, 100, 100)];
    scrollView.contentSize = CGSizeMake(1000, 100);
    scrollView.backgroundColor = [UIColor redColor];
    [self.view addSubview:scrollView];
    // Do any additional setup after loading the view.
}

- (MXNavigationBarConfig *)navigationBarConfig
{
    return [MXNavigationBarConfig whiteBaseConfig];
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
