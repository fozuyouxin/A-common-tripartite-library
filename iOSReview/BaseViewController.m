//
//  BaseViewController.m
//  iOSReview
//
//  Created by 于海涛 on 2017/6/22.
//  Copyright © 2017年 KennyHito. All rights reserved.
//
#import "BaseViewController.h"
#import "sys/utsname.h"
#import <AVFoundation/AVAsset.h>
#import <AVFoundation/AVAssetImageGenerator.h>
#import <AVFoundation/AVTime.h>
#warning 需要导入第三方库的头文件
#if 1
#import <MBProgressHUD.h>
#import <AFNetworking.h>
#endif
//主窗口
#define kApplication [UIApplication sharedApplication].keyWindow
//是否为iOS8及以上系统
#define iOS8 ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0)
//是否为iOS9及以上系统
#define iOS9 ([[UIDevice currentDevice].systemVersion doubleValue] >= 9.0)
//是否为iOS10及以上系统
#define iOS10 ([[UIDevice currentDevice].systemVersion doubleValue] >= 10.0)
//成功标识
#define SUCCESS @"success"
//屏幕的宽高
#define SCREENW [UIScreen mainScreen].bounds.size.width
#define SCREENH [UIScreen mainScreen].bounds.size.height

@interface BaseViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation BaseViewController

//单例模式
+ (BaseViewController *) shareBaseViewController{
    static dispatch_once_t onceToken;
    static BaseViewController * base = nil;
    dispatch_once(&onceToken, ^{
        base = [[BaseViewController alloc]init];
    });
    return base;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.interactivePopGestureRecognizer.delegate=(id)self;
    _dataArr = [[NSMutableArray alloc]init];
    //键盘弹出来通知中心
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(showKeyboard:) name:UIKeyboardDidShowNotification object:nil];
    //键盘消失的观察者注册
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(hideKeyboard:) name:UIKeyboardDidHideNotification object:nil];
}
/* 监听键盘是否收起还是弹起*/
-(void)showKeyboard:(NSNotification *)noti{
    NSLog(@"键盘弹出来了");
}
-(void)hideKeyboard:(NSNotification *)noti{
    NSLog(@"键盘收起来了");
}
- (void)dealloc{
    //移除监听
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark 创建tableview
/** 创建tableview */
- (void)setUpTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, SCREENW, SCREENH-64-49) style:UITableViewStyleGrouped];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.tableView];
}
/* 组数 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
/* 行数 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
/* cell内容 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellID = @"cellID";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    
    return cell;
}
/* 组头高度*/
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}
/* 组尾高度 */
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}
/* 刷新数据 */
- (void)reloadTableView{
    [self.tableView reloadData];
}
/* 刷新指定cell */
- (void)reloadCellForRow:(NSInteger)row andSection:(NSInteger)section{
    
    NSIndexPath * indexPath=[NSIndexPath indexPathForRow:row inSection:section];
    NSArray * arr =[NSArray arrayWithObject:indexPath];
    [self.tableView reloadRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationAutomatic];
}
/* UITableView增加分割线 */
-(void)viewDidLayoutSubviews {
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)])  {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
}
/* UITableView增加分割线并且加载cell动画 */
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPat{
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]){
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    /* ⚠️ This's 加载cell动画 */
    //从锚点位置出发，逆时针绕 Y 和 Z 坐标轴旋转90度
    CATransform3D transform3D = CATransform3DMakeRotation(M_PI_2, 0.0, 1.0, 1.0);
    // 定义 cell 的初始状态
    cell.alpha = 0.0;
    cell.layer.transform = transform3D;
    cell.layer.anchorPoint = CGPointMake(0.0, 0.5); // 设置锚点位置；默认为中心
    // 方式二：代码块设置动画
    [UIView animateWithDuration:0.5 animations:^{
        cell.alpha = 1.0;
        cell.layer.transform = CATransform3DIdentity;
        CGRect rect = cell.frame;
        rect.origin.x = 0.0;
        cell.frame = rect;
    }];
}

