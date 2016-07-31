//
//  MddRegexHelper.m
//  ChildrenLocation
//
//  Created by szalarm on 15/12/30.
//  Copyright © 2015年 szalarm. All rights reserved.
//

#import "MddRegexHelper.h"
//二维码正则
#define kWatchQRCodeTypeZnaer @"znaer:"
#define kWatchQRCodeTypeZG @"ZG:"
#define kWatchQRCodeTypeHttp @"http://"
#define kWatchQRCodeTypeHttps @"https://"
#define kWatchQRCodeTypeWS @"ws:"
/*
 正则表达式匹配工具
 */
@implementation MddRegexHelper

#pragma mark 字符打头
//字符是否是什么打头的
+(BOOL) stringIsPreRegexRawStr:(nonnull NSString *)pRawStr mPreStr:(nonnull NSString *) pPreStr
{
    BOOL rResult=false;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"SELF BEGINSWITH[c] '%@'", pPreStr]];
    rResult=[predicate evaluateWithObject:pRawStr];
    NSLog(@"%@是%@开头：%@",pRawStr,pPreStr,rResult?@"Y":@"N");
    return rResult;
    /*
     NSString * regex        = @"(^[A-Za-z0-9]{6,15}$)";
     NSPredicate * pred      = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
     BOOL isMatch            = [pred evaluateWithObject:@"123456ABCde"];
     */
}
+(BOOL) stringNoUpperHaveRawStr:(nonnull NSString *)pRawStr mStr:(nonnull NSString *) pStr
{
    
    BOOL rResult=false;
    @try {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"SELF CONTAINS[d] '%@'", [pStr localizedUppercaseString]]];
        rResult=[predicate evaluateWithObject:[pRawStr localizedUppercaseString]];
        NSLog(@"%@是%@包含：%@",[pRawStr localizedUppercaseString],[pStr localizedUppercaseString],rResult?@"Y":@"N");
    } @catch (NSException *exception) {
        NSLog(@"%@",exception);
    } @finally {
        
    }
    
    
    return rResult;
}
//字符包涵字符
+(BOOL) stringHaveRawStr:(nonnull NSString *)pRawStr mStr:(nonnull NSString *) pStr
{
    BOOL rResult=false;
        @try {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"SELF CONTAINS[d] '%@'", pStr]];
    rResult=[predicate evaluateWithObject:pRawStr];
    NSLog(@"%@是%@包含：%@",pRawStr,pStr,rResult?@"Y":@"N");
    } @catch (NSException *exception) {
        NSLog(@"%@",exception);
    } @finally {
        
    }
    return rResult;
}
/**
 NSPredicate * qcondition= [NSPredicate predicateWithFormat:@"salary >= 10000"];
 
 2、字符串操作(包含)：BEGINSWITH、ENDSWITH、CONTAINS
 
 如：
 
 @"employee.name BEGINSWITH[cd] '李'" //姓李的员工
 
 @"employee.name ENDSWITH[c] '梦'"   //以梦结束的员工
 
 @"employee.name CONTAINS[d] '宗'"   //包含有"宗"字的员工
 
 */
