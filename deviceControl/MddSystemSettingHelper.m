//
//  MddSystemSettingHelper.m
//  ChildrenLocation
//
//  Created by szalarm on 15/10/14.
//  Copyright © 2015年 szalarm. All rights reserved.
//

#import "MddSystemSettingHelper.h"


#ifndef ChildrenLocation_MddSystemSettingHelper_h
#define ChildrenLocation_MddSystemSettingHelper_h
    //获取IOS版本
    #define IOS_VERSION [[[UIDevice currentDevice]systemVersion]floatValue]
#endif
@implementation MddSystemSettingHelper

+(void) openSystemSetting
{
    if(IOS_VERSION<8.0)
    {
        //不支持
    }else if(IOS_VERSION>=8.0)
    {
        /*app-settings:*/
        NSLog(@"UIApplicationOpenSettingsURLString:%@",UIApplicationOpenSettingsURLString);
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        
    }

}
+(BOOL)canReciverPush
{
    BOOL result=false;
    //ios7系统
    if (IOS_VERSION<8.0) {
        //0不接受，其他接收
       int sysType =[[UIApplication sharedApplication] enabledRemoteNotificationTypes];
        //不能接收推送，不为0时可以接收推送，是个枚举型
        if (sysType!=0) {
            result=true;
        }
        NSLog(@"type:%d",sysType);
    }
   else if(IOS_VERSION>=8.0)
    {
        //ios8以上系统
        int fSystype=[[UIApplication sharedApplication] currentUserNotificationSettings].types;
        if (fSystype!=0) {
            result=true;
        }
          NSLog(@"fSystype:%d",fSystype);
    }
    
    //不能接收推送，不为0时可以接收推送，是个枚举型
    return result;
}


+(PushNoiticeStateBean *) pushState
{
    PushNoiticeStateBean * result;
    //ios7系统
    if (IOS_VERSION<8.0) {
        //0不接受，其他接收
        int sysType =[[UIApplication sharedApplication] enabledRemoteNotificationTypes];
        //不能接收推送，不为0时可以接收推送，是个枚举型
        result=[[PushNoiticeStateBean alloc] initWithDataVersion:IOS_VERSION mCurrentState:sysType];
    }
    else if(IOS_VERSION>=8.0)
    {
        //ios8以上系统
        int fSystype=[[UIApplication sharedApplication] currentUserNotificationSettings].types;
        result=[[PushNoiticeStateBean alloc] initWithDataVersion:IOS_VERSION mCurrentState:fSystype];
    }

    return result;

}

+(NSString *)intToBinary:(int)intValue{
    int byteBlock = 8,    // 每个字节8位
    totalBits = sizeof(int) * byteBlock, // 总位数（不写死，可以适应变化）
    binaryDigit = 1;  // 当前掩（masked）位
    NSMutableString *binaryStr = [[NSMutableString alloc] init];   // 二进制字串
    do
    {
        // 检出下一位，然后向左移位，附加 0 或 1
        [binaryStr insertString:((intValue & binaryDigit) ? @"1" : @"0" ) atIndex:0];
        // 若还有待处理的位（目的是为避免在最后加上分界符），且正处于字节边界，则加入分界符|
        if (--totalBits && !(totalBits % byteBlock))
            [binaryStr insertString:@"|" atIndex:0];
        // 移到下一位
        binaryDigit <<= 1;
    } while (totalBits);
    // 返回二进制字串
    return binaryStr;
}


//不生效
+(void) savePushState:(PushNoiticeStateBean *) pState
{
    [self doLogoutPush];
    //先注销再注册
    NSLog(@"显示推送");
    // Required
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_7_1
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
//        [APService registerForRemoteNotificationTypes:pState.mCurrentState categories:nil];
    } else {
        //categories 必须为nil
//        [APService registerForRemoteNotificationTypes:pState.mCurrentState categories:nil];
    }
#else
    //categories 必须为nil
//    [APService registerForRemoteNotificationTypes:pState.mCurrentState categories:nil];
#endif



}


