//
//  addressViewController.m
//  iOSReview
//
//  Created by Apple on 2017/7/28.
//  Copyright © 2017年 KennyHito. All rights reserved.
//

#import "addressViewController.h"
#import "RXJDAddressPickerView.h"

@interface addressViewController ()
    
@property (nonatomic,strong) RXJDAddressPickerView * threePicker;
    
@end

@implementation addressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton * btn = [self createButtonTitle:@"选择地址" andFont:15 andTitleColor:[UIColor yellowColor] andBackColor:[UIColor redColor] andTag:100 andFrame:CGRectMake(HitoScreenW/2-50, 100, 100, 40)];
    [self.view addSubview:btn];
    
}

- (void)btnClick:(UIButton *)btn{
    __weak typeof(self) WeakSelf = self;
    _threePicker = [[RXJDAddressPickerView alloc] init];
    _threePicker.completion = ^(NSString *address, NSString * addressCode){
        NSLog(@"_threePicker\n, address=%@, addressCode=%@\n\n", address, addressCode);
        [WeakSelf showAlertMessage:address];
    };
    [self.view addSubview:_threePicker];
    [_threePicker showAddress];
}

@end
