//
//  NextViewController.h
//  iOSReview
//
//  Created by 于海涛 on 2017/6/22.
//  Copyright © 2017年 KennyHito. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ myBlock)(NSString *);

@interface NextViewController : UIViewController

@property (nonatomic,strong)myBlock  block;

@end