//注销推送
+(void) doLogoutPush
{
    NSLog(@"注销推送");


#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_7_1
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
//        [APService registerForRemoteNotificationTypes:(UIUserNotificationTypeNone)categories:nil];
    } else {
        //categories 必须为nil
//        [APService registerForRemoteNotificationTypes:(UIUserNotificationTypeNone) categories:nil];
    }
#else
    //categories 必须为nil
//    [APService registerForRemoteNotificationTypes:(UIUserNotificationTypeNone) categories:nil];
#endif
    
}

/*
 #if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_7_1
 if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
 //可以添加自定义categories
 UIUserNotificationSettings *notificationSettings=  [UIUserNotificationSettings settingsForTypes:(pState.mCurrentState) categories:nil];
 //        [APService registerForRemoteNotificationTypes:pState.mCurrentState categories:nil];
 [[UIApplication sharedApplication] registerUserNotificationSettings:notificationSettings ];
 
 } else {
 //categories 必须为nil
 //        [APService registerForRemoteNotificationTypes:pState.mCurrentState categories:nil];
 [[UIApplication sharedApplication] registerForRemoteNotificationTypes:pState.mCurrentState];
 }
 #else
 //categories 必须为nil
 //    [APService registerForRemoteNotificationTypes:pState.mCurrentState categories:nil];
 [[UIApplication sharedApplication] registerForRemoteNotificationTypes:pState.mCurrentState];
 #endif
 
 */

//注册推送
-(void) doLoginPush
{
    NSLog(@"显示推送");
    // Required
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_7_1
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
//        [APService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge | UIUserNotificationTypeSound |UIUserNotificationTypeAlert)categories:nil];
    } else {
        //categories 必须为nil
//        [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |UIRemoteNotificationTypeSound |UIRemoteNotificationTypeAlert) categories:nil];
    }
#else
    //categories 必须为nil
//    [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |UIRemoteNotificationTypeSound |UIRemoteNotificationTypeAlert) categories:nil];
#endif
}

// 设置本地通知
+ (void)registerLocalNotification:(NSInteger)alertTime mTitle:(NSString *) pTitle mBody:(NSString *) pBody  mKey:(NSString *) pKey mOtherDic:(NSDictionary *) pDic
{
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    // 设置触发通知的时间
    NSDate *fireDate = [NSDate dateWithTimeIntervalSinceNow:alertTime];
    NSLog(@"fireDate=%@",fireDate);
    
    notification.fireDate = fireDate;
    // 时区
    notification.timeZone = [NSTimeZone defaultTimeZone];
    // 设置重复的间隔
    notification.repeatInterval = kCFCalendarUnitSecond;
    
    // 通知内容
    notification.alertBody =  pBody;
    notification.applicationIconBadgeNumber = 1;
    // 通知被触发时播放的声音
    notification.soundName = UILocalNotificationDefaultSoundName;
    // 通知参数
    NSMutableDictionary *userDict = [NSMutableDictionary dictionary];
    [userDict setObject:pKey forKey:@"key"];
    [userDict setObject:[NSString stringWithFormat:@"%@\n%@",pTitle,pBody] forKey:@"msg"];
    
    if (nil!=pDic) {
            [userDict setObject:pDic forKey:@"other"];
    }
    notification.userInfo = userDict;
    
    // ios8后，需要添加这个注册，才能得到授权
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        UIUserNotificationType type =  UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:type
                                                                                 categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        // 通知重复提示的单位，可以是天、周、月
        notification.repeatInterval = NSCalendarUnitDay;
    } else {
        // 通知重复提示的单位，可以是天、周、月
        notification.repeatInterval = NSDayCalendarUnit;
    }
    
    // 执行通知注册
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
}

