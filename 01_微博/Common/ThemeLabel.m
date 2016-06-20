//
//  ThemeLabel.m
//  01_微博
//
//  Created by 孙洪峰 on 16/6/14.
//  Copyright © 2016年 孙洪峰. All rights reserved.
//

#import "ThemeLabel.h"

@implementation ThemeLabel

-(void)setColorName:(NSString *)colorName{
    _colorName = colorName;
    
    [self loadColor];
    
}

//定义一个方法进行获取颜色
- (void)loadColor{
    Theme *manager = [Theme shartTheme];
    
    self.textColor = [manager getThemeColorWithName:_colorName];
}

//创建时接收通知,主题改变时接收  并改变颜色
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
    
        //接收通知 重新调用loadColor方法--给定颜色
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadColor) name:@"themeChange" object:nil];
    }
    return self;
}

//移除通知

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"themeChange" object:nil];
}

@end
