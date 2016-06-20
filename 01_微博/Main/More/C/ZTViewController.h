//
//  ZTViewController.h
//  01_微博
//
//  Created by 孙洪峰 on 16/6/13.
//  Copyright © 2016年 孙洪峰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
typedef void(^Myblock)(NSString *abc);
@interface ZTViewController : BaseViewController
@property (nonatomic,strong)NSString *lab;

@property (nonatomic,copy)Myblock block;
@end
