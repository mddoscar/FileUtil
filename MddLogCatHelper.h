//
//  MddLogCatHelper.h
//  ChildrenLocation
//
//  Created by szalarm on 16/2/19.
//  Copyright © 2016年 szalarm. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
    日志帮助文件
 */
@interface MddLogCatHelper : NSObject

#pragma mark ctor
//默认路径
-(id) init;
//写日志到文档文件xxx.txt
-(id) initWithLogDocPath:(NSString *) pPathFile;
//写日志到文档文件doc/xxx.txt
-(id) initWithLogFullPath:(NSString *) pPathFile;
#pragma mark func
//写入文件
-(void) WritelogCatWithCommonTagMsg:(NSString *)pMsg;
//写入文件
-(void) WritelogCatWithTag:(NSString *) pTag mMsg:(NSString *)pMsg;
//错误
-(void) WritelogCatWithTagError:(NSString *) pTag mWithError:(NSError *)err;
//错误
-(void) WritelogCatWithTagError:(NSString *) pTag mWithNSException:(NSException *)err;
//读取日志
-(NSString*) ReadlogCatFromPath:(NSString *)pPath;
//从文档获取日志
-(NSString *) ReadlogCatFromDocPath:(NSString *)pPath;
//清除日志
-(void) ClearlogCatFromFullPath:(NSString *)pPath;
-(void) ClearlogCatFromDicPath:(NSString *)pDocPath;
//删除默认日志
-(void) ClearDefLogCatFromPath;
#pragma mark common
//标志
-(NSString *) commonTag;
//获取文件
-(NSString *)dataPath:(NSString *)pFilePath;
//今天路径
-(NSString *)todayPath;
//今天相对路径
-(NSString *)todayRelationPath;
//根目录文件夹
-(NSString *)rootDir;
//默认路径
-(NSString *)defLogPath;
//默认日志
-(NSString *)defReadlogCatFromPath;

@end
