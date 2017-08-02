//
//  BaseView.h
//  iOSReview
//
//  Created by Apple on 2017/8/2.
//  Copyright © 2017年 KennyHito. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClikedBlock)();

@interface BaseView : UIView

@property(nonatomic, strong)ClikedBlock clickLoadBtnBlock;

@end
