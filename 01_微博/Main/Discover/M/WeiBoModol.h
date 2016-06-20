//
//  WeiBoModol.h
//  01_微博
//
//  Created by 孙洪峰 on 16/6/14.
//  Copyright © 2016年 孙洪峰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModol.h"
#import <UIKit/UIKit.h>
@interface WeiBoModol : JSONModel
/*
 
 返回值字段	字段类型	字段说明
 created_at	string	微博创建时间
 id	int64	微博ID
 mid	int64	微博MID
 idstr	string	字符串型的微博ID
 text	string	微博信息内容
 source	string	微博来源
 favorited	boolean	是否已收藏，true：是，false：否
 truncated	boolean	是否被截断，true：是，false：否
 in_reply_to_status_id	string	（暂未支持）回复ID
 in_reply_to_user_id	string	（暂未支持）回复人UID
 in_reply_to_screen_name	string	（暂未支持）回复人昵称
 thumbnail_pic	string	缩略图片地址，没有时不返回此字段
 bmiddle_pic	string	中等尺寸图片地址，没有时不返回此字段
 original_pic	string	原始图片地址，没有时不返回此字段
 geo	object	地理信息字段 详细
 user	object	微博作者的用户信息字段 详细
 retweeted_status	object	被转发的原微博信息字段，当该微博为转发微博时返回 详细
 reposts_count	int	转发数
 comments_count	int	评论数
 attitudes_count	int	表态数
 mlevel	int	暂未支持
 visible	object	微博的可见性及指定可见分组信息。该object中type取值，0：普通微博，1：私密微博，3：指定分组微博，4：密友微博；list_id为分组的组号
 pic_ids	object	微博配图ID。多图时返回多图ID，用来拼接图片url。用返回字段thumbnail_pic的地址配上该返回字段的图片ID，即可得到多个图片url。
 ad	object array	微博流内的推广微博ID

 */
@property (nonatomic,copy)NSString *created_at;//微博创建时间 3
@property (nonatomic,assign)long id;
@property (nonatomic,copy)NSString *idstr;//微博iD 1
@property(nonatomic,copy)NSString     *text;              //微博的内容
@property(nonatomic,copy)NSString     *source;              //微博来源 4
@property(nonatomic,assign)BOOL         favorited;         //是否已收藏
@property(nonatomic,copy)NSString  <Optional> *thumbnail_pic;     //缩略图片地址 2
@property(nonatomic,copy)NSString  <Optional>  *bmiddle_pic;     //中等尺寸图片地址
@property(nonatomic,copy)NSString   <Optional>   *original_pic;     //原始图片地址
@property(nonatomic,retain)NSDictionary <Optional> *geo;               //地理信息字段
@property(nonatomic,assign)int     reposts_count;      //转发数
@property(nonatomic,assign)int    comments_count;      //评论数

@property (nonatomic,strong)UserModol *user;   //用户信息

@property (nonatomic,strong)WeiBoModol <Optional> *retweeted_status;//转发微博

//根据content内容,文字大小,提前计算content显示的时候,需要的frame
@property (nonatomic,assign)CGRect textFrame;

//上班不高度
@property (nonatomic,assign)CGFloat height;
//微博配图ID。多图时返回多图ID，用来拼接图片url。用返回字段thumbnail_pic的地址配上该返回字段的图片ID，即可得到多个图片url
@property (nonatomic,strong)NSArray *pic_urls;



@property (nonatomic,strong)NSMutableArray *urlArr;//转型后图片数组

//获取坐标方法
- (UIImageView *)getImgRect:(NSArray *)pic;

//配图高度
@property (nonatomic,assign)CGFloat peituH;//配图高

//转发文字
@property (nonatomic,copy)NSString *retText;

//转发图片
@property (nonatomic,strong)NSArray *retImg;

//转发空间高度
@property (nonatomic,assign)CGRect zhuanTextH;
//转发配图高度
@property (nonatomic,assign)CGFloat zhuanImgH;




@end
