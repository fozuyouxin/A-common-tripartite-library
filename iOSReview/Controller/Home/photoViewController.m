//
//  photoViewController.m
//  iOSReview
//
//  Created by Apple on 2017/7/20.
//  Copyright © 2017年 KennyHito. All rights reserved.
//

#import "photoViewController.h"

@interface photoViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic,strong) UIImageView * imageV;
@property (nonatomic,strong) UIImagePickerController * imagePicke;

@end

@implementation photoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _imageV = [[UIImageView alloc]initWithFrame:CGRectMake(20, 80,HitoScreenW-40,HitoScreenW-40)];
    _imageV.image = [UIImage imageNamed:@"bao.jpg"];
    [self.view addSubview:_imageV];
    
    _imagePicke = [[UIImagePickerController alloc]init];
    _imagePicke.delegate = self;
    _imagePicke.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    _imagePicke.allowsEditing = YES;
    
    int width = 120;
    UIButton * btn = [self createButtonTitle:@"调用相册" andFont:15 andTitleColor:[UIColor redColor] andBackColor:[UIColor yellowColor] andTag:1000 andFrame:CGRectMake(HitoScreenW/2-width/2, HitoScreenH-150, width, 40)];
    [self.view addSubview:btn];
    UIButton * btn1 = [self createButtonTitle:@"调用相机" andFont:15 andTitleColor:[UIColor redColor] andBackColor:[UIColor yellowColor] andTag:1001 andFrame:CGRectMake(HitoScreenW/2-width/2, HitoScreenH-100, width, 40)];
    [self.view addSubview:btn1];
    
}
#pragma mark -- 调用相册
- (void)btnClick:(UIButton *)btn{
    if (btn.tag == 1000) {
        //[注意🐷] : UIImagePickerControllerSourceTypePhotoLibrary, 调用相册
        //          UIImagePickerControllerSourceTypeCamera,  调用摄像头
        _imagePicke.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:_imagePicke animated:YES completion:nil];
        
    }else if(btn.tag ==1001){
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
            _imagePicke.sourceType = UIImagePickerControllerSourceTypeCamera;
            
            [self presentViewController:_imagePicke animated:YES completion:nil];
        }else{
            NSLog(@"相机不可用");
        }
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo{
    
    _imageV.image = image;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
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
