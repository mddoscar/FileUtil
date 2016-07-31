//
//  MddRegexHelper.h
//  ChildrenLocation
//
//  Created by szalarm on 15/12/30.
//  Copyright © 2015年 szalarm. All rights reserved.
//

#import <Foundation/Foundation.h>


//二维码类型
typedef NS_ENUM(NSUInteger, WatchQRCodeType) {
    WatchQRCodeTypeZnaer=0       //znaer:
    ,WatchQRCodeTypeZG=1       //ZG:
    ,WatchQRCodeTypeZGV2Http=2       //http://www.3galarm.cn/app_v2/?ZG:888888888888888
    ,WatchQRCodeTypeOtherHttp=3       //http其他网址
    ,WatchQRCodeTypeOtherHttps=4       //https
    ,WatchQRCodeTypeOtherWebSocket=5       //ws:
    ,WatchQRCodeTypeOtherEmpty=6       //nil
    ,WatchQRCodeTypeOtherEmptyString=7       //空字符
    ,WatchQRCodeTypeUndefined=8 //不知道什么格式
};


@interface MddRegexHelper : NSObject

#pragma mark 字符打头
//字符是否是什么打头的
+(BOOL) stringIsPreRegexRawStr:(nonnull NSString *)pRawStr mPreStr:(nonnull NSString *) pPreStr;
//字符包涵字符
+(BOOL) stringHaveRawStr:(nonnull NSString *)pRawStr mStr:(nonnull NSString *) pStr;
//不区分大小写
+(BOOL) stringNoUpperHaveRawStr:(nonnull NSString *)pRawStr mStr:(nonnull NSString *) pStr;
//扫描结果转换
+(void) stringIsWatchQRCodeTypeRawStr:(nonnull NSString *)pRawStr mCallBack:(nullable void(^)( WatchQRCodeType rWatchQRCodeType, NSString * __nullable rDealStr))pDoCallBack;
+(BOOL) stringForYMDHMsWithStr:(nonnull NSString *) pStr;
+(BOOL) stringForYMDWithStr:(nonnull NSString *) pStr;
+(BOOL) stringForHMSWithStr:(nonnull NSString *) pStr;

#pragma mark 测试接口

//+(NSMutableArray *) testWatchQRCodeTypeArray;
//测试
+(void) testWatchQRCodeType;


@end
