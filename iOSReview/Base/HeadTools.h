//
//  HeadTools.h
//  Zoedear
//
//  Created by 于海涛 on 2017/4/11.
//  Copyright © 2017年 KennyHito. All rights reserved.
//


/* ----------------------系统--------------------------- */
//获取手机系统的版本
#define HitoSystemVersion [[[UIDevice currentDevice] systemVersion] floatValue]
//是否为iOS7及以上系统
#define HitoiOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)
//是否为iOS8及以上系统
#define HitoiOS8 ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0)
//是否为iOS9及以上系统
#define HitoiOS9 ([[UIDevice currentDevice].systemVersion doubleValue] >= 9.0)
//是否为iOS10及以上系统
#define HitoiOS10 ([[UIDevice currentDevice].systemVersion doubleValue] >= 10.0)


/* ----------------------沙盒路径--------------------------- */
//沙盒路径
#define HitoHomePath NSHomeDirectory()
//获取沙盒 Document
#define HitoPathDocument [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
//获取沙盒 Cache
#define HitoPathCache [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]
//获取沙盒 temp
#define HitoPathTemp NSTemporaryDirectory()


/* ----------------------打印日志--------------------------- */
//输出语句
#ifdef DEBUG
# define NSLog(FORMAT, ...) printf("[%s<%p>行号:%d]:%s\n",__FUNCTION__,self,__LINE__,[[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String])
#else
# define NSLog(FORMAT, ...) 
#endif


/* ----------------------屏幕高度(以及比例)--------------------------- */
//屏幕的宽高
#define HitoScreenW [UIScreen mainScreen].bounds.size.width
#define HitoScreenH [UIScreen mainScreen].bounds.size.height
//屏幕大小
#define HitoScreenSize [UIScreen mainScreen].bounds
//比例宽和高(以6s为除数)
#define HitoActureHeight(height)  roundf(height/375.0 * HitoScreenW)
#define HitoActureWidth(Width)  roundf(Width/667.0 * HitoScreenH)
//导航栏+状态栏的高度
#define HitoNavHeight 64
//分栏高度
#define HitoTabBarHeight 44

/* ----------------------视图,类初始化--------------------------- */
//声明属性
#define HitoProperty(key) @property (nonatomic,strong) NSString * key
#define HitoPropertyDic(key) @property(nonatomic,strong) NSDictionary * key
//获取视图宽高XY等信息
#define HitoviewH(view1) view1.frame.size.height
#define HitoviewW(view1) view1.frame.size.width
#define HitoviewX(view1) view1.frame.origin.x
#define HitoviewY(view1) view1.frame.origin.y
//获取self.view的宽高
#define HitoSelfViewW (self.view.frame.size.width)
#define HitoSelfViewH (self.view.frame.size.height)
///实例化
#define HitoViewAlloc(view,x,y,w,h) [[view alloc]initWithFrame:CGRectMake(x, y, w, h)]
#define HitoAllocInit(Controller,cName) Controller *cName = [[Controller alloc]init]


/* ----------------------图片和颜色--------------------------- */
//默认图片
#define HitoPlaceholderImage [UIImage imageNamed:@"XXX"]
//定义UIImage对象
#define HitoImage(imageName) [UIImage imageNamed:[NSString stringWithFormat:@"%@",imageName]]

///颜色 a代表透明度,1为不透明,0为透明
#define HitoRGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
// rgb颜色转换（16进制->10进制）
#define HitoColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


/* ----------------------通知和本地存储--------------------------- */
//创建通知
#define HitoAddNotification(selectorName,key) [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(selectorName) name:key object:nil];
//发送通知
#define HitoSendNotification(key) [[NSNotificationCenter defaultCenter] postNotificationName:key object:self userInfo:nil];
//移除通知
#define HitoRemoveNotification(key) [[NSNotificationCenter defaultCenter]removeObserver:self name:key object:nil];
//本地化存储
#define HitoUserDefaults(NSUserDefaults,defu) NSUserDefaults * defu = [NSUserDefaults standardUserDefaults];

/* ----------------------其他--------------------------- */
//主窗口
#define HitoApplication [UIApplication sharedApplication].keyWindow
//字符串拼接
#define HitoStringWithFormat(Object) [NSString stringWithFormat:@"%@",Object]
//GCD代码只执行一次
#define HitoDISPATCH_ONCE_BLOCK(onceBlock) static dispatch_once_t onceToken; dispatch_once(&onceToken, onceBlock);
//成功标识
#define HitoSuccess @"success"
//失败标识
#define HitoFailure @"failure"
//登录状态标识
#define HitoSucTitle @"登录成功"
#define HitoFaiTitle @"登录失败"
//网络状态标识
#define HitoFaiNetwork @"网络错误"
