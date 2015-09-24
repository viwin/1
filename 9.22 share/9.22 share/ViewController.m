//
//  ViewController.m
//  9.22 share
//
//  Created by 张稳 on 15/9/22.
//  Copyright (c) 2015年 nlg. All rights reserved.
//

#import "ViewController.h"
#import "LockView.h"
@interface ViewController ()<LockViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置背景
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"Home_refresh_bg"]];
    LockView *lockView=[[LockView alloc]initWithFrame:CGRectMake(50, 200, 300, 300)];
    [self.view addSubview:lockView];
}
//设置状态栏样式
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
-(void)LockView:(LockView *)LockView didFinishedWithPath:(NSString *)path
{
    NSLog(@"手势解锁的输出序列：%@", path);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
