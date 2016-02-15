//
//  DeviceHelper.h
//  onemap
//
//  Created by 月光 on 15/3/26.
//  Copyright (c) 2015年 肖光. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DeviceHelper : NSObject
+(BOOL)isPortrait:(UIView*)view;
+(BOOL)isLandscape:(UIView*)view;
+(NSUInteger)screenWidth;
+(NSUInteger)screenHeight;
+(CGPoint)screenCenter;
//获取mac
+(NSString *) macaddress;

@end
