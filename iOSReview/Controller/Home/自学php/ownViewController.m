//
//  ownViewController.m
//  Summarize
//
//  Created by 于海涛 on 2017/5/26.
//  Copyright © 2017年 于海涛. All rights reserved.
//
#pragma mark -- 自学php并且返回数据

#define rgba_r(r,a) [UIColor colorWithRed:r/255.0f green:r/255.0f blue:r/255.0f alpha:a]
#import "ownViewController.h"
#import "phpModel.h"

@interface ownViewController ()

@property (nonatomic,strong) UITextField *text1;
@property (nonatomic,strong) UITextField *text2;
@property (nonatomic,strong) UITextField *text3;
@property (nonatomic,strong) UILabel *showLab;
@property (nonatomic,strong) NSMutableArray * dataArr;//数据源
@property (nonatomic,strong) phpModel * model;

@end

@implementation ownViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.dataArr = [[NSMutableArray alloc]init];
    [self setUI];
}

/* 含有时间,文字,图片提示框 */
- (void)showMessageTitle:(NSString *)title andDelay:(int)timeInt andImage:(NSString *)imageStr{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    hud.userInteractionEnabled = YES;
    hud.backgroundColor = [UIColor clearColor];
    hud.animationType = MBProgressHUDAnimationZoomOut;
    hud.detailsLabelText = title;
    hud.square = NO;
    hud.mode = MBProgressHUDModeCustomView;
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    imageView.image = [UIImage imageNamed:imageStr];
    hud.customView = imageView;
    [hud hide:YES afterDelay:timeInt];
}

/* 含有时间,文字提示框 */
- (void)showMessageTitle:(NSString *)title andDelay:(int)timeInt{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    hud.userInteractionEnabled = YES;
    hud.backgroundColor = [UIColor clearColor];
    hud.animationType = MBProgressHUDAnimationZoomOut;
    hud.detailsLabelText = title;
    hud.square = NO;
    hud.mode = MBProgressHUDModeText;
    [hud hide:YES afterDelay:timeInt];
}

- (void)setUI{
    NSArray * arr = @[@"增加",@"删除",@"更新",@"查询"];
    for (int i=0; i<4; i++) {
        UIButton * btn =[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(5+HitoScreenW/4*i, 70, HitoScreenW/4-10, 40);
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor yellowColor];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 1000+i;
        [self.view addSubview:btn];
    }
    NSArray * arr1 = @[@"姓名:",@"年龄:",@"身高:"];
    for (int i=0; i<3; i++) {
        UILabel * lab = [[UILabel alloc]initWithFrame:CGRectMake(5, 120+35*i, 50, 30)];
        lab.text = arr1[i];
        lab.font = [UIFont systemFontOfSize:15];
        [self.view addSubview:lab];

        UITextField * textf = [[UITextField alloc]initWithFrame:CGRectMake(60, 120+35*i, HitoScreenW-70, 30)];
        //textf.clearsOnBeginEditing = YES;
        textf.clearButtonMode = UITextFieldViewModeWhileEditing;
        textf.borderStyle = UITextBorderStyleRoundedRect;
        if (i==0) {
            _text1 = textf;
        }else if(i==1){
            _text2 = textf;
        }else if(i==2){
            _text3 = textf;
        }
        [self.view addSubview:textf];
    }

    _showLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 225, HitoScreenW-20, HitoScreenH-230)];
    _showLab.numberOfLines = 15;
    _showLab.backgroundColor = rgba_r(236, 1);
    [self.view addSubview:_showLab];
}

- (void)btnClick:(UIButton *)btn{
    if (btn.tag == 1000) {
        //增加
        [self HttpRequest:@{@"type":@"insert",@"stuName":_text1.text,@"stuAge":_text2.text,@"stuHeight":_text3.text}];
        
    }else if (btn.tag == 1001) {
        //删除
        [self HttpRequest:@{@"type":@"delete",@"stuName":_text1.text}];
        
    }else if (btn.tag == 1002) {
        //更新
        [self HttpRequest:@{@"type":@"update",@"stuName":_text1.text,@"stuAge":_text2.text,@"stuHeight":_text3.text}];
        
    }else if (btn.tag == 1003) {
        //查询
        [self HttpRequest:@{@"type":@"select"}];
    }
}


- (void)HttpRequest:(NSDictionary *)dic{
    [self.dataArr removeAllObjects];
    if ([dic[@"type"] isEqualToString:@"delete"]&&[_text1.text isEqual:@""]) {
        [self showMessageTitle:@"出错了,没有输入!" andDelay:2 andImage:@"failure"];
        return;
    }else if ([dic[@"type"] isEqualToString:@"insert"]&&([_text1.text isEqual:@""]||[_text2.text isEqual:@""]||[_text3.text isEqual:@""])) {
        [self showMessageTitle:@"出错了,没有输入!" andDelay:2 andImage:@"failure"];
        return;
    }else if ([dic[@"type"] isEqualToString:@"update"]&&([_text1.text isEqual:@""]||[_text2.text isEqual:@""]||[_text3.text isEqual:@""])) {
        [self showMessageTitle:@"出错了,没有输入!" andDelay:2 andImage:@"failure"];
        return;
    }
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [[NSSet alloc]initWithObjects:@"text/html",@"application/json", nil];
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc]initWithDictionary:dic];
    [manager POST:@"http://luckfairy.16mb.com/PHPExercise/PHP_JSON_3.php" parameters:parameter progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        [self showMessageTitle:dict[@"result"] andDelay:2 andImage:@"finish"];
        
        NSArray * arr = dict[@"data"];
        if (arr.count>0) {
            for (NSDictionary * dic in arr) {
                phpModel * model = [[phpModel alloc]init];
                [model setValuesForKeysWithDictionary:dic];
                [self.dataArr addObject:model];
            }
            [self showData:YES];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)showData:(BOOL)flag{
    if (self.dataArr.count>0) {
        NSMutableString * str = [[NSMutableString alloc]init];
        for (int i = 0; i < self.dataArr.count; i++) {
            _model = self.dataArr[i];
            [str appendFormat:@"%@\t%@\t%@\n",_model.stuName,_model.stuAge,_model.stuHeight];
        }
        _showLab.text = str;
        [self.dataArr removeAllObjects];
    }else{
        _showLab.text = @"";
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_text2 resignFirstResponder];
    [_text1 resignFirstResponder];
    [_text3 resignFirstResponder];
}
@end