// 取消某个本地推送通知
+ (void)cancelLocalNotificationWithKey:(NSString *)key {
    // 获取所有本地通知数组
    NSArray *localNotifications = [UIApplication sharedApplication].scheduledLocalNotifications;
    
    for (UILocalNotification *notification in localNotifications) {
        NSDictionary *userInfo = notification.userInfo;
        if (userInfo) {
            // 根据设置通知参数时指定的key来获取通知参数
            NSString *info = userInfo[key];
            
            // 如果找到需要取消的通知，则取消
            if (info != nil) {
                [[UIApplication sharedApplication] cancelLocalNotification:notification];
                break;
            }
        }
    }
}
+ (void)clearcancelLocalNotificationAll
{
    // 获取所有本地通知数组
    NSArray *localNotifications = [UIApplication sharedApplication].scheduledLocalNotifications;
            NSLog(@"清空");
    for (UILocalNotification *notification in localNotifications) {

        NSDictionary *userInfo = notification.userInfo;
        if (userInfo) {
           [[UIApplication sharedApplication] cancelLocalNotification:notification];
        }
    }
}
+(void)clearAppBudge
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kNtfName_LocalPushClear object:nil];
}
/*
 
 
 
 ios 7
 typedef NS_OPTIONS(NSUInteger, UIRemoteNotificationType) {
 UIRemoteNotificationTypeNone    = 0,
 UIRemoteNotificationTypeBadge   = 1 << 0,
 UIRemoteNotificationTypeSound   = 1 << 1,
 UIRemoteNotificationTypeAlert   = 1 << 2,
 UIRemoteNotificationTypeNewsstandContentAvailability = 1 << 3,
 }
 
 ios 8
 typedef NS_OPTIONS(NSUInteger, UIUserNotificationType) {
 UIUserNotificationTypeNone    = 0,      // the application may not present any UI upon a notification being received
 UIUserNotificationTypeBadge   = 1 << 0, // the application may badge its icon upon a notification being received
 UIUserNotificationTypeSound   = 1 << 1, // the application may play a sound upon a notification being received
 UIUserNotificationTypeAlert   = 1 << 2, // the application may display an alert upon a notification being received
 } NS_ENUM_AVAILABLE_IOS(8_0);
 */

/*
 NSURL*url=[NSURL URLWithString:@"command stringI"];
 [[UIApplication sharedApplication] openURL:url];
 即可跳转到设置页面的对应项:command string:
 以下是内置的Settings的URL Scheme：
 
 About — prefs:root=General&path=About
 Accessibility — prefs:root=General&path=ACCESSIBILITY
 Airplane Mode On — prefs:root=AIRPLANE_MODE
 Auto-Lock — prefs:root=General&path=AUTOLOCK
 Brightness — prefs:root=Brightness
 Bluetooth — prefs:root=General&path=Bluetooth
 Date & Time — prefs:root=General&path=DATE_AND_TIME
 FaceTime — prefs:root=FACETIME
 General — prefs:root=General
 Keyboard — prefs:root=General&path=Keyboard
 iCloud — prefs:root=CASTLE
 iCloud Storage & Backup — prefs:root=CASTLE&path=STORAGE_AND_BACKUP
 International — prefs:root=General&path=INTERNATIONAL
 Location Services — prefs:root=LOCATION_SERVICES
 Music — prefs:root=MUSIC
 Music Equalizer — prefs:root=MUSIC&path=EQ
 Music Volume Limit — prefs:root=MUSIC&path=VolumeLimit
 Network — prefs:root=General&path=Network
 Nike + iPod — prefs:root=NIKE_PLUS_IPOD
 Notes — prefs:root=NOTES
 Notification — prefs:root=NOTIFICATIONS_ID
 Phone — prefs:root=Phone
 Photos — prefs:root=Photos
 Profile — prefs:root=General&path=ManagedConfigurationList
 Reset — prefs:root=General&path=Reset
 Safari — prefs:root=Safari
 Siri — prefs:root=General&path=Assistant
 Sounds — prefs:root=Sounds
 Software Update — prefs:root=General&path=SOFTWARE_UPDATE_LINK
 Store — prefs:root=STORE
 Twitter — prefs:root=TWITTER
 Usage — prefs:root=General&path=USAGE
 VPN — prefs:root=General&path=Network/VPN
 Wallpaper — prefs:root=Wallpaper
 Wi-Fi — prefs:root=WIFI
 
 需要注意的是：这种方式只支持iOS 5.0的系统，从iOS 5.1开始，苹果已经移除了prefs:这个URL Scheme。
 */


@end
