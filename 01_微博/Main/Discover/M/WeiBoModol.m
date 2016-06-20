//
//  WeiBoModol.m
//  01_微博
//
//  Created by 孙洪峰 on 16/6/14.
//  Copyright © 2016年 孙洪峰. All rights reserved.
//

#import "WeiBoModol.h"
#define kCellheight 
#define kImgHeight (355 / 3)
#define kImgWeight (355 / 3)
#import "UIImageView+WebCache.h"

@interface WeiBoModol (){
    UIImageView *imgV;

}

@end

@implementation WeiBoModol



- (void)setText:(NSString *)text{
    _text = text;

    
    //model.textFrame.size.height + _cell.iconImgView.frame.size.height +60 +50
    NSDictionary *attributes = @{NSFontAttributeName : [UIFont systemFontOfSize:14]};
    
    //ios7.0之后被弃用掉了,苹果建议使用- (CGRect)boundingRectWithSize:(CGSize)size options:(NSStringDrawingOptions)options attributes:(nullable NSDictionary<NSString *, id> *)attributes context:(nullable NSStringDrawingContext *)context
    
    
    //  [content sizeWithFont:<#(UIFont *)#> constrainedToSize:<#(CGSize)#> lineBreakMode:<#(NSLineBreakMode)#>] //不能使用了
    
    
    //文本绘制所占据的矩形空间
    CGRect frame =[text boundingRectWithSize:CGSizeMake(355, 1000) //宽高限制,用于计算文本绘制所占据的矩形空间
                                     options:NSStringDrawingUsesLineFragmentOrigin //字符串绘制的选项(根据字符原始的基线绘制)
                                  attributes:attributes
                                     context:nil]; //上下文
    
    //给文字矩形赋值
    _textFrame = frame;
    
    
    
    
    
    
    [self peituHeigjt];
    //上部总高度
    //文字+头像+总间距 + 图片背景高度
    _height += _textFrame.size.height +75  +_peituH;
    
   
}


//转发文字方法
- (void)setRetText:(NSString *)retText{

    _retText = retText;
    
    NSDictionary *attributes = @{NSFontAttributeName : [UIFont systemFontOfSize:14]};
 
    //文本绘制所占据的矩形空间
    CGRect frame =[_retText boundingRectWithSize:CGSizeMake(355, 1000) //宽高限制,用于计算文本绘制所占据的矩形空间
                                     options:NSStringDrawingUsesLineFragmentOrigin //字符串绘制的选项(根据字符原始的基线绘制)
                                  attributes:attributes
                                     context:nil]; //上下文
    
    //给文字矩形赋值
    _zhuanTextH = frame;
    
    
    
    
    
    
    if(_retImg.count <=0){
        _zhuanImgH = 0;
    }
    else if(    _retImg.count < 4 && _retImg.count >0){
        _zhuanImgH = kImgHeight;
    }else if (_retImg.count <7){
        _zhuanImgH= 2 *kImgHeight;
    }else if (_retImg.count <10){
        _zhuanImgH= 3 *kImgHeight;
    }
    //上部总高度
    //文字+头像+总间距 + 图片背景高度
//    _height += _zhuanTextH.size.height +_zhuanImgH ;
}






//根据图片算取位置背景

//配图高度
- (void)peituHeigjt{
    //配图高度
    if(_pic_urls.count <=0){
        _peituH = 0;
    }
    else if(    _pic_urls.count < 4 && _pic_urls.count >0){
        _peituH = kImgHeight;
    }else if (_pic_urls.count <7){
        _peituH = 2 *kImgHeight;
    }else if (_pic_urls.count <10){
        _peituH = 3 *kImgHeight;
    }

}


- (UIImageView *)getImgRect:(NSArray *)pic{
    
    //容错判断是否数组为空
    if(pic.count == 0){
        
       
        return nil;
    }
    
    
    //存储图片url的数组
    _urlArr= [NSMutableArray array];
    
    //1.获取数据并解析
    for (NSDictionary *dic in pic) {
        //获取thumbnail_pic
        NSString *url = dic[@"thumbnail_pic"];
        //将图片url存储到数组中
        [_urlArr addObject:url];
    }
    
    imgV = [[UIImageView alloc]init];
    

    
    //行数
    NSInteger row = 0;
    

    if(_urlArr.count <4){
        
        row = 1;
        //1行的话给父视图赋值并且创建小视图
        
    }
    else if (_urlArr.count < 7){
        
        row = 2;
        
    }else {
        
        row = 3;
    }
    
    for (int i = 0 ; i < _urlArr.count; i ++) {
    
        UIImageView *imgview = [[UIImageView alloc]init];
        
//        如果是 1行

//        要求  横着超过3个 (+ 竖排1  ).(横排重置)


        
            imgview.frame = CGRectMake(i *kImgWeight, 0, kImgHeight, kImgWeight);
    
     
//        当i> 2时  超过一行时
        if(i > 2){
        
            imgview.frame = CGRectMake((i -3) *kImgWeight, kImgHeight, kImgHeight, kImgWeight);
        }
    
//        other当 i> 5时
        
        if(i > 5){
            
        imgview.frame = CGRectMake((i -6) *kImgWeight, kImgHeight * 2, kImgHeight, kImgWeight);
            
           
            
        }

        
        //给图片赋值.img
        [imgview sd_setImageWithURL:[NSURL URLWithString:_urlArr[i]]];
        
        //添加图片
        [imgV addSubview:imgview];
    
        
    }


    
    return imgV;
}


@end
