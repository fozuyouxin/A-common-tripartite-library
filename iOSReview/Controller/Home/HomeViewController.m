//
//  HomeViewController.m
//  iOSReview
//
//  Created by Apple on 2017/7/19.
//  Copyright © 2017年 KennyHito. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@property (nonatomic,strong) UIButton * button;//客服按钮

@end

@implementation HomeViewController

- (void)setUpService{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"客服" forState:UIControlStateNormal];
    button.titleLabel.numberOfLines = 0;
    button.titleLabel.textAlignment = 1;
    button.titleLabel.font = [UIFont systemFontOfSize:11];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(present) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = [UIColor grayColor];
    button.layer.cornerRadius = 20;
    button.layer.masksToBounds = YES;
    [HitoApplication addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 40));//设置按钮大小
        make.right.mas_equalTo(0);//距右边边距
        make.bottom.mas_lessThanOrEqualTo(0);//小于或等于
        make.top.mas_greaterThanOrEqualTo(200);//大于或等于
    }];
    
    self.button = button;
    // 手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [button addGestureRecognizer:pan];
}
- (void)present{
    [self skipQQ:@"1154180808"];
}

#pragma mark - 手势
- (void)pan:(UIPanGestureRecognizer *)panGesture{
    //locationInView:获取到的是手指点击屏幕实时的坐标点；
    //translationInView：获取到的是手指移动后，在相对坐标中的偏移量
    
    UIView *button = panGesture.view;
    CGPoint newCenter = CGPointMake([panGesture translationInView:panGesture.view].x + button.center.x - [UIScreen mainScreen].bounds.size.width / 2, [panGesture translationInView:panGesture.view].y + button.center.y - [UIScreen mainScreen].bounds.size.height / 2);
    
    [button mas_updateConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(newCenter).priorityLow();
    }];
    [panGesture setTranslation:CGPointZero inView:panGesture.view];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpService];
    [self setUpTableView];
    [self.dataArr addObjectsFromArray:@[@"Masonry使用",@"指纹解锁",@"网络/本地 视频播放",@"制作会员卡",@"苹果系统自带分享功能",@"苹果自带摇一摇功能",@"Block回调使用",@"AFNetworking网络请求",@"苹果原生定位系统",@"自学PHP后台开发",@"调用相机/相册",@"UIScrollView轮播效果",@"UISegmentedControl分段",@"本地推送",@"二维码扫描",@"物流查询功能",@"FMDB如何使用,收藏功能",@"HTML5交互",@"仿京东地址选择器"]];
    
    
    NSArray *oldArr = @[@"12",@"123",@"123"];
    //去除数组中相同的元素
    NSArray *newArr = [oldArr valueForKeyPath:@"@distinctUnionOfObjects.self"];
    NSLog(@"====%@====",newArr);
    
    NSLog(@"%f,%f",HitoScreenW,HitoScreenH);
    NSLog(@"%f,%f",HitoActureWidth(100),HitoActureHeight(206));

    [self addDropUpRefresh];
    [self addDropDownRefresh];
}