#pragma mark UINavigationController设置
/* 设置导航栏颜色 */
- (void)setNavBackgroudColor:(UIColor *)color{
    self.navigationController.navigationBar.barTintColor = color;
    UINavigationBar *navigationBar = self.navigationController.navigationBar;
    [navigationBar setTranslucent:NO];
}
/* 设置导航条中间标题 */
- (void)addNavCenterTitle:(NSString *)title andColor:(UIColor *)color andFontSize:(int)size{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 20)];
    label.textColor=color;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:size];
    label.text=title;
    self.navigationItem.titleView = label;
}
/* 设置导航栏左侧图片 */
- (void)addNavLeftBarButtonWithImage:(NSString *)buttonImage{
    UIButton *btn =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [btn setImage:[UIImage imageNamed:buttonImage] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(leftNavClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = leftItem;
}
/* 设置导航栏右侧图片 */
- (void)addNavRightBarButtonWithImage:(NSString *)buttonImage{
    UIButton *btn =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [btn setImage:[UIImage imageNamed:buttonImage] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(rightNavClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *spacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    //这里可以设置距右边的宽度
    spacer.width = 5;
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItems = @[spacer,rightItem];
}
/* 设置导航栏右侧文字 */
- (void)addNavRightBarButtonWithText:(NSString *)text andTextColor:(UIColor *)color{
    UIButton *btn =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    [btn setTitle:text forState:UIControlStateNormal];
    [btn setTitleColor:color forState:UIControlStateNormal];
    //文字靠右显示
    [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [btn addTarget:self action:@selector(rightNavClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *spacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    //这里可以设置距右边的宽度
    spacer.width = -6;
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItems = @[spacer,rightItem];
}
/* 返回上一层 */
- (void)leftNavClick:(UIBarButtonItem *)item{
    [self.navigationController popViewControllerAnimated:YES];
}
/* 点击右侧导航栏按钮 */
- (void)rightNavClick:(UIBarButtonItem *)item{
    NSLog(@"===点击右侧导航栏按钮===");
}
/* 导航栏页面跳转 */
-(void)pushNextViewController:(UIViewController *)controller{
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark 方法封装
/* 数值型数据返回0 */
- (NSString *)isNilOfNumber:(NSString *)string{
    if (string != NULL || [string stringByReplacingOccurrencesOfString:@" " withString:@""].length > 0 || [string isEqualToString:@"0"] ||[string isEqualToString:@"0.00"]) {
        NSString * str = [NSString stringWithFormat:@"%@",string];
        return str;
    }else{
        return @"0";
    }
}
/* 字符型数据返回空 */
- (NSString *)isNilOfString:(NSString *)string{
    if (string != NULL || [string stringByReplacingOccurrencesOfString:@" " withString:@""].length > 0 || [string isEqualToString:@"0"] ||[string isEqualToString:@"0.00"]) {
        NSString * str = [NSString stringWithFormat:@"%@",string];
        return str;
    }else{
        return @"";
    }
}
/* 移除字符串中的空格和换行 */
- (NSString *)removeSpaceAndNewline:(NSString *)str {
    NSString *temp = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    temp = [temp stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    temp = [temp stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    return temp;
}
/*判断字符串中是否有空格*/
- (BOOL)isBlank:(NSString *)str {
    NSRange _range = [str rangeOfString:@" "];
    if (_range.location != NSNotFound) {
        //有空格
        return YES;
    } else {
        //没有空格
        return NO;
    }
}
/* 跳转appStore页面 */
//例如NSString * MyID = @"1173184488";
- (void)skipAppStoreWithID:(NSString *)MyID{
    
    NSString *str = [NSString stringWithFormat:@"https://itunes.apple.com/cn/app/id%@?mt=8",MyID];
    NSURL * urlStr = [NSURL URLWithString:str];
    
    if ([[UIApplication sharedApplication] canOpenURL:urlStr]) {
        //打开url
        //iOS10.0 以后被废弃
        if (iOS10) {
            [[UIApplication sharedApplication]openURL:urlStr options:@{} completionHandler:nil];
        }else{
            [[UIApplication sharedApplication]openURL:urlStr];
        }
        
    }else {
        [self showAlertMessage:@"不好意思,打不开!"];
    }
}

/* UIAlertView提示框 */
- (void)showAlertMessage:(NSString *)message{
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}

/* UIAlertController提示框 */
- (void)alertTitle:(NSString *)title andMessage:(NSString *)message andAction1:(NSString *)cancelActionStr andAction2:(NSString *)rubbishActionStr andBlock:(alertBlock)block{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    //取消style:UIAlertActionStyleDefault
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelActionStr style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:cancelAction];
    
    //简直废话:style:UIAlertActionStyleDestructive
    UIAlertAction *rubbishAction = [UIAlertAction actionWithTitle:rubbishActionStr style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        block(SUCCESS);
    }];
    [alertController addAction:rubbishAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

/* 判断手机号是否合法 */
- (BOOL)valiMobile:(NSString *)mobile{
    mobile = [mobile stringByReplacingOccurrencesOfString:@" "withString:@""];
    if(mobile.length !=11){
        return NO;
    }else{
        /*移动号段正则表达式*/
        NSString *CM_NUM =@"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
        /*联通号段正则表达式*/
        NSString *CU_NUM =@"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
        /*电信号段正则表达式*/
        NSString *CT_NUM =@"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        BOOL isMatch1 = [pred1 evaluateWithObject:mobile];
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        BOOL isMatch2 = [pred2 evaluateWithObject:mobile];
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        BOOL isMatch3 = [pred3 evaluateWithObject:mobile];
        if(isMatch1 || isMatch2 || isMatch3) {
            return YES;
        }else{
            return NO;
        }
    }
}
/* 判断注册邮箱是否正确 */
- (BOOL)isAvailableEmail:(NSString *)email {
    NSString *emailRegex =@"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

/* 判断字符串是否全部为数字 */
- (BOOL)isAllNum:(NSString *)string{
    unichar c;
    for(int i=0; i<string.length;i++){
        c=[string characterAtIndex:i];
        if(!isdigit(c)) {
            return NO;
        }
    }
    return YES;
}

/* 校验身份证号码(老的15位,新的18位) */
- (BOOL)isAllIDcard:(NSString *)card{
    //15位
    NSString* number1=@"^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$";
    NSPredicate * numberPre1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",number1];
    BOOL isOK1 = [numberPre1 evaluateWithObject:card];
    
    //18位
    NSString* number2=@"^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}([0-9]|X)$";
    NSPredicate * numberPre2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",number2];
    BOOL isOK2 = [numberPre2 evaluateWithObject:card];
    if(isOK1 || isOK2) {
        return YES;
    }
    return NO;
}

/* 获取字符串(或汉字)首字母 */
- (NSString *)firstCharacterWithString:(NSString *)string{
    NSMutableString *str = [NSMutableString stringWithString:string];
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformMandarinLatin,NO);
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformStripDiacritics,NO);
    NSString *pingyin = [str capitalizedString];
    return [pingyin substringToIndex:1];
}

- (void)skipQQ:(NSString *)name{
    //用来接收临时消息的客服QQ号码(注意此QQ号需开通QQ推广功能,否则陌生人向他发送消息会失败)
    //调用QQ客户端,发起QQ临时会话
    [self openFuncCommd:[NSString stringWithFormat:@"mqq://im/chat?chat_type=wpa&uin=%@&version=1&src_type=web",name]];
}

/* 跳转的打开方法 */
- (void)openFuncCommd:(NSString *)str{
    //NSString转NSURL
    NSURL* url = [NSURL URLWithString:str];
    //当前程序
    UIApplication* app = [UIApplication sharedApplication];
    //判断
    if([app canOpenURL:url]) {
        if (iOS10) {
            [app openURL:url options:@{} completionHandler:nil];
        }else{
            [app openURL:url];
        }
    }else{
        [self showAlertMessage:@"没有此功能或者该功能不可用!"];
    }
}
/* 获取当前时间的时间戳 */
- (NSString *)getCurrentTimeNumber{
    NSDate * date = [NSDate date];
    NSString * currentTime = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]];
    return currentTime;
}
/* 时间戳转字符串日期,不包含具体时间 */
/* 大写H代表24小时制,小写h代表12小时制 */
- (NSString *)timeSwitchString:(NSString *)time{
    NSInteger intStr3 = [time integerValue];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:intStr3];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc]init];
    //设置获取时间的格式
    [dateformatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString * locationString=[NSString stringWithFormat:@"%@",[self isNilOfString:[dateformatter stringFromDate:confromTimesp]]];
    return locationString;
}
/* 获取appStore上的版本号 */
- (NSString *)getVersionNumber:(NSString *)MyID{
    NSString *newVersion;
    //这个URL地址是该app在iTunes connect里面的相关配置信息。
    //其中id是该app在app store唯一的ID编号。
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://itunes.apple.com/cn/lookup?id=%@",MyID]];
    NSString *jsonResponseString = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    NSData *data = [jsonResponseString dataUsingEncoding:NSUTF8StringEncoding];
    //解析json数据
    id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSArray *array = json[@"results"];
    for (NSDictionary *dic in array) {
        newVersion = [dic valueForKey:@"version"];
        //NSLog(@"%@",newVersion);
        return newVersion;
    }
    return nil;
}
/* 压缩图片的方法(2种方式) */
//方法一:压缩图片
- (UIImage*)imageWithImageSimple:(UIImage*)images scaledToSize:(CGSize)newSize{
    UIGraphicsBeginImageContext(newSize);
    [images drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
//方法二:压缩图片
- (UIImage *)thumbnailFromImage:(UIImage*)image{
    CGSize originImageSize = image.size;
    CGRect newRect = CGRectMake(0, 0, 100, 100);
    UIGraphicsBeginImageContextWithOptions(newRect.size, NO, 0.0);
    //(原图的宽高做分母,导致大的结果比例更小,做MAX后,ratio*原图长宽得到的值最小是40,最大则比40大,这样的好处是可以让原图在画进40*40的缩略矩形画布时,origin可以取=(缩略矩形长宽减原图长宽*ratio)/2 ,这样可以得到一个可能包含负数的origin,结合缩放的原图长宽size之后,最终原图缩小后的缩略图中央刚好可以对准缩略矩形画布中央)
    float rotio = MAX(newRect.size.width/originImageSize.width, newRect.size.height/originImageSize.height);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:newRect cornerRadius:5.0];
    //剪裁上下文
    [path addClip];
    //让image在缩略图居中()
    CGRect projectRect;
    projectRect.size.width = originImageSize.width* rotio;
    projectRect.size.height = originImageSize.height * rotio;
    projectRect.origin.x= (newRect.size.width- projectRect.size.width) /2;
    projectRect.origin.y= (newRect.size.height- projectRect.size.height) /2;
    //在上下文画图
    [image drawInRect:projectRect];
    UIImage *thumnailImg = UIGraphicsGetImageFromCurrentImageContext();
    //结束绘制图
    UIGraphicsEndImageContext();
    return thumnailImg;
}
/* 返回多少M*/
- (NSString * )showCache{
    return [NSString stringWithFormat:@"%0.2fM",[self folderSizeAtPath:[NSString stringWithFormat:@"%@/Library/Caches",NSHomeDirectory()]]];
}
/* 清除缓存 */
-(void)clearCache{
    
    [self alertTitle:@"温馨提示" andMessage:@"确定删除所有缓存?" andAction1:@"取消" andAction2:@"确定" andBlock:^(NSString *alertMessage) {
        if ([alertMessage isEqualToString:SUCCESS]) {
            [self clearCacheFromPath:[NSString stringWithFormat:@"%@/Library/Caches",NSHomeDirectory()]];
        }
    }];
    
}
/* 返回缓存的大小 */
- (long long) fileSizeAtPath:(NSString*) filePath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}
/* 遍历文件夹获得文件夹大小 */
- (float ) folderSizeAtPath:(NSString*) folderPath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath])
        return 0;
    //通过枚举遍历法遍历文件夹中的所有文件
    //创建枚举遍历器
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    //首先声明文件名称、文件大小
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        //得到当前遍历文件的路径
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        //调用封装好的获取单个文件大小的方法
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    return folderSize/(1024.0*1024.0);//转换为多少M进行返回
}
/* 清除缓存大小 打印NSHomeDritiony前往Documents进行查看路径*/
- (void)clearCacheFromPath:(NSString*)path{
    //建立文件管理器
    NSFileManager * manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:path]) {
        //如果文件路径存在 获取其中所有文件
        NSArray * fileArr = [manager subpathsAtPath:path];//找到所有子文件的路径，存到数组中。
        //首先需要转化为完整路径
        //直接删除所有子文件
        for (int i = 0; i < fileArr.count; i++) {
            NSString * fileName = fileArr[i];
            //完整路径
            NSString * filePath = [path stringByAppendingPathComponent:fileName];
            [manager removeItemAtPath:filePath error:nil];
        }
    }
}
/* 保存图片的方法 */
- (void)savePicture:(UIImage *)image{
   UIImageWriteToSavedPhotosAlbum(image, self, @selector(imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:), nil);
}
- (void)imageSavedToPhotosAlbum:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    if (!error) {
        [self showMessageTitle:@"图片保存成功!" andDelay:2];
    }else{
        NSLog(@"%@",error.localizedDescription);
    }
}

