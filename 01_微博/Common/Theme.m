//
//  Theme.m
//  01_微博
//
//  Created by 孙洪峰 on 16/6/13.
//  Copyright © 2016年 孙洪峰. All rights reserved.
//

#import "Theme.h"

@implementation Theme

//初始为空
static Theme *inscone = nil;



//单例方法
+(id)shartTheme{

   
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        inscone = [[Theme alloc]init];
    });
    
    //返回单例对象
    return inscone;
}

//复写init方法-->设定初始主题
- (instancetype)init{
    self = [super init];
    if(self){
        
        //判断主题是否为空,空选择默认,不为空用之前的
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        NSString *name =  [defaults objectForKey:@"name"];
        
        
        
        
        _themeName = name ?name:@"黑暗之女";
    }
    return self;
}

- (void)setThemeName:(NSString *)themeName{
    _themeName =themeName;
    [self loadPath];
    
    [self loadColorPath];
    
    //保存主题
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:_themeName forKey:@"name"];
    
    //快捷存储
    [defaults synchronize];

    //发通知
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"themeChange" object:self userInfo:nil];
    

    
}
//获取bould图片路径
- (NSString *)loadPath{
    //1.plist文件获取
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"Theme.plist" ofType:nil];
    
    //2.解析plist文件
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:filePath];
    
    //3.通过中文Key获取局部路径
    NSString *juBuPath = dic[_themeName];
    
//4.获取总路径进行拼接  头路径+Skins/cat(局部)
    //总路径
    NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:juBuPath];
    //返回路径
    return path;

}
#pragma mark - 此方法为传递图片名进行对应主题图片返回
- (UIImage *)getThemeImgWithName:(NSString *)imgName{
    //1.获取总路径
    NSString *path = [self loadPath];
    
    //2.将传递的名字拼接  获取最下级的路径
    NSString *imgPath = [path stringByAppendingPathComponent:imgName];
    
    //3.通过路径获取图片
    UIImage *img = [UIImage imageWithContentsOfFile:imgPath];
    
    return img;
}
#pragma mark - 文字颜色惊醒的主题切换

- (void)loadColorPath{
    //1.获取文件路径
    NSString *path = [self loadPath];
    //2.拼接路径
    NSString *colorPath =[path stringByAppendingPathComponent:@"config.plist"];
    //3.获取plist中的字典
    _colorDic = [NSDictionary dictionaryWithContentsOfFile:colorPath];
}
//通过传递文字颜色进行主题切换
- (UIColor *)getThemeColorWithName:(NSString *)colorNmae{
    
    //1.把传递过来的参数最为key取Value
    NSDictionary *dic = _colorDic[colorNmae];
    
    //2.取出字典中RGB值  解包
    double R = [dic[@"R"] doubleValue];
    double G = [dic[@"G"] doubleValue];
    double B = [dic[@"B"] doubleValue];
    //运用三目运算符进行判断  有值赋值  没值给1
    double alpha = [dic[@"alpha"]  doubleValue]?:1;
    
    //3.给定一个UIColor 并进行返回
    UIColor *color = [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:alpha];
    
    return color;
}
@end
