//
//  MddDeviceInfoHelper.m
//  ChildrenLocation
//
//  Created by szalarm on 15/10/14.
//  Copyright © 2015年 szalarm. All rights reserved.
//

#import "MddDeviceInfoHelper.h"
//设备
#import "UIDevice+DeviceModel.h"

#ifndef ChildrenLocation_MddDeviceInfoHelper_h
#define ChildrenLocation_MddDeviceInfoHelper_h
    //列名
    #define kUIDevice  @"UIDevice" //用户信息
    #define kAppCurName @"appCurName" //应用编号
    #define kAppCurVersion @"appCurVersion" //应用编号
    #define kAppCurVersionNum @"appCurVersionNum" //应用编号
    //版本号码
    #define kAppStoreVersion @"appStoreVersion" //应用商店上的版本号
    //新版本，手机号码不能用
    //#define KMyNumber @"myNumber" //手机号码
#endif
//存储
#import "ConfigService.h"
#import "StoreService.h"
#import "MddRegexHelper.h"
//电话信息
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
//引用弹出款
#import "UIAlertView+Block.h"
//获取电话
extern NSString *CTSettingCopyMyPhoneNumber();

//extern NSString *CTSettingCopyMyPhoneNumber();

@implementation MddDeviceInfoHelper


//信息
+(NSMutableDictionary *) infoForDiviceDic
{
    NSMutableDictionary * rInfoDic=[NSMutableDictionary dictionary];
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    // 当前应用名称
    NSString *appCurName = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    NSLog(@"当前应用名称：%@",appCurName);
    // 当前应用软件版本  比如：1.0.1
    NSString *appCurVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    NSLog(@"当前应用软件版本:%@",appCurVersion);
    // 当前应用版本号码   int类型
    NSString *appCurVersionNum = [infoDictionary objectForKey:@"CFBundleVersion"];
    NSLog(@"当前应用版本号码：%@",appCurVersionNum);
    //设备
    [rInfoDic setObject:[UIDevice currentDevice] forKey:kUIDevice];
    [rInfoDic setObject:appCurName forKey:kAppCurName];
    [rInfoDic setObject:appCurVersion forKey:kAppCurVersion];
    [rInfoDic setObject:appCurVersionNum forKey:kAppCurVersionNum];
    //[rInfoDic setObject:CTSettingCopyMyPhoneNumber() forKey:KMyNumber];
    return rInfoDic;

}


//获取手机号
//+(NSString *)myNumber{
//    return CTSettingCopyMyPhoneNumber();
//}

