//
//  BaseTabViewController.m
//  01_微博
//
//  Created by 孙洪峰 on 16/6/12.
//  Copyright © 2016年 孙洪峰. All rights reserved.
//

#import "BaseTabViewController.h"
#import "ThemeBtn.h"
#import "ThemeImageView.h"
#import "Header.h"
@interface BaseTabViewController ()
@property (nonatomic,strong)ThemeImageView *selectImg;
@end

@implementation BaseTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //1.添加子控制器
    [self createStoryboard];
    
    //2.自定义创建标签栏
    [self createTab];
}
//视图将要显示--移除标签栏
- (void)viewWillAppear:(BOOL)animated{
     [super viewWillAppear:animated];
    
    [self removeTab];
}


//加载子Storyboard控制器
- (void)createStoryboard{

    //1.获取Storyboard
    UIStoryboard *discoverS = [UIStoryboard storyboardWithName:@"Discover" bundle:nil];
    
    UIStoryboard *homeS = [UIStoryboard storyboardWithName:@"Home" bundle:nil];
    
    UIStoryboard *messageS = [UIStoryboard storyboardWithName:@"Message" bundle:nil];
    
    UIStoryboard *moreS = [UIStoryboard storyboardWithName:@"More" bundle:nil];
    
    UIStoryboard *profileS = [UIStoryboard storyboardWithName:@"Profile" bundle:nil];
    //2.获取Storyboard上的控制器

    //3.创建数组存装子控制器
    
    NSArray *array = @[    [discoverS instantiateInitialViewController],
                           [homeS instantiateInitialViewController],
                           [messageS instantiateInitialViewController],
                           [moreS instantiateInitialViewController],
                           [profileS instantiateInitialViewController]];
    
    //
    self.viewControllers = array;
}

//设置移除标签栏
- (void)removeTab{

    for (UIView *view in self.tabBar.subviews) {
//        NSLog(@"%@",self.tabBar.subviews);
        
        if([view isKindOfClass:NSClassFromString(@"UITabBarButton")]){
            [view removeFromSuperview];
        }
        
    }
    

}


//自定义创建标签栏
- (void)createTab{

    //1.设置背景图片
    ThemeImageView *tabBackgroundImage = [[ThemeImageView alloc]initWithFrame:CGRectMake(0, -6, kScreenWeight, 55)];
    
//    tabBackgroundImage.image = [UIImage imageNamed:@"mask_navbar@2x.png"];

    tabBackgroundImage.imageViewName = @"mask_navbar@2x.png";
    //开启用户交互

    tabBackgroundImage.userInteractionEnabled = YES;
    //添加
    [self.tabBar addSubview:tabBackgroundImage];
    
    //2.添加按钮
    
    CGFloat weight = kScreenWeight / 5;
    //图片数组
    NSArray *imgNameArr = @[@"home_tab_icon_1.png",
                            @"home_tab_icon_2.png",
                            @"home_tab_icon_3.png",
                            @"home_tab_icon_4.png",
                            @"home_tab_icon_5.png"];
    
    //创建按钮
    for (int i = 0; i < imgNameArr.count; i ++) {
        ThemeBtn *btn = [ThemeBtn buttonWithType:UIButtonTypeCustom];
        
//        [btn setImage:[UIImage imageNamed:imgNameArr[i]] forState:UIControlStateNormal];
        btn.themeImg = imgNameArr[i];
        btn.frame = CGRectMake(i * weight, 2, weight, 45);
        
        btn.tag = 1000 +i;
        
        [self.tabBar addSubview:btn];
        
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    //3.创建选择图片
    _selectImg = [[ThemeImageView alloc]init];
    
    _selectImg.imageViewName = @"home_bottom_tab_arrow.png";
    
    _selectImg.frame = CGRectMake(0, 4, weight, 45);
    
    [self.tabBar addSubview:_selectImg];
}

#pragma mark - 按钮店家方法
- (void)btnAction:(UIButton *)btn{
    self.selectedIndex = btn.tag - 1000;
    
    [UIView animateWithDuration:.35 animations:^{
        _selectImg.center = btn.center;
    }];
    
}
@end