/* 颜色转图片 */
- (UIImage *)colorSwitchImageWidth:(float)imageWidth andImageHeight:(float)imageHeight andColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f,imageWidth, imageHeight);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
/* 随机颜色 */
- (UIColor *)RandomColor {
    NSInteger aRedValue = arc4random() % 255;
    NSInteger aGreenValue = arc4random() % 255;
    NSInteger aBlueValue = arc4random() % 255;
    UIColor *randColor = [UIColor colorWithRed:aRedValue / 255.0f green:aGreenValue / 255.0f blue:aBlueValue / 255.0f alpha:1.0f];
    return randColor;
}
/** 是否支持自动转屏 */
- (BOOL)shouldAutorotate {
    return NO;
}
/** 支持哪些屏幕方向 */
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight;
}
/** 默认的屏幕方向（当前ViewController必须是通过模态出来的UIViewController（模态带导航的无效）方式展现出来的，才会调用这个方法） */
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationLandscapeLeft | UIInterfaceOrientationLandscapeRight;
}
/* 拿到当前正在显示的控制器，不管是push进去的，还是present进去的都能拿到 */
- (UIViewController *)getVisibleViewControllerFrom:(UIViewController*)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self getVisibleViewControllerFrom:[((UINavigationController*) vc) visibleViewController]];
    }else if ([vc isKindOfClass:[UITabBarController class]]){
        return [self getVisibleViewControllerFrom:[((UITabBarController*) vc) selectedViewController]];
    } else {
        if (vc.presentedViewController) {
            return [self getVisibleViewControllerFrom:vc.presentedViewController];
        } else {
            return vc;
        }
    }
}
/* 可以将彩色图片变成黑白图片,获得灰度图*/
- (UIImage*)covertToGrayImageFromImage:(UIImage*)sourceImage{
    int width = sourceImage.size.width;
    int height = sourceImage.size.height;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    CGContextRef context = CGBitmapContextCreate (nil,width,height,8,0,colorSpace,kCGImageAlphaNone);
    CGColorSpaceRelease(colorSpace);
    
    if (context == NULL) {
        return nil;
    }
    
    CGContextDrawImage(context,CGRectMake(0, 0, width, height), sourceImage.CGImage);
    CGImageRef contextRef = CGBitmapContextCreateImage(context);
    UIImage *grayImage = [UIImage imageWithCGImage:contextRef];
    CGContextRelease(context);
    CGImageRelease(contextRef);
    
    return grayImage;
}
/* 获取手机型号 */
- (NSString *)getDeviceInfo {
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 2G";
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G";
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS";
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S";
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5c";
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c";
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5s";
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s";
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus";
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6";
    if ([platform isEqualToString:@"iPhone8,1"]) return @"iPhone 6s";
    if ([platform isEqualToString:@"iPhone8,2"]) return @"iPhone 6s Plus";
    // 日行两款手机型号均为日本独占，可能使用索尼FeliCa支付方案而不是苹果支付
    if ([platform isEqualToString:@"iPhone9,1"])    return @"国行、日版、港行iPhone 7";
    if ([platform isEqualToString:@"iPhone9,2"])    return @"港行、国行iPhone 7 Plus";
    if ([platform isEqualToString:@"iPhone9,3"])    return @"美版、台版iPhone 7";
    if ([platform isEqualToString:@"iPhone9,4"])    return @"美版、台版iPhone 7 Plus";
    if ([platform isEqualToString:@"iPhone8,4"]) return @"iPhone SE";
    if ([platform isEqualToString:@"iPod1,1"]) return @"iPod Touch 1G";
    if ([platform isEqualToString:@"iPod2,1"]) return @"iPod Touch 2G";
    if ([platform isEqualToString:@"iPod3,1"]) return @"iPod Touch 3G";
    if ([platform isEqualToString:@"iPod4,1"]) return @"iPod Touch 4G";
    if ([platform isEqualToString:@"iPod5,1"]) return @"iPod Touch 5G";
    if ([platform isEqualToString:@"iPad1,1"]) return @"iPad 1G";
    if ([platform isEqualToString:@"iPad2,1"]) return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,2"]) return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,3"]) return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,4"]) return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,5"]) return @"iPad Mini 1G";
    if ([platform isEqualToString:@"iPad2,6"]) return @"iPad Mini 1G";
    if ([platform isEqualToString:@"iPad2,7"]) return @"iPad Mini 1G";
    if ([platform isEqualToString:@"iPad3,1"]) return @"iPad 3";
    if ([platform isEqualToString:@"iPad3,2"]) return @"iPad 3";
    if ([platform isEqualToString:@"iPad3,3"]) return @"iPad 3";
    if ([platform isEqualToString:@"iPad3,4"]) return @"iPad 4";
    if ([platform isEqualToString:@"iPad3,5"]) return @"iPad 4";
    if ([platform isEqualToString:@"iPad3,6"]) return @"iPad 4";
    if ([platform isEqualToString:@"iPad4,1"]) return @"iPad Air";
    if ([platform isEqualToString:@"iPad4,2"]) return @"iPad Air";
    if ([platform isEqualToString:@"iPad4,3"]) return @"iPad Air";
    if ([platform isEqualToString:@"iPad4,4"]) return @"iPad Mini 2G";
    if ([platform isEqualToString:@"iPad4,5"]) return @"iPad Mini 2G";
    if ([platform isEqualToString:@"iPad4,6"]) return @"iPad Mini 2G";
    if ([platform isEqualToString:@"i386"]) return @"iPhone Simulator";
    if ([platform isEqualToString:@"x86_64"]) return @"iPhone Simulator";
    return platform;
}
/* 获取本地视频的第一帧图片 */
- (UIImage *)getVideoFirstImage:(NSString *)filepath{
    AVURLAsset *asset = [[AVURLAsset alloc]initWithURL:[NSURL fileURLWithPath:filepath] options:nil];
    AVAssetImageGenerator *assetGen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    assetGen.appliesPreferredTrackTransform = YES;
    CMTime time = CMTimeMakeWithSeconds(0, 600);
    NSError *error = nil;
    CMTime actualTime;
    CGImageRef image = [assetGen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    UIImage *videoImage = [[UIImage alloc] initWithCGImage:image];
    CGImageRelease(image);
    return videoImage;
}

#pragma mark 控件封装
/* UIView封装
 * isCircle 是否圆角;
 * isShadow 是否阴影,设置为YES时,需要设置shadowColor属性;
 * shadowColor 阴影颜色;
 */
- (UIView *)createUIViewFrame:(CGRect)rect andBackgroudColor:(UIColor *)BackgroudColor  andCircle:(BOOL)isCircle andShadow:(BOOL)isShadow andShadowColor:(UIColor *)shadowColor{
    UIView * view = [[UIView alloc]initWithFrame:rect];
    view.backgroundColor = BackgroudColor;
    if (isCircle) {
        view.layer.cornerRadius = CGRectGetHeight(view.frame)/2;
    }
    if (isShadow) {
        view.layer.shadowColor = shadowColor.CGColor;
        view.layer.shadowOpacity = 0.8f;
        view.layer.shadowRadius = 4.f;
        view.layer.shadowOffset = CGSizeMake(4,4);
    }
    return view;
}

/* UIButton封装 */
- (UIButton *)createButtonTitle:(NSString *)title andFont:(int)size andTitleColor:(UIColor *)titleColor andBackColor:(UIColor *)backColor andTag:(int)tag andFrame:(CGRect)frame{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:size]];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.tag = tag;
    [btn setFrame:frame];
    [btn.layer setMasksToBounds:YES];
    [btn.layer setCornerRadius:4.0];
    btn.backgroundColor = backColor;
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}
- (void)btnClick:(UIButton *)btn{
    NSLog(@"---按钮点击事件!---");
}
/* UITextField封装 */
- (UITextField *)createTextFieldPlaceholderTitle:(NSString *)placeholderTitle andFont:(int)size andTitleColor:(UIColor *)titleColor andTag:(int)tag andFrame:(CGRect)frame andSecureTextEntry:(BOOL)secureTextEntry{
    
    UITextField * textF = [[UITextField alloc]initWithFrame:frame];
    textF.tag = tag;
    textF.textColor = titleColor;
    textF.font = [UIFont systemFontOfSize:size];
    textF.placeholder = placeholderTitle;
    textF.borderStyle = UITextBorderStyleRoundedRect;
    textF.clearButtonMode = YES;
    //注:这里使用secureTextEntry为YES,键盘输入不能输入汉字
    textF.keyboardType = UIKeyboardTypeDefault;
    textF.secureTextEntry = secureTextEntry;
    self.textF = textF;
    return self.textF;
}
/* UILabel封装 */
- (UILabel *)createLabelTitle:(NSString *)title andFont:(int)size andTitleColor:(UIColor *)titleColor andBackColor:(UIColor *)backColor andTag:(int)tag andFrame:(CGRect)frame andTextAlignment:(NSTextAlignment)align{
    UILabel * label = [[UILabel alloc]initWithFrame:frame];
    label.text = title;
    label.font = [UIFont systemFontOfSize:size];
    label.textColor = titleColor;
    label.backgroundColor = backColor;
    label.tag = tag;
    label.textAlignment = align;
    return label;
}
/* UILabel设置不同字体颜色 */
- (void)colorLabel:(UILabel *)lab andFont:(int)font andRange:(NSRange)range andColor:(UIColor *)color{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:lab.text];
    //设置字号
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:font] range:range];
    //设置文字颜色
    [str addAttribute:NSForegroundColorAttributeName value:color range:range];
    lab.attributedText = str;
}
/* 设置UILabel的高度 */
- (CGSize)sizeWithString:(NSString *)string size:(CGSize)size andFont:(int)font{
    //限制最大的宽度和高度
    CGRect rect = [string boundingRectWithSize:size options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading  |NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:font]}context:nil];
    return rect.size;
}

