//
//  MViewController.m
//  iOSReview
//
//  Created by Apple on 2017/8/9.
//  Copyright © 2017年 KennyHito. All rights reserved.
//

#import "MViewController.h"

@interface MViewController ()
@property (strong, nonatomic) AVPlayer *player;
@end

@implementation MViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    
    NSString * path = [[NSBundle mainBundle]pathForResource:@"你还要我怎样" ofType:@"mp3"];
    
    //2.获取资源
    AVPlayerItem * item = [[AVPlayerItem alloc]initWithURL:[NSURL fileURLWithPath:path]];
    
    //3.创建player
    _player = [[AVPlayer alloc]initWithPlayerItem:item];
    
    [_player play];
}

@end
