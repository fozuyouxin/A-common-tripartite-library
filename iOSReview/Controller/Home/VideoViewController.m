//
//  VideoViewController.m
//  iOSReview
//
//  Created by Apple on 2017/7/19.
//  Copyright © 2017年 KennyHito. All rights reserved.
//

#import "VideoViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface VideoViewController ()
@property (strong, nonatomic) AVPlayer *avPlayer;
@property (nonatomic,strong) UIImageView * imageV;
@end

@implementation VideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];

    //网络视频播放
    NSString *playString = @"http://static.tripbe.com/videofiles/20121214/9533522808.f4v.mp4";
    NSURL *url = [NSURL URLWithString:playString];
    //本地视频播放
    //NSString *audioPath = [[NSBundle mainBundle] pathForResource:@"霍建华、赵丽颖 - 不可说" ofType:@"mp4"];
    //NSURL *url = [NSURL fileURLWithPath:audioPath];
    //设置播放的项目
    AVPlayerItem *item = [[AVPlayerItem alloc] initWithURL:url];
    //初始化player对象
    self.avPlayer = [[AVPlayer alloc] initWithPlayerItem:item];
    //设置播放页面
    AVPlayerLayer *layer = [AVPlayerLayer playerLayerWithPlayer:_avPlayer];
    //设置播放页面的大小
    layer.frame = CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, 200);
    layer.backgroundColor = [UIColor cyanColor].CGColor;
    //设置播放窗口和当前视图之间的比例显示内容
    /*
     第1种AVLayerVideoGravityResizeAspect是按原视频比例显示，是竖屏的就显示出竖屏的，两边留黑；
     第2种AVLayerVideoGravityResizeAspectFill是以原比例拉伸视频，直到两边屏幕都占满，但视频内容有部分就被切割了；
     第3种AVLayerVideoGravityResize是拉伸视频内容达到边框占满，但不按原比例拉伸，这里明显可以看出宽度被拉伸了。
     */
    layer.videoGravity = AVLayerVideoGravityResizeAspect;
    //添加播放视图到self.view
    [self.view.layer addSublayer:layer];
    //视频播放
    [self.avPlayer play];
    //视频暂停
    //[self.avPlayer pause];
    
    
    
#pragma mark -- 本地视频第一帧图片预加载
    _imageV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 300, 300, 300)];
    _imageV.userInteractionEnabled = YES;
    NSString *playStr = [[NSBundle mainBundle] pathForResource:@"123" ofType:@"mp4"];
    UIImage * iv = [self getVideoFirstImage:playStr];
    _imageV.image = iv;
    [self.view addSubview:_imageV];
    UILongPressGestureRecognizer * longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressClick:)];
    //设置长按时间,默认0.5秒
    longPress.minimumPressDuration = 1.0;
    [self.imageV addGestureRecognizer:longPress];
}

- (void)longPressClick:(UIGestureRecognizer *)longPress{
    //必须加上判断语句防止多次保存
    if (longPress.state == UIGestureRecognizerStateBegan ) {
        [self savePicture:self.imageV.image];
    }
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
