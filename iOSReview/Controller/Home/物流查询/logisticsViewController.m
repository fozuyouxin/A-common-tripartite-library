//
//  logisticsViewController.m
//  Summarize
//
//  Created by 于海涛 on 16/12/16.
//  Copyright © 2016年 于海涛. All rights reserved.
//

#import "logisticsViewController.h"

@interface logisticsViewController ()<UITextFieldDelegate>

//http://www.kuaidi100.com/query
@property (nonatomic,copy)NSString *logsitUrl;//物流网址
@property (nonatomic,copy) NSString * logistCompany;//物流公司
@property (nonatomic,copy) NSString * logistNum;//物流订单号
@property (nonatomic,strong) UITextField * orderNumText;//物流订单文本框
@property (nonatomic,strong) UITextField * logistCompanyText;//物流公司文本框
@property (nonatomic,strong) UIButton * orderNumBtn;//物流查询按钮

@end

@implementation logisticsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = HitoRGBA(255, 255, 255, 1);
    
    [self setupUI];
}
- (void)setupUI{
    _orderNumText = [[UITextField alloc]initWithFrame:CGRectMake(HitoScreenW/2-75, 100, 200, 30)];
    _orderNumText.placeholder = @"请输入订单号";
    _orderNumText.borderStyle = UITextBorderStyleLine;
    _orderNumText.delegate = self;
    [self.view addSubview:_orderNumText];
    
    _logistCompanyText = [[UITextField alloc]initWithFrame:CGRectMake(HitoScreenW/2-75, 140, 200, 30)];
    _logistCompanyText.delegate = self;
    _logistCompanyText.placeholder = @"请输入物流公司";
    _logistCompanyText.borderStyle = UITextBorderStyleLine;
    [self.view addSubview:_logistCompanyText];
    
    UILabel * lab1 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.orderNumText.frame)-80, 100, 80, 30)];
    lab1.text = @"订 单 号";
    lab1.font = [UIFont systemFontOfSize:17];
    lab1.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lab1];
    
    UILabel * lab2 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.orderNumText.frame)-80, 140, 80, 30)];
    lab2.text = @"物流公司";
    lab2.font = [UIFont systemFontOfSize:17];
    lab2.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lab2];
    
    _orderNumBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    [_orderNumBtn setTitle:@"查询" forState:UIControlStateNormal];
    [_orderNumBtn setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
    _orderNumBtn.backgroundColor = [UIColor redColor];
    _orderNumBtn.center = CGPointMake(self.view.center.x, 240);
    [_orderNumBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_orderNumBtn];
    
    UILabel * lab3 = [[UILabel alloc]initWithFrame:CGRectMake(40, 260, HitoScreenW-80, 120)];
    lab3.numberOfLines = 4;
    lab3.lineBreakMode = NSLineBreakByWordWrapping;
    
    lab3.text = @"⚠️ : 目前物流公司只支持京东,中通,圆通,韵达,中邮,天天,宅急送,德邦物流快递的查询!其它快递查询将后期添加,请及时更新App!";
    [self.view addSubview:lab3];
}
- (void)btnClick:(UIButton *)btn{
    self.logistCompany = self.logistCompanyText.text;
    self.logistNum = self.orderNumText.text;
    if (!self.orderNumText.text.length || !self.logistCompanyText.text.length) {
        NSLog(@"订单号和物流公司都不能为空!");
        [taoAlert showAlertWithController:self andTitlt:@"订单号和物流公司不能为空!" andMessage:nil andTime:2.0];
        return;
    }
    if ([self.logistCompany isEqualToString:@"顺丰"]) {
        self.logistCompany = @"shunfeng";
    }else if ([self.logistCompany isEqualToString:@"京东"]){
        self.logistCompany = @"jd";
    }else if ([self.logistCompany isEqualToString:@"中通"]){
        self.logistCompany = @"zhongtong";
    }else if ([self.logistCompany isEqualToString:@"圆通"]){
        self.logistCompany = @"yuantong";
    }else if ([self.logistCompany isEqualToString:@"韵达"]){
        self.logistCompany = @"yunda";
    }else if ([self.logistCompany isEqualToString:@"中邮"]){
        self.logistCompany = @"ems";
    }else if ([self.logistCompany isEqualToString:@"申通"]){
        self.logistCompany = @"shentong";
    }else if ([self.logistCompany isEqualToString:@"天天"]){
        self.logistCompany = @"tiantian";
    }else if ([self.logistCompany isEqualToString:@"宅急送"]){
        self.logistCompany = @"zhaijisong";
    }else if ([self.logistCompany isEqualToString:@"德邦"]){
        self.logistCompany = @"debangwuliu";
    }
    
    
    DetailsLogisticsViewController * vc = [[DetailsLogisticsViewController alloc]init];
    vc.logistCompany = self.logistCompany;//公司
    vc.logistNum = self.logistNum;//订单号
    vc.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_logistCompanyText resignFirstResponder];
    [_orderNumText resignFirstResponder];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_logistCompanyText resignFirstResponder];
    [_orderNumText resignFirstResponder];
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
