//
//  MddDeviceInfoHelper.h
//  ChildrenLocation
//
//  Created by szalarm on 15/10/14.
//  Copyright © 2015年 szalarm. All rights reserved.
//

#import <Foundation/Foundation.h>


/*
 依赖库CoreTelephony这个private framework
 获取设备信息
 */
@interface MddDeviceInfoHelper : NSObject

#pragma mmark 信息字典

//信息
+(NSMutableDictionary *) infoForDiviceDic;
//手机序列号

+(NSString *) DevInfoidentifierNumber;
+(NSString *) DevInfophoneVersion;
+(NSString *) DevInfophoneModel;
+(NSString *) DevInfolocalPhoneModel;



//获取手机号
//+(NSString *)myNumber;

//获取设备
+(UIDevice *) myUIDevice;
//获取手机信息
+(NSMutableDictionary *)infoForSim;
//设备简介
+(void) DeviceInfo;

//获取系统语言
+(NSString *) getMddCurrentVersion;
//是否是主要区中文(是否简体中文>y or n)
+(BOOL) getMddCurrentVersionIszh_Hans_CN;
//获取应用版本号码1.0.0之类东西
+(NSString *) getMddAppVersion;
#pragma mark 标志位
//获取状态位
+(int) getMddCurrentVersionCode;
//弹出提示那个语言
+(int) getCurrentCode;
//检查更新
#pragma mark - 方法1(异步请求)，APP检查更新
//获取应用信息
+(void)dicForcheckAppToUpdateInfFucation:(void(^)(NSMutableDictionary * pResultDic))pDoFunctionCallBack;
//判断更新
+(void)getCheckAppToUpdateInfFucation:(void(^)(NSString * rLocalVersion ,NSString * rAppStoreVersion,NSString * rDownloadUrl))pDoFunctionCallBack;
//判断字符串1跟字符串2的版本
+(BOOL) needUpdateAppVersionLocal:(NSString *) pLocalAppVersion mToAppVersion:(NSString *) pStoreAppVersion;
//苹果下载地址
+(NSString *) urlForUpdateApp;
//更新
+(void) doGoAppStoreToUpdateNewVersion:(NSString *) pNewVersion mDownloadUrl:(NSString *)pDownloadUrl;
//设置语言区域
+(void) setCFBundleDevelopmentRegion:(NSString *) pStr;
//跟随系统设置语言区域
+(void) setCFBundleDevelopmentRegionSys;
#pragma mark 本地化
+(NSBundle *)bundle;//获取当前资源文件

+(void)initUserLanguage;//初始化语言文件

+(NSString *)userLanguage;//获取应用当前语言
+(NSString *)userLanguageConfig;//获取应用当前语言
+(NSArray *) getUserLangArr;
+(void)setUserlanguage:(NSString *)language;//设置当前语言

@end
