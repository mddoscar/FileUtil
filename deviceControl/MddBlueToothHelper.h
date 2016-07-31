//
//  MddBlueToothHelper.h
//  ChildrenLocation
//
//  Created by szalarm on 15/10/13.
//  Copyright © 2015年 szalarm. All rights reserved.
//

#import <Foundation/Foundation.h>

//蓝牙控制器
@interface MddBlueToothHelper : NSObject
//开启蓝牙
-(void)startBluetooth;
//切换
- (void)toggle:(id)btCont;

@end
