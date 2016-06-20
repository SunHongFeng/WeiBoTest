//
//  MyCell.h
//  01_微博
//
//  Created by 孙洪峰 on 16/6/16.
//  Copyright © 2016年 孙洪峰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiBoModol.h"
#import "UserModol.h"
#import "WXPhotoBrowser.h"
@interface MyCell : UITableViewCell<PhotoBrowerDelegate>


@property (nonatomic,strong)WeiBoModol *model;//微博model对象

@property (nonatomic,strong)UserModol *usermodel;//user对象model

@property(nonatomic,copy)NSString*ssss;

@property (nonatomic,strong)UIImageView *iconImgView;//头像
@property (nonatomic,strong)UILabel *name;//用户名称
@property (nonatomic,strong)UILabel *time;//时间
@property (nonatomic,strong)UILabel *source;//来源
@property (nonatomic,strong)UILabel *text;//内容

@property (nonatomic,strong)UIImageView *peitu;//配图

@property (nonatomic,strong)UILabel *retText;//转发文字

@property (nonatomic,strong)UIImageView *retImg;//转发图片


@end
