//
//  Theme.h
//  01_微博
//
//  Created by 孙洪峰 on 16/6/13.
//  Copyright © 2016年 孙洪峰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface Theme : NSObject
//主题属性
@property (nonatomic,copy)NSString *themeName;

//定义全局字典接收plist文件内容
@property (nonatomic,strong)NSDictionary *colorDic;

//单里创建
+(id)shartTheme;

//通过传图片名字进行替换
- (UIImage *)getThemeImgWithName:(NSString *)imgName;


//通过颜色名进行替换
- (UIColor *)getThemeColorWithName:(NSString *)colorNmae;
@end
