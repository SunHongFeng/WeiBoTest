//
//  ThemeImageView.m
//  01_微博
//
//  Created by 孙洪峰 on 16/6/13.
//  Copyright © 2016年 孙洪峰. All rights reserved.
//

#import "ThemeImageView.h"

@implementation ThemeImageView

-(void)setImageViewName:(NSString *)imageViewName{
    _imageViewName = imageViewName;
    [self loadImg];
    
}
-(void)loadImg{
    Theme *themeManage = [Theme shartTheme];
    
    UIImage *img = [themeManage getThemeImgWithName:_imageViewName];
   
    //调用原有的set方法
    self.image = img;
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
