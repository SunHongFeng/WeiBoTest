//
//  MoreViewController.m
//  01_微博
//
//  Created by 孙洪峰 on 16/6/12.
//  Copyright © 2016年 孙洪峰. All rights reserved.
//

#import "MoreViewController.h"
#import "ZTViewController.h"
#import "Theme.h"
#import "AppDelegate.h"
#import "Header.h"
@interface MoreViewController ()<UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *cellLabel;
@property (weak, nonatomic) IBOutlet UIImageView *img1;
@property (weak, nonatomic) IBOutlet UIImageView *img2;
@property (weak, nonatomic) IBOutlet UIImageView *img3;

@end

@implementation MoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //设置主题
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


//--------------------------------------------------------------------
//视图将要显示
-(void)viewWillAppear:(BOOL)animated{
//接收通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(notificatio:) name:@"notifica" object:nil];
    
    //显示label的文字
    Theme *manager = [Theme shartTheme];
    _cellLabel.text =  manager.themeName;
    
    _img1.image = [manager getThemeImgWithName:@"more_icon_theme@2x.png"];
    
    _img2.image = [manager getThemeImgWithName:@"more_icon_account@2x.png"];
    
    _img3.image = [manager getThemeImgWithName:@"more_icon_feedback@2x.png"];
    
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0&& indexPath.row == 0){
    
        ZTViewController *zt = [[ZTViewController alloc]init];
//
//        zt.block = ^(NSString *abc){
//            _cellLabel.text = abc;
//        };
        //push
        [self.navigationController pushViewController:zt animated:YES];
        
        //如果点击注销
    }else if (indexPath.section == 2){
    
        
        
        //显示提示框
    
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"哈哈哈哈"delegate:self cancelButtonTitle:@"确认" otherButtonTitles:@"取消", nil];
        [alert show];
        
        
        

        
    }
}
//提示框代理方法
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 0) {
                //注销
                //1.获取sina对象
                AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        
                SinaWeibo *sinawb = delegate.sinaweibo;
        
                [sinawb logOut];
    }
}
//通知调用方法
- (void)notificatio:(NSNotification *)no{

    _cellLabel.text =[no.userInfo objectForKey:@"oo"];
    
    Theme *manager = [Theme shartTheme];
    
    manager.themeName = _cellLabel.text;
}
@end