#pragma mark 三方库的封装
#warning 需要导入第三方库的头文件
/*
 #import <MBProgressHUD.h>
 #import <AFNetworking.h>
 */
#if 1
/* MBProgressHUD提示框 */
/*含有时间,文字提示框  适合一行提示语! */
- (void)showMessageTitle:(NSString *)title andDelay:(int)timeInt{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    hud.userInteractionEnabled = YES;
    hud.backgroundColor = [UIColor clearColor];
    hud.animationType = MBProgressHUDAnimationZoomOut;
    hud.labelText = title;
    hud.square = NO;
    hud.mode = MBProgressHUDModeText;
    [hud hide:YES afterDelay:timeInt];
}
/* 正在加载 */
- (void)showMessage{
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    HUD.labelText = @"正在加载";
    HUD.mode = MBProgressHUDModeDeterminate;
    [HUD showAnimated:YES whileExecutingBlock:^{
        float progress = 0.0f;
        while (progress < 1.0f) {
            progress += 0.01f;
            HUD.progress = progress;
            usleep(500000);
        }
    } completionBlock:^{
        [HUD removeFromSuperview];
    }];
}
/* 含有时间,文字,图片提示框 适合多行文字提示*/
/* 可以更改文字大小和更改图片的大小 */
- (void)showMessageTitle:(NSString *)title andDelay:(int)timeInt andImage:(NSString *)imageStr{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    hud.userInteractionEnabled = YES;
    hud.backgroundColor = [UIColor clearColor];
    hud.animationType = MBProgressHUDAnimationZoomOut;
    hud.detailsLabelText = title;//设置提示文字
    hud.detailsLabelFont = [UIFont systemFontOfSize:15];//可以更改文字大小
    hud.square = NO;
    hud.mode = MBProgressHUDModeCustomView;
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];//可以更改图片的大小
    imageView.image = [UIImage imageNamed:imageStr];
    hud.customView = imageView;
    [hud hide:YES afterDelay:timeInt];
}

/* 网络请求 */
- (void)getRequestWithUrl:(NSString *)url andParameter:(NSDictionary *)parameter andReturnBlock:(Myblock)block{

    [self showMessage];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json", nil];
    
    //get请求
    [manager GET:url parameters:parameter progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [MBProgressHUD hideHUDForView:kApplication animated:YES];
        //成功
        block(responseObject,nil);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [MBProgressHUD hideHUDForView:kApplication animated:YES];
        //失败
        block(nil,error);
    }];
}

- (void)postRequestWithUrl:(NSString *)url andParameter:(NSDictionary *)parameter andReturnBlock:(Myblock)block{

    [self showMessage];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json", nil];
    
    //get请求
    [manager POST:url parameters:parameter progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideHUDForView:kApplication animated:YES];
        //成功
        block(responseObject,nil);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideHUDForView:kApplication animated:YES];
        //失败
        block(nil,error);
    }];
}
#endif

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.textF resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