+(UIDevice *) myUIDevice
{
    return [UIDevice currentDevice];
}
+(NSString *) DevInfoidentifierNumber
{
    NSUUID* identifierNumber = [[UIDevice currentDevice] identifierForVendor];
    return [NSString stringWithFormat:@"%@",identifierNumber.UUIDString];
}
+(NSString *) DevInfophoneVersion
{
    NSString* phoneVersion = [[UIDevice currentDevice] systemVersion];
    return phoneVersion;
}
+(NSString *) DevInfophoneModel
{
    NSString* phoneModel = [[UIDevice currentDevice] deviceModel];
    NSLog(@"手机型号: %@",phoneModel );
    return phoneModel;
}
+(NSString *) DevInfolocalPhoneModel
{
    NSString* localPhoneModel = [[UIDevice currentDevice] localizedModel];
    NSLog(@"国际化区域名称: %@",localPhoneModel );
    return localPhoneModel;
}
//设备简介
+(void) DeviceInfo
{
    //手机序列号
    NSUUID* identifierNumber = [[UIDevice currentDevice] identifierForVendor];
    NSLog(@"手机序列号: %@",identifierNumber);
    //手机别名： 用户定义的名称
    NSString* userPhoneName = [[UIDevice currentDevice] name];
    NSLog(@"手机别名: %@", userPhoneName);
    //设备名称
    NSString* deviceName = [[UIDevice currentDevice] systemName];
    NSLog(@"设备名称: %@",deviceName );
    //手机系统版本
    NSString* phoneVersion = [[UIDevice currentDevice] systemVersion];
    NSLog(@"手机系统版本: %@", phoneVersion);
    //手机型号
    NSString* phoneModel = [[UIDevice currentDevice] model];
    NSLog(@"手机型号: %@",phoneModel );
    //地方型号  （国际化区域名称）
    NSString* localPhoneModel = [[UIDevice currentDevice] localizedModel];
    NSLog(@"国际化区域名称: %@",localPhoneModel );
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    // 当前应用名称
    NSString *appCurName = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    NSLog(@"当前应用名称：%@",appCurName);
    // 当前应用软件版本  比如：1.0.1
    NSString *appCurVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    NSLog(@"当前应用软件版本:%@",appCurVersion);
    // 当前应用版本号码   int类型
    NSString *appCurVersionNum = [infoDictionary objectForKey:@"CFBundleVersion"];
    NSLog(@"当前应用版本号码：%@",appCurVersionNum);
}
+(NSMutableDictionary *)infoForSim
{
    NSMutableDictionary * rDic=[NSMutableDictionary dictionary];
    CTTelephonyNetworkInfo *networkInfo;
    networkInfo=[[CTTelephonyNetworkInfo alloc] init];
    //当sim卡更换时弹出此窗口
    
//    networkInfo.subscriberCellularProviderDidUpdateNotifier = ^(CTCarrier *carrier){
//        
////        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Sim card changed" delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
////        
////        [alert show];
//        
//    };
//    NSLog(@"");
    //获取sim卡信息
    
    CTCarrier *carrier = networkInfo.subscriberCellularProvider;
    [rDic setObject:carrier forKey:@"carrier"];
    NSLog(@"%@",carrier);
    return rDic;

}
//获取系统语言
+(NSString *) getMddCurrentVersion
{
    NSString * rLanguage=@"";
    NSArray *languages = [NSLocale preferredLanguages];
    rLanguage = [languages objectAtIndex:0];
//    NSLog( @"%@" , rLanguage);
    return rLanguage;
}
//是否是简体中文
+(BOOL) getMddCurrentVersionIszh_Hans_CN
{
    BOOL res=false;
    NSString * tLocalCode=[self getMddCurrentVersion];
    //zh-Hans-CN简体中文
//     if ([@"zh-Hans-CN" isEqualToString:tLocalCode]) {
    if ([MddRegexHelper stringIsPreRegexRawStr:tLocalCode mPreStr:@"zh-Hans"]) {
        res=true;
     }else
     {
         res=false;
     }
    return  res;

}
//应用版本
+(NSString *) getMddAppVersion
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    // 当前应用软件版本  比如：1.0.1
    NSString *appCurVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    return appCurVersion;
}
#pragma mark 标志位
//获取状态位
+(int) getMddCurrentVersionCode
{
//    NSString * rLanguage=@"";
//    NSArray *languages = [NSLocale preferredLanguages];
//    rLanguage = [languages objectAtIndex:0];
//    //目前只有两种语言
//    if ([@"en" isEqualToString:rLanguage]) {
//        return EnVersion;
//    }else{
//        return ZhVersion;
//    }

    return [[ConfigService valueForName:@"SysLocalLanguageVersion"] intValue];//mddCurrentVersion;
}
//弹出提示那个语言
+(int) getCurrentCode
{
    return [[ConfigService valueForName:@"SysLocalLanguageVersion"] intValue];
}
#pragma mark - 方法1(异步请求)，APP检查更新
//获取应用信息
+(void)dicForcheckAppToUpdateInfFucation:(void(^)(NSMutableDictionary * pResultDic))pDoFunctionCallBack;
{
    __block  NSMutableDictionary * rCheckDic=[NSMutableDictionary dictionary];
    
    //app的数字ID
    NSString * plist = [[NSBundle mainBundle] pathForResource:@"Common-Configuration" ofType:@"plist"];
    NSDictionary * dic = [NSDictionary dictionaryWithContentsOfFile:plist];
    NSString *appleID = dic[@"AppleID"];
    
    //获取当前APP的版本号
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    NSString *nowVersion = [infoDict objectForKey:@"CFBundleVersion"];
    
    //已经上架的APP的版本号
    //设置本地版本
    [rCheckDic setObject:nowVersion forKey:kAppCurVersionNum];
    //默认应用商店的版本
    [rCheckDic setObject:@"0" forKey:kAppStoreVersion];
    //获取上架app store网址
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://itunes.apple.com/lookup?id=%@",appleID]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setHTTPMethod:@"GET"];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        if ( [data length] > 0 && !error ) { // Success
            
            NSDictionary *appData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                // All versions that have been uploaded to the AppStore
                NSArray *versionsInAppStore = [[appData valueForKey:@"results"] valueForKey:@"version"];
                
                if ( ![versionsInAppStore count] ) { // No versions of app in AppStore
                    
                    
                    
                    return;
                    
                } else {
                    //已经上架的APP的版本号
                    NSString *versionInAppStore = [versionsInAppStore objectAtIndex:0];
                    //应用商店上的地址
                    [rCheckDic setObject:versionInAppStore forKey:kAppStoreVersion];
                    
                    /*
                     *1. 不相等，说明有可更新的APP。此方式导致审核被拒绝，因为新版本与已发布版本不相等，弹出了更新提示框。
                     *2. “不相等”方式改为“小于”，再提示更新，只有上架的APP，才可检测更新并弹框。不过此方式只针对此类版本号（1或1.1），不适合此类版本号（1.1.1或1.1.1.x）
                     *3. 不过1.1~1.9，1.1~9.1，有81种，足够多的版本
                     *4. 改进1，若是1.1与1.1.1的比较（不同类比较），可以通过版本号的长度来提示更新，长度小于则提示。
                     *5. 改进2，若是1.1.1与1.1.2（即长度>=5）的比较（同类比较），取最后3位比较。
                     */
                    //                    if([nowVersion floatValue] < [versionInAppStore floatValue]){
                    //比较版本号大小
                    
//                    if([versionInAppStore compare:nowVersion] > 0){
//                        
//                    }
                }
                //回调
                pDoFunctionCallBack(rCheckDic);
            });
        }
    }];
}
//判断更新
+(void)getCheckAppToUpdateInfFucation:(void(^)(NSString * rLocalVersion ,NSString * rAppStoreVersion,NSString * rDownloadUrl))pDoFunctionCallBack
{
    //返回值
    __block NSString * rDowloadUrl=[[self class] urlForUpdateApp];
    __block NSString * rLocalAppVersion;
     __block NSString * rAppStoreVersion;
    
    //app的数字ID
    NSString * plist = [[NSBundle mainBundle] pathForResource:@"Common-Configuration" ofType:@"plist"];
    NSDictionary * dic = [NSDictionary dictionaryWithContentsOfFile:plist];
    NSString *appleID = dic[@"AppleID"];
    
    //获取当前APP的版本号
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    NSString *nowVersion = [infoDict objectForKey:@"CFBundleVersion"];
    //设置本地版本
    rLocalAppVersion=nowVersion;
    //默认应用商店的版本
    rAppStoreVersion=@"0.0.0";
    //获取上架app store网址
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://itunes.apple.com/lookup?id=%@",appleID]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setHTTPMethod:@"GET"];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        if ( [data length] > 0 && !error ) { // Success
            
            NSDictionary *appData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                // All versions that have been uploaded to the AppStore
                NSArray *versionsInAppStore = [[appData valueForKey:@"results"] valueForKey:@"version"];
                
                if ( ![versionsInAppStore count] ) { // No versions of app in AppStore
                    return;
                    
                } else {
                    //已经上架的APP的版本号
                    NSString *versionInAppStore = [versionsInAppStore objectAtIndex:0];
                    rAppStoreVersion=versionInAppStore;
                }
                //回调
                pDoFunctionCallBack(rLocalAppVersion,rAppStoreVersion,rDowloadUrl);
            });
        }
    }];

}
//方法二：（推荐）
+(BOOL) needUpdateAppVersionLocal:(NSString *) pLocalAppVersion mToAppVersion:(NSString *) pStoreAppVersion
{
    BOOL rNeedUpDate=false;
    //版本号比较
    if ([pStoreAppVersion compare:pLocalAppVersion options:NSNumericSearch] == NSOrderedDescending)
    {//softVersionString 版本高 新版本
        rNeedUpDate=true;
    }
    else
    {//app_Version 老版本高（不处理）
        rNeedUpDate=false;
    }
    return rNeedUpDate;
}
+(NSString *) urlForUpdateApp
{
    
    //app的数字ID
    NSString * plist = [[NSBundle mainBundle] pathForResource:@"Common-Configuration" ofType:@"plist"];
    NSDictionary * dic = [NSDictionary dictionaryWithContentsOfFile:plist];
    NSString *appleID = dic[@"AppleID"];
    
    //已经上架的APP的URL
    NSString *trackViewUrl = [NSString stringWithFormat:@"https://itunes.apple.com/app/id%@", appleID];
//    NSURL *url= [NSURL URLWithString:trackViewUrl];
//    [[UIApplication sharedApplication] openURL:url];
    return trackViewUrl;
}
//弹出下载框
+(void) doGoAppStoreToUpdateNewVersion:(NSString *) pNewVersion mDownloadUrl:(NSString *)pDownloadUrl;
{
    MyButtonItem *okButtonItem = [[MyButtonItem alloc] initWithTitleCallBack:_LS_(@"kMddToastAppUpdateDownload", nil) mCallBack:^{
        NSLog(@"回调确定");
        //已经上架的APP的URL
        NSURL *url= [NSURL URLWithString:pDownloadUrl];
        [[UIApplication sharedApplication] openURL:url];
    }];
    
    MyButtonItem *cancelButtonItem = [[MyButtonItem alloc] initWithTitleCallBack:_LS_(@"kMddToastTipsCancel", nil) mCallBack:^{
        NSLog(@"回调取消");
    }];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:_LS_(@"kMddToastAppUpdateTitle", nil) message:[NSString stringWithFormat:_LS_(@"kMddToastAppUpdateMsg", nil),pNewVersion] cancelButtonItem:cancelButtonItem otherButtonItems:okButtonItem, nil];
    [alert show];
    
}
+(void)setCFBundleDevelopmentRegion:(NSString *)pStr
{
    NSString * tStr=@"en";
    if(pStr!=nil)
    {
        tStr=pStr;
    }
//CFBundleDevelopmentRegion
    [[UIDevice currentDevice] setValue:tStr forKey:@"CFBundleDevelopmentRegion"];
}
+(void)setCFBundleDevelopmentRegionSys
{
    
    NSString * rLanguage=@"";
    NSArray *languages = [NSLocale preferredLanguages];
    rLanguage = [languages objectAtIndex:0];
//     [[UIDevice currentDevice] set];
}
/*
 http://blog.csdn.net/chaoyuan899/article/details/19831029
 (4)字符串相关：BEGINSWITH、ENDSWITH、CONTAINS
 例：@"name CONTAIN[cd] 'ang'"   //包含某个字符串
 @"name BEGINSWITH[c] 'sh'"     //以某个字符串开头
 @"name ENDSWITH[d] 'ang'"      //以某个字符串结束
 注:[c]不区分大小写[d]不区分发音符号即没有重音符号[cd]既不区分大小写，也不区分发音符号。
 */

