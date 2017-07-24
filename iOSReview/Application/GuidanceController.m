//
//  GuidanceController.m
//  LoveLimiteFree
//
//  Created by KennyHito on 16-5-11.
//  Copyright (c) 2016年 YuHaitao. All rights reserved.
//

#import "GuidanceController.h"

//屏幕宽
#define SCREEN_W [UIScreen mainScreen].bounds.size.width
//屏幕高
#define SCREEN_H [UIScreen mainScreen].bounds.size.height
//屏幕大小
#define SCREEN_SIZE [UIScreen mainScreen].bounds

@interface GuidanceController ()<UIScrollViewDelegate>

@property(nonatomic,strong)UIScrollView * scrollView;
@property(nonatomic,strong)NSMutableArray * imagesArr;
@property(nonatomic,copy)MyBlock block;
@property(nonatomic,strong)UIPageControl * pageControl;


@end

@implementation GuidanceController

#pragma mark -- 自定义构造方法
- (instancetype)initWithImages:(NSArray *)images andBlock:(MyBlock)block{
    self = [super init];
    if (self) {
        //接收从外部传入的数据
        _imagesArr = [NSMutableArray arrayWithArray:images];
        _block = block;
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createScrollView];

    [self addSubViewsOfScrollView];
    
    //设置状态栏隐藏
    [UIApplication sharedApplication].statusBarHidden = YES;
    
}

#pragma mark -- create scrollView

- (void)createScrollView{
    //1.创建ScrollView
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H)];
    
    //设置大小
    _scrollView.contentSize = CGSizeMake(SCREEN_W * _imagesArr.count, SCREEN_H);
    
    //设置代理
    _scrollView.delegate = self;
    
    //开启翻页模式
    _scrollView.pagingEnabled = YES;
    
    //防止自动下滑
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view addSubview:_scrollView];
    
    
    _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(SCREEN_W/2-50, SCREEN_H-150, 100, 20)];
    
    _pageControl.currentPage = 0;
    
    _pageControl.numberOfPages = 3;
    
    _pageControl.pageIndicatorTintColor = [UIColor yellowColor];
    
    _pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
    
    [self.view addSubview:_pageControl];
}

#pragma mark -- scrollView add subViews

- (void)addSubViewsOfScrollView{
    //添加imagesView展示图片,添加button
    //imageView 和 label 在某些情况下添加button,点击button没有任何效果
    //所以,将button添加到ScrollView上,可显示范围的最后一页,在imageView之上
    
    //1.添加ScrollView上的图片
    for (int  i = 0; i < _imagesArr.count; i++) {
        UIImageView * imageV = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_W * i,0, SCREEN_W, SCREEN_H)];
        
        imageV.image = [UIImage imageNamed:_imagesArr[i]];
        
        [_scrollView addSubview:imageV];
    }
    
    //2.添加button
    //将button放到ScrollView的最后一个图片上面
    //所以:宽 = (count-1个屏幕宽)+(一个屏幕宽减去button宽 再除以2);
    //高 = (屏幕高)- button的高 再除以2
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake((SCREEN_W - 150)/2.0 + SCREEN_W * (_imagesArr.count - 1), SCREEN_H - 100, 150, 60)];
    
    [btn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    btn.backgroundColor = [UIColor orangeColor];
    btn.layer.borderWidth = 2;
    btn.layer.borderColor = [UIColor orangeColor].CGColor;
    btn.layer.cornerRadius = 8;
    
    //超出部分剪裁掉
    btn.layer.masksToBounds = YES;
    
    [btn setTitle:@"开始体验" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [_scrollView addSubview:btn];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    NSInteger pageIndex = scrollView.contentOffset.x/SCREEN_W;
    
    //指示按钮显示在第几页
    _pageControl.currentPage =pageIndex;
    
}


#pragma mark --button单击事件
- (void)btnClick:(UIButton *)btn{
    //1.修改本地关于是否安装的标记
    //使用用户偏好设置
    NSUserDefaults * userDf = [NSUserDefaults standardUserDefaults];
    
    //IS_INSTALL标记上
    [userDf setInteger:1 forKey:@"IS_INSTALL"];
    //写入本地硬盘上
    [userDf synchronize];
    
    //还原状态栏
    [UIApplication sharedApplication].statusBarHidden = NO;
    
    //2.回调block 切换根视图
    _block();
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
