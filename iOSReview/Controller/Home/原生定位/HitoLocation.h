//
//  HitoLocation.h
//  Summarize
//
//  Created by 于海涛 on 2017/6/27.
//  Copyright © 2017年 于海涛. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Location.h"
//协议
@protocol LocationDelegate <NSObject>

- (void)locationDidEndUpdatingLocation:(Location *)location;

@end

@interface HitoLocation : NSObject

@property (nonatomic, weak) id<LocationDelegate> delegate;

- (void)beginUpdatingLocation;

@end
