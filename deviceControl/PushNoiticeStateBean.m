//
//  PushNoiticeStateBean.m
//  ChildrenLocation
//
//  Created by szalarm on 15/10/14.
//  Copyright © 2015年 szalarm. All rights reserved.
//

#import "PushNoiticeStateBean.h"
//引用头文件
#import <UIKit/UIApplication.h>
#import <UIKit/UIUserNotificationSettings.h>

@implementation PushNoiticeStateBean


-(id)initWithDataVersion:(float)pSysVersion mCurrentState:(int)pCurrentState
{
    if (self=[super init]) {
        self.mSysVersion=pSysVersion;
        self.mCurrentState=pCurrentState;
    }
    return self;
}



@end
