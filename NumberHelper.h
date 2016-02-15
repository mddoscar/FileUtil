//
//  NumberHelper.h
//  ChildrenLocation
//
//  Created by szalarm on 15/10/5.
//  Copyright © 2015年 szalarm. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 数字生成器工具类
 */
@interface NumberHelper : NSObject

#pragma mark private
//从a到b
-(int)getRandomNumber:(int)from to:(int)to;
//获取9999内的随机数
-(int)getDoubleHounderRandom;
#pragma  mark static
//从a到b
+(int)getRandomNumber:(int)from to:(int)to;
//获取9999内的随机数
+(int)getDoubleHounderRandom;

@end
