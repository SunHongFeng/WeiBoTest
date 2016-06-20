//
//  MyCell.m
//  01_微博
//
//  Created by 孙洪峰 on 16/6/16.
//  Copyright © 2016年 孙洪峰. All rights reserved.
//

#import "MyCell.h"
#import "UIImageView+WebCache.h"
#import "Header.h"
@interface MyCell ()
@property (nonatomic,strong)NSMutableArray *arrImg;
@property (nonatomic,strong)NSMutableArray *reweetImgViewArr;


@end
@implementation MyCell

////复写init方法进行创建布局
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if(self){
    
        //创建子视图
        [self createSubViews];
    }
    return self;
}


//创建子视图方法
- (void)createSubViews{
    
//在单元格上创建子视图 ,只做初始化创建,一定要加到self.contentView上
    //用户头像
    _iconImgView = [[UIImageView alloc]init];
    [self.contentView addSubview:_iconImgView];
    
    //用户名称
    _name = [[UILabel alloc]init];
    [self.contentView addSubview:_name];
    _name.font = [UIFont systemFontOfSize:17];
    
    //时间
    _time = [[UILabel alloc]init];
    _time.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:_time];
    
    //来源
    _source = [[UILabel alloc]init];
    _source.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:_source];
    
    //内容
    _text = [[UILabel alloc]init];
    _text.numberOfLines = 0;
    _text.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:_text];
    
 

    
}
#pragma mark - 懒加载创建
//懒加载创建转发文字
-(UILabel *)retText{
    if(_retText == nil){
        _retText = [[UILabel alloc]init];
        _retText.frame = CGRectZero;
        _retText.numberOfLines = 0;
       _retText.font = [UIFont systemFontOfSize:14];
        _retText.textColor = [UIColor redColor];
        [self.contentView addSubview:_retText];
    }
    return _retText;
}

//懒加载加载转发图片
//- (UIImageView *)retImg{
//    if(_retImg == nil){
//        
//
//        _retImg = [[UIImageView alloc]init];
//        
//        [self.contentView addSubview:_retImg];
//    }
//    return _retImg;
//}
//在return cell;整个屏幕显示n个单元格后,会调用此方法
//布局子视图
-(void)layoutSubviews{
    
    [super layoutSubviews];
    

    
    
    //自定义头像宽高
    CGFloat iconWidth = 50;
    CGFloat iconHeight = iconWidth;
    //间距
    CGFloat marginH = 5;
    //1.头像
    [_iconImgView sd_setImageWithURL:[NSURL URLWithString:_usermodel.profile_image_url]];
    _iconImgView.frame = CGRectMake(10, 10, iconWidth, iconHeight);
    
    //2.用户名称
    _name.text = _usermodel.screen_name;
    _name.frame = CGRectMake(10 +iconHeight +marginH , 10, 160, 20);
    
    //3.配图
    
    for (UIImageView *view in _peitu.subviews) {
        
        [view  removeFromSuperview];
    }
    //转发配图
    
    for (UIImageView *view in _retImg.subviews) {
        
        [view  removeFromSuperview];
        
        
    }

    _peitu = [_model getImgRect:_model.pic_urls];
    _peitu.frame = CGRectMake(10, _model.textFrame.size.height +70, 355, _model.peituH);
    [self.contentView addSubview:_peitu];
    
    int i = 0;
#pragma mark - 配图添加手势
    _arrImg = [NSMutableArray array];
    for (UIImageView *view in _peitu.subviews) {
        view.userInteractionEnabled = YES;
        //添加手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        
        [view addGestureRecognizer:tap];
        view.tag = i;
        i ++;
        [_arrImg addObject:view];
        
    
        
    }

    _time.text = [self getTime:_model.created_at];
    _time.font = [UIFont systemFontOfSize:10];
    

    _time.frame = CGRectMake(kScreenWeight - 70, 10, 60, 20);
    
    //4.内容
    _text.text = _model.text;
    
    _text.frame = CGRectMake(10 , 60, _model.textFrame.size.width , _model.textFrame.size.height + 10);
    
    //5.来源
    _source.text = [self soucetext:_model.source];
    _source.font = [UIFont systemFontOfSize:10];

    _source.frame = CGRectMake(10 +iconHeight +marginH, 10 + 20 +marginH, kScreenWeight - 10 +iconHeight +marginH, 20);
    
    //防止重用初始时赋值0;
    _retText.frame = CGRectZero;
    
    _retImg.frame = CGRectZero;
    
    //6.判断是否有转发
    if(_model.retweeted_status != nil){

        
        
        //转发文字
        
        
        self.retText.text = _model.retText;

        self.retText.frame = CGRectMake(10, _text.frame.size.height +20 +_text.frame.origin.y, _model.zhuanTextH.size.width, _model.zhuanTextH.size.height +10);
        
#pragma mark - 转发配图添加手势
        for (UIImageView *view in _peitu.subviews) {
            view.userInteractionEnabled = YES;
            //添加手势
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
            
            [view addGestureRecognizer:tap];
            view.tag = i;
            i ++;
            [_reweetImgViewArr addObject:view];
            
        }

        //        //转发图片
        
         _retImg = [_model getImgRect:_model.retImg];
        
        _retImg.frame = CGRectMake(10, _retText.frame.size.height+ _retText.frame.origin.y , 355, _model.zhuanImgH);
       
        [self.contentView addSubview:_retImg];
    }

//


//
    }
