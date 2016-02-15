//
//  DbDateHelper.m
//  ChildrenLocation
//
//  Created by szalarm on 15/10/5.
//  Copyright © 2015年 szalarm. All rights reserved.
//

#import "DbDateHelper.h"

@implementation DbDateHelper
//绑定
@synthesize mDateFormat;
//初始化
#pragma mark ctor
//默认
-(id) init
{
    if (self=[super init]) {
          [self initDate:@"yyyy-MM-dd HH:mm:ss:fff"];
    }
    return self;
}
//传递参数
-(id) initWithDateFormatString:(NSString  *)pDateFormatString

{
    if (self=[super init]) {
        //diy方法
        [self initDate:pDateFormatString];
    }
    return self;
}

#pragma mark private
//私有
-(void) initDate:(NSString  *)pDateFormatString
{
        //初始化一次
    if(self.mDateFormat ==nil)
    {
        mDateFormat = [[NSDateFormatter  alloc]init];
        [mDateFormat setDateFormat:pDateFormatString];//添加毫秒
    }
}

#pragma mark 生成串方法

-(NSString *) GetDateString
{
  return [mDateFormat stringFromDate:[NSDate date]];
}

-(NSString *) GetDateStringWtihDate:(NSDate *) pDate
{
    return [mDateFormat stringFromDate:pDate];
}
@end
