//
//  BaseNavViewController.m
//  01_微博
//
//  Created by 孙洪峰 on 16/6/12.
//  Copyright © 2016年 孙洪峰. All rights reserved.
//

#import "BaseNavViewController.h"
#import "Theme.h"
@interface BaseNavViewController ()

@end

@implementation BaseNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    Theme *manager = [Theme shartTheme];
    
    self.navigationBar.translucent = NO;
    //设置背景图片
    
//    [self.navigationBar setBackgroundImage:[manager getThemeImgWithName:@"mask_titlebar64@2x.png"] forBarMetrics:UIBarMetricsDefault];
//    
//    //设置标题属性
//    self.navigationBar.titleTextAttributes = @{
//                                               NSForegroundColorAttributeName:[UIColor  whiteColor],
//                                               NSFontAttributeName :[UIFont systemFontOfSize:17]
//                                               };
    [self changeImg];
    
    //接收通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeImg) name:@"themeChange" object:nil];
    
}
//设置状态栏高亮
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

//通知调用方法
- (void)changeImg{
    
    Theme *manager = [Theme shartTheme];
    
    [self.navigationBar setBackgroundImage:[manager getThemeImgWithName:@"mask_titlebar64@2x.png"] forBarMetrics:UIBarMetricsDefault];
    
    //设置标题属性
    self.navigationBar.titleTextAttributes = @{
                                               NSForegroundColorAttributeName:[UIColor  whiteColor],
                                               NSFontAttributeName :[UIFont systemFontOfSize:17]
                                               };
}

//销毁通知
- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"themeChange"  object:nil];
}
@end