//判断类型
+(void) stringIsWatchQRCodeTypeRawStr:(nonnull NSString *)pRawStr mCallBack:(void(^)( WatchQRCodeType rWatchQRCodeType, NSString * rDealStr))pDoCallBack
{
    NSLog(@"原始字符串:%@",pRawStr);
    __block WatchQRCodeType rWatchQRCodeType=WatchQRCodeTypeUndefined;
    __block NSString *pDealStr=nil;
    //是否为空
    if (nil==pRawStr) {
        rWatchQRCodeType=WatchQRCodeTypeOtherEmpty;
        pDealStr=nil;
    //空字符串
    }else if ([@"" isEqualToString:pRawStr]) {
        rWatchQRCodeType=WatchQRCodeTypeOtherEmptyString;
        pDealStr=@"";
    //非空情况
    }else{
        NSRange range1=NSMakeRange(0,6);
        NSRange range3=NSMakeRange(0,3);
        //znaer:开头情况
        if([[pRawStr substringWithRange:range1] isEqualToString:kWatchQRCodeTypeZnaer]){
            NSRange range2=NSMakeRange(6,pRawStr.length-6);
            rWatchQRCodeType=WatchQRCodeTypeZnaer;
            pDealStr=[pRawStr substringWithRange:range2];
        //ZG:情况
        }else if ([[pRawStr substringWithRange:range3] isEqualToString:kWatchQRCodeTypeZG]){
            NSRange range4=NSMakeRange(3,pRawStr.length-3);
            rWatchQRCodeType=WatchQRCodeTypeZG;
            pDealStr=[pRawStr substringWithRange:range4];
        }else
        {
            //获取字符串位置
            NSInteger tLocation=[pRawStr rangeOfString:kWatchQRCodeTypeZG].location;
            /* http: //www.3galarm.cn/app_v2/?ZG:888888888888888
            XXXXX....ZG:888888888888888
             */
            if(tLocation !=NSNotFound)
            {
                //这里也许会有多种，暂时这样
                rWatchQRCodeType=WatchQRCodeTypeZGV2Http;
                //ZG:这三个字符要排除
                NSRange range=NSMakeRange(tLocation+3,pRawStr.length-tLocation-3);
                pDealStr=[pRawStr substringWithRange:range];
            //判断是否是其他http
            }
            else
            {
                //http://开头的
                if ([[self class] stringIsPreRegexRawStr:pRawStr mPreStr:kWatchQRCodeTypeHttp]) {
                    rWatchQRCodeType=WatchQRCodeTypeOtherHttp;
                    pDealStr=pRawStr;
                //https://开头的
                }else if ([[self class] stringIsPreRegexRawStr:pRawStr mPreStr:kWatchQRCodeTypeHttps]) {
                    rWatchQRCodeType=WatchQRCodeTypeOtherHttps;
                    pDealStr=pRawStr;
                //websocket
                }else if ([[self class] stringIsPreRegexRawStr:pRawStr mPreStr:kWatchQRCodeTypeWS]) {
                    rWatchQRCodeType=WatchQRCodeTypeOtherWebSocket;
                    pDealStr=pRawStr;
                //不认识的字符串
                }else
                {
                    rWatchQRCodeType=WatchQRCodeTypeUndefined;
                    pDealStr=pRawStr;
                
                }
            }//end other
        }//end un nil
    }//end nil
    //判断完成回传
    pDoCallBack(rWatchQRCodeType,pDealStr);

}
+(BOOL) stringForYMDHMsWithStr:(nonnull NSString *) pStr
{
    /*
     (((^((1[8-9]\\d{2})|([2-9]\\d{3}))([-\\/\\._])(10|12|0?[13578])([-\\/\\._])(3[01]|[12][0-9]|0?[1-9]))|(^((1[8-9]\\d{2})|([2-9]\\d{3}))([-\\/\\._])(11|0?[469])([-\\/\\._])(30|[12][0-9]|0?[1-9]))|(^((1[8-9]\\d{2})|([2-9]\\d{3}))([-\\/\\._])(0?2)([-\\/\\._])(2[0-8]|1[0-9]|0?[1-9]))|(^([2468][048]00)([-\\/\\._])(0?2)([-\\/\\._])(29))|(^([3579][26]00)([-\\/\\._])(0?2)([-\\/\\._])(29))|(^([1][89][0][48])([-\\/\\._])(0?2)([-\\/\\._])(29))|(^([2-9][0-9][0][48])([-\\/\\._])(0?2)([-\\/\\._])(29))|(^([1][89][2468][048])([-\\/\\._])(0?2)([-\\/\\._])(29))|(^([2-9][0-9][2468][048])([-\\/\\._])(0?2)([-\\/\\._])(29))|(^([1][89][13579][26])([-\\/\\._])(0?2)([-\\/\\._])(29))|(^([2-9][0-9][13579][26])([-\\/\\._])(0?2)([-\\/\\._])(29)))\\s*((0?[1-9])|1\\d|2[0-3])\\:((0?[1-9])|[1-5]\\d)\\:((0?[1-9])|[1-5]\\d)$)
     
     */
    BOOL rRes=false;
    NSError * err=NULL;
    NSString * pattern=@"(((^((1[8-9]\\d{2})|([2-9]\\d{3}))([-\\/\\._])(10|12|0?[13578])([-\\/\\._])(3[01]|[12][0-9]|0?[1-9]))|(^((1[8-9]\\d{2})|([2-9]\\d{3}))([-\\/\\._])(11|0?[469])([-\\/\\._])(30|[12][0-9]|0?[1-9]))|(^((1[8-9]\\d{2})|([2-9]\\d{3}))([-\\/\\._])(0?2)([-\\/\\._])(2[0-8]|1[0-9]|0?[1-9]))|(^([2468][048]00)([-\\/\\._])(0?2)([-\\/\\._])(29))|(^([3579][26]00)([-\\/\\._])(0?2)([-\\/\\._])(29))|(^([1][89][0][48])([-\\/\\._])(0?2)([-\\/\\._])(29))|(^([2-9][0-9][0][48])([-\\/\\._])(0?2)([-\\/\\._])(29))|(^([1][89][2468][048])([-\\/\\._])(0?2)([-\\/\\._])(29))|(^([2-9][0-9][2468][048])([-\\/\\._])(0?2)([-\\/\\._])(29))|(^([1][89][13579][26])([-\\/\\._])(0?2)([-\\/\\._])(29))|(^([2-9][0-9][13579][26])([-\\/\\._])(0?2)([-\\/\\._])(29)))\\s*((0?[0-9])|1[0-9]|2[0-3])\\:((0?[0-9])|[1-5][0-9])\\:((0?[0-9])|[1-5][0-9])$)";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:&err];
    if(![@"" isEqualToString:pStr]&&pStr!=nil)
    {
       NSUInteger count= [regex numberOfMatchesInString:pStr options:0 range:NSMakeRange(0, [pStr length])];
        if (count==1) {
            rRes=true;
        }
    }else{
        rRes=false;
    }
    NSLog(@"(stringForYMDHMsWithStr) yyyy-MM-dd HH:mm:ss %@ :%@",pStr,rRes?@"Y":@"N");
    return rRes;
}
+(BOOL) stringForYMDWithStr:(nonnull NSString *) pStr
{
    BOOL rRes=false;
    NSError * err=NULL;
    NSString * pattern=@"((^((1[8-9]\\d{2})|([2-9]\\d{3}))([-\\/\\._])(10|12|0?[13578])([-\\/\\._])(3[01]|[12][0-9]|0?[1-9]))|(^((1[8-9]\\d{2})|([2-9]\\d{3}))([-\\/\\._])(11|0?[469])([-\\/\\._])(30|[12][0-9]|0?[1-9]))|(^((1[8-9]\\d{2})|([2-9]\\d{3}))([-\\/\\._])(0?2)([-\\/\\._])(2[0-8]|1[0-9]|0?[1-9]))|(^([2468][048]00)([-\\/\\._])(0?2)([-\\/\\._])(29))|(^([3579][26]00)([-\\/\\._])(0?2)([-\\/\\._])(29))|(^([1][89][0][48])([-\\/\\._])(0?2)([-\\/\\._])(29))|(^([2-9][0-9][0][48])([-\\/\\._])(0?2)([-\\/\\._])(29))|(^([1][89][2468][048])([-\\/\\._])(0?2)([-\\/\\._])(29))|(^([2-9][0-9][2468][048])([-\\/\\._])(0?2)([-\\/\\._])(29))|(^([1][89][13579][26])([-\\/\\._])(0?2)([-\\/\\._])(29))|(^([2-9][0-9][13579][26])([-\\/\\._])(0?2)([-\\/\\._])(29)))";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:&err];
    if(![@"" isEqualToString:pStr]&&pStr!=nil)
    {
        NSUInteger count= [regex numberOfMatchesInString:pStr options:0 range:NSMakeRange(0, [pStr length])];
        if (count==1) {
            rRes=true;
        }
    }else{
        rRes=false;
    }
    NSLog(@"(stringForYMDHMsWithStr) yyyy-MM-dd  %@ :%@",pStr,rRes?@"Y":@"N");
    return rRes;

}
+(BOOL) stringForHMSWithStr:(nonnull NSString *) pStr
{
    BOOL rRes=false;
    NSError * err=NULL;
    NSString * pattern=@"((0?[0-9])|1[0-9]|2[0-3])\\:((0?[0-9])|[1-5][0-9])\\:((0?[0-9])|[1-5][0-9])$";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:&err];
    if(![@"" isEqualToString:pStr]&&pStr!=nil)
    {
        NSUInteger count= [regex numberOfMatchesInString:pStr options:0 range:NSMakeRange(0, [pStr length])];
        if (count==1) {
            rRes=true;
        }
    }else{
        rRes=false;
    }
    NSLog(@"(stringForYMDHMsWithStr) HH:mm:ss %@ :%@",pStr,rRes?@"Y":@"N");
    return rRes;

}
#pragma mark test
+(NSMutableArray *) testWatchQRCodeTypeArray
{
    NSMutableArray * tArray=[NSMutableArray array];
    [tArray addObject:@"znaer:123456"];
    [tArray addObject:@"ZG:888888888888888"];
    [tArray addObject:@"http://www.baidu.com"];
    [tArray addObject:@"https://www.baidu.com"];
    [tArray addObject:@"ws://www.baidu.com"];
    [tArray addObject:@"dsslhttps://www.baidu.com"];
    [tArray addObject:@"dasws://www.baidu.com"];
    [tArray addObject:@"http://www.3galarm.cn/app_v2/?ZG:888888888888888"];
    [tArray addObject:@"sfshttp://www.3galarm.cn/app_v2/?ZG:888888888888888"];
     [tArray addObject:@""];
    return tArray;

}
+(void) testWatchQRCodeType
{
    NSMutableArray * tArr=[[self class] testWatchQRCodeTypeArray];
    for (NSString * obj in tArr) {
        [[self class] stringIsWatchQRCodeTypeRawStr:obj mCallBack:^(WatchQRCodeType rWatchQRCodeType, NSString *rDealStr) {
            NSLog(@"WatchQRCodeType:%ld,DealStr:%@",(unsigned long)rWatchQRCodeType,rDealStr);
        }];
    }

}

@end
