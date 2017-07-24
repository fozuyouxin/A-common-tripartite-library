//
//  dataModel.h
//  Summarize
//
//  Created by 于海涛 on 16/12/16.
//  Copyright © 2016年 于海涛. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface dataModel : NSObject

PROPERTY(time);
PROPERTY(context);

- (void)setValue:(id)value forUndefinedKey:(NSString *)key;
@end
