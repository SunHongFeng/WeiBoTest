//
//  AppDelegate.m
//  01_微博
//
//  Created by 孙洪峰 on 16/6/12.
//  Copyright © 2016年 孙洪峰. All rights reserved.
//

#import "AppDelegate.h"
#import "BaseTabViewController.h"
#import "MMDrawerController.h"
#import "LeftViewController.h"
#import "RightViewController.h"
#import "MMExampleDrawerVisualStateManager.h"
#import "Header.h"
#import "JSONModel.h"

@interface AppDelegate ()<SinaWeiboDelegate>
@property (nonatomic,strong) MMDrawerController * drawerController;//框架中心控制器
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    self.window.backgroundColor = [UIColor whiteColor];
    
    [self.window makeKeyAndVisible];
#pragma mark - modol特殊字段处理
   JSONKeyMapper *mapper =  [[JSONKeyMapper alloc]initWithDictionary:@{
                                               @"description":@"desc"
                                               }];
    
    [JSONModel setGlobalKeyMapper:mapper];
//----------------------------------------------------------------
#pragma mark - 集成MM
    //设置获取左侧右侧导航栏
   UIStoryboard *left =  [UIStoryboard storyboardWithName:@"Left" bundle:nil];
    UIStoryboard *right = [UIStoryboard storyboardWithName:@"Right" bundle:nil];
    
    UINavigationController *leftNav = [left instantiateInitialViewController];
    
    UINavigationController *rightNav = [right instantiateInitialViewController];
    
    
    //初始化
    self.drawerController = [[MMDrawerController alloc]
                             initWithCenterViewController:[[BaseTabViewController alloc]init]
                             leftDrawerViewController:leftNav
                             rightDrawerViewController:rightNav];
    
    //设置阴影
    [self.drawerController setShowsShadow:NO];
    [self.drawerController setRestorationIdentifier:@"MMDrawer"];
    //设置右滑得距离
    [self.drawerController setMaximumRightDrawerWidth:200.0];
    //设置打开的手势的作用范围
    [self.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    //设置关闭的手势的作用范围
    [self.drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    
    //设置打开左右侧滑界面的样式
    [self.drawerController
     setDrawerVisualStateBlock:^(MMDrawerController *drawerController, MMDrawerSide drawerSide, CGFloat percentVisible) {
         MMDrawerControllerDrawerVisualStateBlock block;
         //提供滑动的样式的单例（这个类并没有加在框架内，使用的时候直接将文件加入框架内就可以）
         block = [[MMExampleDrawerVisualStateManager sharedManager]
                  drawerVisualStateBlockForDrawerSide:drawerSide];
         if(block){
             block(drawerController, drawerSide, percentVisible);
         }
         
         
         /*设置样式方法
          MMDrawerAnimationTypeNone,简单效果1
          MMDrawerAnimationTypeSlide,简单效果2
          MMDrawerAnimationTypeSlideAndScale,//台阶
          MMDrawerAnimationTypeSwingingDoor,//立体
          MMDrawerAnimationTypeParallax,//简单效果1
          */
         
         
         //设置左侧滑动样式
         [MMExampleDrawerVisualStateManager sharedManager].leftDrawerAnimationType =MMDrawerAnimationTypeNone;
     }];

    self.window.rootViewController = self.drawerController;
    
#pragma mark - 集成SinaSDK
    
    //创建新浪对象
    self.sinaweibo = [[SinaWeibo alloc] initWithAppKey:kAppKey appSecret:kAppSecret appRedirectURI:kAppRedirectURI andDelegate:self];
    
    //存储数据
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *sinaweiboInfo = [defaults objectForKey:@"SinaWeiboAuthData"];
    if ([sinaweiboInfo objectForKey:@"AccessTokenKey"] && [sinaweiboInfo objectForKey:@"ExpirationDateKey"] && [sinaweiboInfo objectForKey:@"UserIDKey"])
    {
        self.sinaweibo.accessToken = [sinaweiboInfo objectForKey:@"AccessTokenKey"];
        self.sinaweibo.expirationDate = [sinaweiboInfo objectForKey:@"ExpirationDateKey"];
        self.sinaweibo.userID = [sinaweiboInfo objectForKey:@"UserIDKey"];
    }

    
    
    return YES;
}
//移除认证信息
- (void)removeAuthData
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"SinaWeiboAuthData"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

//保存认证数据
- (void)storeAuthData
{
    SinaWeibo *sinaweibo = [self sinaweibo];
    
    NSDictionary *authData = [NSDictionary dictionaryWithObjectsAndKeys:
                              sinaweibo.accessToken, @"AccessTokenKey",
                              sinaweibo.expirationDate, @"ExpirationDateKey",
                              sinaweibo.userID, @"UserIDKey",
                              sinaweibo.refreshToken, @"refresh_token", nil];
    [[NSUserDefaults standardUserDefaults] setObject:authData forKey:@"SinaWeiboAuthData"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - sinaDelegate
- (void)sinaweiboDidLogIn:(SinaWeibo *)sinaweibo{
    NSLog(@"登录成功");
    [self storeAuthData];
}

- (void)sinaweiboDidLogOut:(SinaWeibo *)sinaweibo{
    NSLog(@"退出成功");
    [self removeAuthData];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
