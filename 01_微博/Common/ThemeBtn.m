//
//  ThemeBtn.m
//  01_微博
//
//  Created by 孙洪峰 on 16/6/13.
//  Copyright © 2016年 孙洪峰. All rights reserved.
//

#import "ThemeBtn.h"

@implementation ThemeBtn


-(void)setThemeImg:(NSString *)themeImg{
    _themeImg = themeImg;
    
    [self loadImg];
}

-(void)loadImg{
    Theme *themeManage = [Theme shartTheme];
    
    UIImage *img = [themeManage getThemeImgWithName:_themeImg];
    
    //调用原有的set方法
    [self setImage:img forState:UIControlStateNormal];
}


//复写alloc方法接收通知
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
    
        //接收通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadImg) name:@"themeChange" object:nil];
    }
    return self;
}

//取消通知
- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"themeChange" object:nil];
}
@end
