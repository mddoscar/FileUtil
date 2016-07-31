//
//  MddSystemSettingHelper.h
//  ChildrenLocation
//
//  Created by szalarm on 15/10/14.
//  Copyright © 2015年 szalarm. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PushNoiticeStateBean.h"
//推送
//#import "APService.h"

/*
 系统设置帮助
 */
@interface MddSystemSettingHelper : NSObject

#pragma mark public static
+(void) openSystemSetting;

//推送状态
+(BOOL) canReciverPush;

//获取推送设置
+(PushNoiticeStateBean *) pushState;

//设置推送配置（设置不起作用）
+(void) savePushState:(PushNoiticeStateBean *) pState;

//获取二进制字符串
+ (NSString *)intToBinary:(int)intValue;

// 设置本地通知
+ (void)registerLocalNotification:(NSInteger)alertTime mTitle:(NSString *) pTitle mBody:(NSString *) pBody  mKey:(NSString *) pKey mOtherDic:(NSDictionary *) pDic;
+ (void)cancelLocalNotificationWithKey:(NSString *)key;
+ (void)clearcancelLocalNotificationAll;
+(void) clearAppBudge;

@end
