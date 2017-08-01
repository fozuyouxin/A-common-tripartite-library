//
//  lightViewController.m
//  iOSReview
//
//  Created by Apple on 2017/8/1.
//  Copyright © 2017年 KennyHito. All rights reserved.
//

#import "lightViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface lightViewController ()

@end

@implementation lightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)openLight:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    if (sender.isSelected) {
        
        //打开闪光灯
        AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        NSError *error = nil;
        
        if ([captureDevice hasTorch]) {
            BOOL locked = [captureDevice lockForConfiguration:&error];
            if (locked) {
                captureDevice.torchMode = AVCaptureTorchModeOn;
                [captureDevice unlockForConfiguration];
            }
        }
        
    }else{
        
        //关闭闪光灯
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        if ([device hasTorch]) {
            BOOL locked = [device lockForConfiguration:nil];
            if (locked) {
                [device setTorchMode: AVCaptureTorchModeOff];
                [device unlockForConfiguration];
            }
        }
    }
}


@end
