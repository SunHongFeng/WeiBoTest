//
//  ZTViewController.m
//  01_微博
//
//  Created by 孙洪峰 on 16/6/13.
//  Copyright © 2016年 孙洪峰. All rights reserved.
//

#import "ZTViewController.h"
#import "ZTTableViewCell.h"
#import "Theme.h"

@interface ZTViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)NSArray *ztArr;
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)ZTTableViewCell *cell;

@end
static NSString *identifier = @"asdsd";
@implementation ZTViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//1.创建数组
//    _ztArr = @[
//               @"猫爷",@"黑暗骑士",@"Mr.O",@"夜总会",@"蓝月亮",@"黑暗之女",@"FishEye",@"丛林",@"玩具",@"小熊",@"魁拔",@"深海",@"林肯公园",@"粉色之恋",@"村落"
//               ];

    //获取plist文件
    NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"Theme.plist" ofType:nil];
    
    //通过plist路径获取文件
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    
    //取出全部key存在数组中
    _ztArr = [dic allKeys];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 375, 667) style:UITableViewStylePlain];
    _tableView.delegate = self;
    
    _tableView.dataSource = self;
    
      _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    [self.view addSubview:_tableView];
    
    //注册单元格
    [_tableView registerNib:[UINib nibWithNibName:@"ztCell" bundle:nil] forCellReuseIdentifier:identifier];
    
    
    _tableView.backgroundColor = [UIColor clearColor];

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _ztArr.count;
}

//创建单元格
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    _cell = [_tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    _cell.label.text = _ztArr[indexPath.row];
    
//添加对号
    Theme *manager= [Theme shartTheme];
    //如果主题和单元格中哪个一样就  给他加对勾
    if([manager.themeName isEqualToString:_ztArr[indexPath.row]]){
    
        _cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    
    _cell.backgroundColor = [UIColor clearColor];
    return _cell;
    
    
}

//单元格点击方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    NSDictionary *dic = @{@"oo":_ztArr[indexPath.row]};
    
    //block实现
    
//    self.block(_ztArr[indexPath.row]);
//    _cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    //发通知
    [[NSNotificationCenter defaultCenter]postNotificationName:@"notifica" object:self userInfo:dic];

//pop回去
    [self.navigationController popViewControllerAnimated:YES];
    
    
    
    
    

}



@end
