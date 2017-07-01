//
//  BaseViewController.h
//  iOSReview
//
//  Created by 于海涛 on 2017/6/22.
//  Copyright © 2017年 KennyHito. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

typedef void (^ Myblock)(NSData *data, NSError *error);//网络请求
typedef void (^ alertBlock)(NSString * alertMessage);//UIAlertController

@property (nonatomic,strong)UITableView *tableView;//列表
@property (nonatomic,strong)NSMutableArray *dataArr;//数据源
@property (nonatomic,strong)UITextField * textF;//文本框

#pragma mark UITableView
/* 创建tableview */
- (void)setUpTableView;
/* 刷新tableview */
- (void)reloadTableView;
/* 刷新指定cell */
- (void)reloadCellForRow:(NSInteger)row andSection:(NSInteger)section;

#pragma mark UINavigationController设置
/* 设置导航栏颜色 */
- (void)setNavBackgroudColor:(UIColor *)color;
/* 设置导航条中间标题 */
- (void)addNavCenterTitle:(NSString *)title andColor:(UIColor *)color andFontSize:(int)size;
/* 设置导航栏左侧图片 */
- (void)addNavLeftBarButtonWithImage:(NSString *)buttonImage;
/* 设置导航栏右侧图片 */
- (void)addNavRightBarButtonWithImage:(NSString *)buttonImage;
/* 设置导航栏右侧文字 */
- (void)addNavRightBarButtonWithText:(NSString *)text andTextColor:(UIColor *)color;
/* 导航栏页面跳转 */
- (void)pushNextViewController:(UIViewController *)controller;

#pragma mark 常用方法封装
/* 数值型数据返回0 */
- (NSString *)isNilOfNumber:(NSString *)string;
/* 字符型数据返回空 */
- (NSString *)isNilOfString:(NSString *)string;
/* 跳转appStore页面 */
- (void)skipAppStoreWithID:(NSString *)MyID;
/* UIAlertView提示框 */
- (void)showAlertMessage:(NSString *)message;
/* UIAlertController提示框 */
- (void)alertTitle:(NSString *)title andMessage:(NSString *)message andAction1:(NSString *)cancelActionStr andAction2:(NSString *)rubbishActionStr andBlock:(alertBlock)block;
/* 判断手机号是否合法 */
- (BOOL)valiMobile:(NSString *)mobile;
/* 判断注册邮箱是否正确 */
- (BOOL)isAvailableEmail:(NSString *)email;
/* 判断字符串是否全部为数字 */
- (BOOL)isAllNum:(NSString *)string;
/* 校验身份证号码(老的15位,新的18位) */
- (BOOL)isAllIDcard:(NSString *)card;
/* 获取字符串(或汉字)首字母 */
- (NSString *)firstCharacterWithString:(NSString *)string;
/* 跳转的打开方法 */
- (void)openFuncCommd:(NSString*)str;
/* 跳转QQ客服 */
- (void)skipQQ:(NSString *)name;
/* 获取当前时间的时间戳 */
- (NSString *)getCurrentTimeNumber;
/* 时间戳转字符串日期 */
- (NSString *)timeSwitchString:(NSString *)time;
/* 获取appStore上的版本号 */
- (NSString *)getVersionNumber:(NSString *)MyID;
/* 压缩图片的方法(2种方式) */
//方法一:压缩图片
- (UIImage*)imageWithImageSimple:(UIImage*)images scaledToSize:(CGSize)newSize;
//方法二:压缩图片
- (UIImage *)thumbnailFromImage:(UIImage*)image;
/* 显示缓存大小,返回多少M */
- (NSString * )showCache;
/* 清除缓存 */
- (void)clearCache;
/* 保存图片的方法 */
- (void)savePicture:(UIImage *)image;

#pragma mark 控件封装
/* UIView封装
 * isCircle 是否圆角;
 * isShadow 是否阴影,设置为YES时,需要设置shadowColor属性;
 * shadowColor 阴影颜色;
 */
- (UIView *)createUIViewFrame:(CGRect)rect andBackgroudColor:(UIColor *)BackgroudColor  andCircle:(BOOL)isCircle andShadow:(BOOL)isShadow andShadowColor:(UIColor *)shadowColor;
/* UIButton封装 */
- (UIButton *)createButtonTitle:(NSString *)title andFont:(int)size andTitleColor:(UIColor *)titleColor andBackColor:(UIColor *)backColor andTag:(int)tag andFrame:(CGRect)frame;
/* UITextField封装 */
- (UITextField *)createTextFieldPlaceholderTitle:(NSString *)placeholderTitle andFont:(int)size andTitleColor:(UIColor *)titleColor andTag:(int)tag andFrame:(CGRect)frame andSecureTextEntry:(BOOL)secureTextEntry;
/* UILabel封装 */
- (UILabel *)createLabelTitle:(NSString *)title andFont:(int)size andTitleColor:(UIColor *)titleColor andBackColor:(UIColor *)backColor andTag:(int)tag andFrame:(CGRect)frame andTextAlignment:(NSTextAlignment)align;
/* UILabel设置不同字体颜色 */
- (void)colorLabel:(UILabel *)lab andFont:(int)font andRange:(NSRange)range andColor:(UIColor *)color;
/* 设置UILabel的高度 */
- (CGSize)sizeWithString:(NSString *)string size:(CGSize)size andFont:(int)size;

#pragma mark 三方库的封装
#if 1
/*含有时间,文字提示框  适合一行提示语! */
- (void)showMessageTitle:(NSString *)title andDelay:(int)timeInt;
/* 正在加载提示框 */
- (void)showMessage;
/* 含有时间,文字,图片提示框 适合多行文字提示*/
/* 可以更改文字大小和更改图片的大小 */
- (void)showMessageTitle:(NSString *)title andDelay:(int)timeInt andImage:(NSString *)imageStr;
- (void)getRequestWithUrl:(NSString *)url andParameter:(NSDictionary *)parameter andReturnBlock:(Myblock)block;
- (void)postRequestWithUrl:(NSString *)url andParameter:(NSDictionary *)parameter andReturnBlock:(Myblock)block;
#endif


@end
