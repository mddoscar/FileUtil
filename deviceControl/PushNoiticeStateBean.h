//
//  PushNoiticeStateBean.h
//  ChildrenLocation
//
//  Created by szalarm on 15/10/14.
//  Copyright © 2015年 szalarm. All rights reserved.
//

#import <Foundation/Foundation.h>


/*
 推送状态位实体
 */
@interface PushNoiticeStateBean : NSObject

//系统版本
@property (assign,nonatomic) float mSysVersion;
//当前设置值
@property (assign,nonatomic) int mCurrentState;

#pragma mark 构造函数
-(id) initWithDataVersion:(float) pSysVersion mCurrentState:(int) pCurrentState;



@end