/* cell内容 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellID = @"cellID";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = self.dataArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        //Masonry使用
        HitoAllocInit(MasonryViewController, view);
        view.navigationItem.title = @"Masonry使用";
        [self pushNextViewController:view];
        
    }else if(indexPath.row == 1) {
        //指纹解锁
        HitoAllocInit(touchViewController, view);
        view.navigationItem.title = @"指纹解锁";
        [self pushNextViewController:view];        
    }else if(indexPath.row == 2) {
        //视频播放
        HitoAllocInit(VideoViewController, view);
        view.navigationItem.title = @"视频播放";
        [self pushNextViewController:view];
    }else if(indexPath.row == 3) {
        //会员卡制作
        HitoAllocInit(vipViewController, view);
        view.navigationItem.title = @"会员卡制作";
        [self pushNextViewController:view];        
    }else if(indexPath.row == 4) {
        //苹果系统自带分享功能
        UIActivityViewController *avc = [[UIActivityViewController alloc]initWithActivityItems:@[@"分享内容名称",[NSURL URLWithString:@"https://github.com/NSLog-YuHaitao/iOSReview"]] applicationActivities:nil];
        [self presentViewController:avc animated:YES completion:nil];

    }else if(indexPath.row == 5) {
        //原生摇一摇
        HitoAllocInit(ShakeViewController, view);
        view.navigationItem.title = @"原生摇一摇";
        [self pushNextViewController:view];
        
    }else if(indexPath.row == 6) {
        //Block回调
        HitoAllocInit(BlockViewController, view);
        view.navigationItem.title = @"Block回调";
        view.block = ^(NSString * aa) {
            NSLog(@"===%@===",aa);
        };
        [self pushNextViewController:view];
        
    }else if(indexPath.row == 7) {
        //网络请求
        HitoAllocInit(AFViewController, view);
        view.navigationItem.title = @"网络请求";
        [self pushNextViewController:view];
        
    }else if(indexPath.row == 8) {
        //原生定位
        HitoAllocInit(LocationViewController, view);
        view.navigationItem.title = @"原生定位";
        [self pushNextViewController:view];
    }else if(indexPath.row == 9) {
        //自学php
        HitoAllocInit(ownViewController, view);
        view.navigationItem.title = @"自学php";
        [self pushNextViewController:view];
    }else if(indexPath.row == 10) {
        //相机相册
        HitoAllocInit(photoViewController, view);
        view.navigationItem.title = @"相机相册";
        [self pushNextViewController:view];
    }else if(indexPath.row == 11) {
        HitoAllocInit(YHTScrollView, view);
        view.navigationItem.title = @"轮播图";
        [self pushNextViewController:view];
    }else if(indexPath.row == 12) {
        HitoAllocInit(SegViewController, view);
        [self pushNextViewController:view];
        
    }else if(indexPath.row == 13) {
        HitoAllocInit(LocalpushViewController, view);
        view.navigationItem.title = @"本地推送";
        [self pushNextViewController:view];
        
    }else if(indexPath.row == 14) {
        HitoAllocInit(QRCodeViewController, view);
        view.navigationItem.title = @"二维码扫描";
        [self pushNextViewController:view];
    }else if(indexPath.row == 15) {
        HitoAllocInit(logisticsViewController, view);
        view.navigationItem.title = @"物流查询";
        [self pushNextViewController:view];
    }else if(indexPath.row == 16) {
        HitoAllocInit(DBViewController, view);
        view.navigationItem.title = @"FMDB";
        [self pushNextViewController:view];
    }else if(indexPath.row == 17) {
        HitoAllocInit(HTML5ViewController, view);
        view.navigationItem.title = @"HTML5交互";
        [self pushNextViewController:view];
    }else if(indexPath.row == 18) {
        HitoAllocInit(addressViewController, view);
        view.navigationItem.title = @"仿京东地址选择器";
        [self pushNextViewController:view];
    }
   
}

#pragma mark --下拉刷新
- (void)addDropDownRefresh{
    MJRefreshNormalHeader * header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //下拉刷新
        [self.tableView. mj_header endRefreshing];
    }];
    [header setTitle:@"正在刷新" forState:MJRefreshStateRefreshing];
    [header setTitle:@"松开刷新" forState:MJRefreshStatePulling];
    self.tableView. mj_header = header;
}

#pragma mark -- 上拉加载
- (void)addDropUpRefresh{
    MJRefreshBackNormalFooter * footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        //加载更多方法调用
        [self.tableView. mj_footer endRefreshing];
    }];
    [footer setTitle:@"正在加载" forState:MJRefreshStateRefreshing ];
    [footer setTitle:@"松开加载" forState:MJRefreshStatePulling];
    self.tableView. mj_footer = footer;
}



- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.button setHidden:YES];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.button setHidden:NO];
}

@end
