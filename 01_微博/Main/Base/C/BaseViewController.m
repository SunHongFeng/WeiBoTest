//
//  BaseViewController.m
//  01_微博
//
//  Created by 孙洪峰 on 16/6/12.
//  Copyright © 2016年 孙洪峰. All rights reserved.
//

#import "BaseViewController.h"
#import "Theme.h"
@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_home@2x.jpg"]];
    
    //接收通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(notification) name:@"themeChange" object:nil];
    
    
    [self notification];
}

//接收通知方法
- (void)notification{
    Theme *manager = [Theme shartTheme];
 
    self.view.backgroundColor = [UIColor colorWithPatternImage:[manager getThemeImgWithName:@"bg_home@2x.jpg"]];
    
}

//销毁通知
- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"themeChange"  object:nil];
}


@end
