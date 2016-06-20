//
//  DiscoverViewController.m
//  01_微博
//
//  Created by 孙洪峰 on 16/6/12.
//  Copyright © 2016年 孙洪峰. All rights reserved.
//

#import "DiscoverViewController.h"
#import "AppDelegate.h"
#import "WeiBoModol.h"
#import "Header.h"
#import "MyCell.h"
#import "ODRefreshControl.h"


@interface DiscoverViewController ()<SinaWeiboRequestDelegate>

@property (nonatomic,strong)NSMutableArray *modelArr;//存储model的数组--微博
@property (nonatomic,strong)NSMutableArray *userArr;//存储model数组--User用户
@property (nonatomic,strong)UITableView *tableView;//创建tabelView
@property (nonatomic,strong)MyCell *cell;
@end

static NSString *identifier = @"cell_ID";

@implementation DiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//调用方法获取新浪微博对象
    SinaWeibo *sina = [self sinaweibo];

    //容错处理--判断是否验证
    if ([sina isAuthValid]){
        
    //如果验证过了--可以请求数据
        
        [sina requestWithURL:@"statuses/home_timeline.json"
                      params:nil
                  httpMethod:@"GET"
                    delegate:self];
        
    }else {

        
// * @description 登录入口，当初始化SinaWeibo对象完成后直接调用此方法完成登录
        
        //内部作了验证操作
        [sina logIn];
    }
    
#pragma mark - 创建tabelView
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWeight, kScreenHeight) style:UITableViewStylePlain];
    
    
    [self.view addSubview:_tableView];
    
    //设置单元格分割线样式
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    //注册单元格
    
    [_tableView registerClass:[MyCell class] forCellReuseIdentifier:identifier];
    
    _tableView.backgroundColor = [UIColor clearColor];
    
    //下拉刷新
    ODRefreshControl *refreshControl = [[ODRefreshControl alloc] initInScrollView:_tableView];
    [refreshControl addTarget:self action:@selector(dropViewDidBeginRefreshing:) forControlEvents:UIControlEventValueChanged];
    
    }
#pragma mark - 下拉刷新
- (void)dropViewDidBeginRefreshing:(ODRefreshControl *)refreshControl
{
    double delayInSeconds = 3.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [refreshControl endRefreshing];
    });
}
//获取新浪微博对象
- (SinaWeibo *)sinaweibo{
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    return delegate.sinaweibo;
}

//视图将要显示
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [_tableView reloadData];
}

#pragma mark - 请求数据delegate方法SinaWeiboRequestDelegate
//返回错误
- (void)request:(SinaWeiboRequest *)request didFailWithError:(NSError *)error{
    NSLog(@"请求失败");
}
//成功并返回数据
- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result{
    NSLog(@"请求成功");
    
    NSArray *array = result[@"statuses"];
    //初始化
    _modelArr = [NSMutableArray array];
    _userArr = [NSMutableArray array];
    
    for (NSDictionary *dic in array) {
        
//        WeiBoModol *weibomodel = [[WeiBoModol alloc]initWithDictionary:dic error:nil];
        WeiBoModol *weibomodel = [[WeiBoModol alloc]init];
        
         weibomodel.retweeted_status = dic[@"retweeted_status"];
         weibomodel.retImg =dic[@"retweeted_status"][@"pic_urls"];
        weibomodel.retText =dic[@"retweeted_status"][@"text"];
       
        
        weibomodel.created_at = dic[@"created_at"];
        weibomodel.pic_urls = dic[@"pic_urls"];
        weibomodel.idstr = dic[@"idstr"];
        weibomodel.text = dic[@"text"];
        weibomodel.source = dic[@"source"];
        weibomodel.favorited = dic[@"favorited"];
        weibomodel.thumbnail_pic = dic[@"thumbnail_pic"];
        weibomodel.bmiddle_pic = dic[@"bmiddle_pic"];
        weibomodel.original_pic = dic[@"original_pic"];
        weibomodel.geo = dic[@"geo"];
//        weibomodel.reposts_count = dic[@"reposts_count"];
//        weibomodel.comments_count = dic[@"comments_count"];
        weibomodel.user= dic[@"user"];
       

//
//
      
        
        
        //将model对象存储到可变数组中
        [_modelArr addObject:weibomodel];
        
//        
        UserModol *usermodel = [[UserModol alloc]initWithDictionary:dic[@"user"] error:nil];

//        //将model对象存储到可变数组中
        [_userArr addObject:usermodel];
        
    }
    
    
    
    [_tableView reloadData];
}

//返回单元格行数方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _modelArr.count;
}

//创建单元格
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
//1.创建单元格
   _cell = [_tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
//2.将数据显示到单元格上
    _cell.model = _modelArr[indexPath.row];
    _cell.usermodel = _userArr[indexPath.row];
    NSLog(@"=====%@",_cell.model.pic_urls);
    _cell.backgroundColor = [UIColor clearColor];
    
//3.返回单元格
    
    return _cell;
}

//设置单元格高度方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    WeiBoModol *model = _modelArr[indexPath.row];
    
 
    CGFloat height =model.height +model.zhuanTextH.size.height + 20 +model.zhuanImgH
  +20;
  
    
    return height;
}



@end
