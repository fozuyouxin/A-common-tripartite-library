//
//  MeViewController.m
//  iOSReview
//
//  Created by Apple on 2017/7/19.
//  Copyright © 2017年 KennyHito. All rights reserved.
//

#import "MeViewController.h"

@interface MeViewController ()<UIScrollViewDelegate>

@property(nonatomic,strong) UIImageView * topImageView;
@property(nonatomic,strong) NSArray * arrData;

@end

@implementation MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _arrData = @[@"GitHub",@"我的博客",@"我的微博",@"我的简书",@"联系我们",@"反馈信息",@"我的设备",@"清除缓存",@"夜间模式"];
    
    [self setUpTableView];
    self.navigationItem.title = @"";
    [self createTopImageView];
}

#pragma mark -- createTopImageView
- (void)createTopImageView{
    //顶部试图
    _topImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, -200, [UIScreen mainScreen].bounds.size.width, 200)];
    
    _topImageView.image = [UIImage imageNamed:@"biao.jpg"];
    
    //[_topImageView sd_setImageWithURL:[NSURL URLWithString:@"https://image.yiwencaifu.com/upload/20161202/1480654937932.jpg"] placeholderImage:nil options:SDWebImageAllowInvalidSSLCertificates];
    
    _topImageView.clipsToBounds = YES;
    
    _topImageView.contentMode = UIViewContentModeScaleAspectFill;
    //始终保持原有宽高比例
    
    //添加到tableView上
    [self.tableView addSubview:_topImageView];
    
    //contentInset 额外滑动区域
    self.tableView.contentInset = UIEdgeInsetsMake(200, 0, 0, 0);
    //现在tableView的偏移量的y变成了-200
    
}

/* 行数 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _arrData.count;
}
/* cell内容 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellID = @"cellID";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = _arrData[indexPath.row];
    if (indexPath.row == 8) {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryNone;
        UISwitch * sw = [[UISwitch alloc]initWithFrame:CGRectMake(50, 50, 100, 50)];
        sw.on = NO;//默认关闭状态
        [sw addTarget:self action:@selector(changeEvent:) forControlEvents:UIControlEventValueChanged];
        cell.accessoryView = sw;
    }
    return cell;
}
#pragma mark -- UISwitch开关按钮事件实现
- (void)changeEvent:(UISwitch *)sw{
    static BOOL flag = NO;
    flag = !flag;
    if (sw.on && flag) {
        self.view.window.backgroundColor = [UIColor blackColor];//设置背景色
        self.view.window.alpha = 0.5;//透明度
        
    }else{
        self.view.window.backgroundColor = [UIColor whiteColor];
        self.view.window.alpha = 1.0;
        
    }
    
}

#pragma mark -- cell点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        //打开github
        [self openFuncCommd:@"https://github.com/NSLog-YuHaitao?tab=repositories"];
    }else if(indexPath.row == 1){
        //我的博客
        [self openFuncCommd:@"http://www.cnblogs.com/KennyHito/"];
        
    }else if(indexPath.row == 2){
        //我的微博
        [self openFuncCommd:@"http://weibo.com/KennyHito"];
        
    }else if(indexPath.row == 3){
        //打开简书
        [self openFuncCommd:@"http://www.jianshu.com/users/c3dc9c3117a5/latest_articles"];
        
    }else if (indexPath.row == 4){
        //联系我们
        [self openFuncCommd:@"telprompt://13522131242"];//自带弹出提示框
        //        [self openFuncCommd:@"tel://13522131242"];//不存在提示框
        
    }else if (indexPath.row == 5){
        //反馈信息
        [self openFuncCommd:@"mailto://yht1154180808@163.com"];
        
    }else if(indexPath.row == 6){
        //我的设备
        [self showAlertMessage:[self getDeviceInfo]];
        
    }else if(indexPath.row == 7){
        //清除缓存
        
    }else if(indexPath.row == 8){
        //夜间模式模块
    }
    
}

#pragma mark -- scrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    float offSet = scrollView.contentOffset.y;
    if (offSet < -200) {
        //正在下拉
        //更新顶部试图的效果
        //1.图片始终顶在最上方
        //2.图片高度随下拉而增加
        CGRect rect = _topImageView.frame;  // (0, -200, SCREEN_W, 200)]
        rect.origin.y = offSet;
        rect.size.height = -offSet;
        //重置
        _topImageView.frame = rect;
        
    }
}
#pragma mark -- 将导航栏隐藏
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];//隐藏导航栏
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];//去除黑线
}

#pragma mark -- 将导航栏归还原样
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    //显示导航栏
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    //加上黑线
    [self.navigationController.navigationBar setShadowImage:nil];
    
}


@end