//#pragma mark - 图片的点击方法

- (void)tapAction:(UITapGestureRecognizer *)tap{
    
    [WXPhotoBrowser showImageInView:self.window selectImageIndex:tap.view.tag delegate:self];
    
    
}
#pragma mark - WXPhotoBrowserDelegate

//需要显示的图片个数
- (NSUInteger)numberOfPhotosInPhotoBrowser:(WXPhotoBrowser *)photoBrowser{
    
    if (_model.pic_urls.count >0) {
        return _model.pic_urls.count;
    }else{
        return  _model.retImg.count;
    }
    
    
    
}
//返回需要显示的图片对应的Photo实例,通过Photo类指定大图的URL,以及原始的图片视图
- (WXPhoto *)photoBrowser:(WXPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index{
    
    WXPhoto *photo = [[WXPhoto alloc] init];
    
    NSArray *urlS = nil;
    if (_model.pic_urls.count > 0) {
        photo.srcImageView = self.arrImg[index];
        urlS = _model.pic_urls;
        
    }else{
        photo.srcImageView = self.reweetImgViewArr[index];
        urlS = _model.retImg;
    }
    NSString *imgUrl = urlS[index][@"thumbnail_pic"];
    //    http://ww3.sinaimg.cn/bmiddle/0068nw98gw1f51g9t65qfj30jg0px0y8.jpg
    imgUrl = [imgUrl stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
    
    photo.url = [NSURL URLWithString:imgUrl];
    
    return photo;
    
}


//修改时间方法
- (NSString *)getTime:(NSString *)timeSource
{
    //Tue Mar 08 13:14:45 +0800 2016  服务端获取时间的格式是这样的
    NSDateFormatter *form = [[NSDateFormatter alloc] init];
    //设置时区
    form.locale = [NSLocale localeWithLocaleIdentifier:@"cn"];
    form.dateFormat = @"EEE MMM dd HH:mm:ss Z yyy";
    NSDate *date = [form dateFromString:timeSource];
    
    //得到当前的时间差
    NSTimeInterval timeInterval = [date timeIntervalSinceNow];
    timeInterval = -timeInterval;
    //然后进行时间的比较
    
    //秒
    
    if(timeInterval < 60)
    {
        return [NSString stringWithFormat:@"1分钟前"];
    }
    //分钟
    NSInteger minute = timeInterval / 60;
    if(minute < 60)
    {
        return [NSString stringWithFormat:@"%ld分钟前",minute];
    }
    NSInteger hours = minute / 60;
    if(hours < 24)
    {
        return [NSString stringWithFormat:@"%ld小时前",hours];
    }
    NSInteger day = hours / 24;
    
    if(day <= 1)
    {
        form.dateFormat = @"HH:mm";
        NSString *oldtime = [form stringFromDate:date];
        return [NSString stringWithFormat:@"昨天 %@",oldtime];
    }
    else if(day < 7)
    {
        return [NSString stringWithFormat:@"%ld天前",day];
    }
    else
    {
        form.dateFormat = @"yyyy-MM-dd HH:mm";
        NSString *oldtime = [form stringFromDate:date];
        return [NSString stringWithFormat:@"%@",oldtime];
    }
    return nil;
    
}

//截取来源
- (NSString *)soucetext:(NSString *)text{
//    <a href="http://weibo.com" rel="nofollow">新浪微博</a>
    
    //1.开始截取的位置
    NSUInteger start = [text rangeOfString:@">"].location;
    
    //2.结束截取的位置
    NSUInteger end = [text rangeOfString:@"<" options:NSBackwardsSearch].location;
    
    //3.截取
    
    //容错处理  如果不是规定格式 那么正常返回
    if(start !=NSNotFound){
    
        return [text substringWithRange:NSMakeRange(start + 1 , end - start - 1)];
    }
    
    return text;
    
}
@end
