//
//  MessageViewController.m
//  01_微博
//
//  Created by 孙洪峰 on 16/6/12.
//  Copyright © 2016年 孙洪峰. All rights reserved.
//

#import "MessageViewController.h"
#import "Theme.h"
#import "ThemeLabel.h"
@interface MessageViewController ()

@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    ThemeLabel *lab = [[ThemeLabel alloc]initWithFrame:CGRectMake(40, 100, 150, 30)];
    
    lab.text = @"大王叫我来巡山";
    
    lab.colorName = @"Profile_Unfollow_color";
    
    [self.view addSubview:lab];
    
}


@end