#pragma mark 本地化
static NSBundle *bundle = nil;

+ ( NSBundle * )bundle{
    
    return bundle;
    
}
+(void)initUserLanguage{
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    
    NSString *string = [def valueForKey:@"userLanguage"];
    
    if(string.length == 0){
        
        //获取系统当前语言版本(中文zh-Hans,英文en)
        
        NSArray* languages = [def objectForKey:@"AppleLanguages"];
        
        NSString *current = [languages objectAtIndex:0];
        
        string = current;

        
        [def setValue:current forKey:@"userLanguage"];

        
        [def synchronize];//持久化，不加的话不会保存
        [StoreService setValueForName:@"currentLang" value:string];
    }
    
    //获取文件路径
    NSString *path = [[NSBundle mainBundle] pathForResource:string ofType:@"lproj"];
    
    bundle = [NSBundle bundleWithPath:path];//生成bundle
}
+(NSArray *)getUserLangArr
{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
//    NSString *string = [def valueForKey:@"userLanguage"];
    NSArray* languages = [def objectForKey:@"AppleLanguages"];;
    return languages;
}
+(NSString *)userLanguage{
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    
    NSString *language = [def valueForKey:@"userLanguage"];
    
    return language;
}
+(NSString *)userLanguageConfig //获取应用当前语言
{
   NSString *language= [StoreService  getValueForName:@"currentLang"];
    return language;
}

+(void)setUserlanguage:(NSString *)language{
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    
    //1.第一步改变bundle的值
    NSString *path = [[NSBundle mainBundle] pathForResource:language ofType:@"lproj" ];
    
    bundle = [NSBundle bundleWithPath:path];
    
    //2.持久化
    [def setValue:language forKey:@"userLanguage"];
    
    [def synchronize];
    
    [StoreService setValueForName:@"currentLang" value:language];
}

@end
