//
//  DbDateHelper.h
//  ChildrenLocation
//
//  Created by szalarm on 15/10/5.
//  Copyright © 2015年 szalarm. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 时间戳帮助类
 */
@interface DbDateHelper : NSObject

#pragma mark ctor
//默认
-(id) init;
//传递参数
-(id) initWithDateFormatString:(NSString  *)pDateFormatString;


#pragma mark 成员
//单例时间（听说很耗时）
@property (nonatomic,strong) NSDateFormatter * mDateFormat;

#pragma mark 生成串方法

-(NSString *) GetDateString;
-(NSString *) GetDateStringWtihDate:(NSDate *) pDate;

@end
