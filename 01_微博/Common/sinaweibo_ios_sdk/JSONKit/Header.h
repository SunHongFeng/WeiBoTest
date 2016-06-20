//
//  Header.h
//  01_微博
//
//  Created by 孙洪峰 on 16/6/12.
//  Copyright © 2016年 孙洪峰. All rights reserved.
//

#ifndef Header_h
#define Header_h

#define kAppKey             @"1411054246"
#define kAppSecret          @"5694cadabc05adcaaa4a8edf1169d4a8"
#define kAppRedirectURI     @"http://www.baidu.com"
#define kScreenWeight   [UIScreen mainScreen].bounds.size.width
#define kScreenHeight   [UIScreen mainScreen].bounds.size.height
//提示框
#define SHOWALERT(m) \
{\
UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:m delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil];\
[alert show]; \
}\

#endif /* Header_h */
