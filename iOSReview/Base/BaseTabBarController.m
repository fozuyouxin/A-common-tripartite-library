//
//  BaseTabBarController.m
//  iOSReview
//
//  Created by Apple on 2017/7/19.
//  Copyright © 2017年 KennyHito. All rights reserved.
//

#import "BaseTabBarController.h"

@interface BaseTabBarController ()

@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (instancetype)init{
    self = [super init];
    if (self) {
        [self setUpChildViewControllers];
    }
    return self;
}

- (void)setUpChildViewControllers{
    
    [self addChildViewController:[[HomeViewController alloc]init] image:@"tab_home_nor" seletedImage:@"tab_home_press" title:@"首页"];
    [self addChildViewController:[[CategoryViewController alloc]init] image:@"tab_classify_nor" seletedImage:@"tab_classify_press" title:@"分类"];
    [self addChildViewController:[[CommunityViewController alloc]init] image:@"tab_community_nor" seletedImage:@"tab_community_press" title:@"社区"];
    [self addChildViewController:[[MeViewController alloc]init] image:@"tab_me_nor" seletedImage:@"tab_me_press" title:@"我的"];
}

//添加子控制器
- (UIViewController *)addChildViewController:(UIViewController *)childController image:(NSString *)image seletedImage:(NSString *)selectedImage title:(NSString *)title {
    
    childController.title = title;
    // 设置图片
    [childController.tabBarItem setImage:[[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [childController.tabBarItem setSelectedImage:[[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
    
    // 导航条
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:childController];
    
    [self addChildViewController:nav];
    
    return childController;
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
