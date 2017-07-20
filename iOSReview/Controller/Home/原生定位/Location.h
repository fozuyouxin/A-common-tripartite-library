//
//  Location.h
//  Summarize
//
//  Created by 于海涛 on 2017/6/27.
//  Copyright © 2017年 于海涛. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

//模型层

@interface Location : NSObject
//国家
@property (nonatomic, copy) NSString * country;
//省 直辖市
@property (nonatomic, copy) NSString * administrativeArea;
//地级市 直辖市区
@property (nonatomic, copy) NSString * locality;
//县 区
@property (nonatomic, copy) NSString * subLocality;
//街道
@property (nonatomic, copy) NSString * thoroughfare;
//子街道
@property (nonatomic, copy) NSString * subThoroughfare;
//经度
@property (nonatomic, assign) CLLocationDegrees longitude;
//纬度
@property (nonatomic, assign) CLLocationDegrees latitude;


@end
