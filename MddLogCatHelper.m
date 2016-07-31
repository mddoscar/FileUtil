//
//  MddLogCatHelper.m
//  ChildrenLocation
//
//  Created by szalarm on 16/2/19.
//  Copyright © 2016年 szalarm. All rights reserved.
//

#import "MddLogCatHelper.h"
//默认标志
#define kCommonTagI @"info"
#define kCommonTagE @"err"
#define kCommonTagC @"crash"
//默认地址
#define kBaseDir @"res/mddlog/"
//引用文件
#import "FileHelper.h"
#import "DbDateHelper.h"

@interface MddLogCatHelper()
{
    FileHelper * gFileHelper;
    DbDateHelper *gDbDateHelper;
}
//文件路径
@property (nonatomic,copy) NSString * mFilePath;
@end

@implementation MddLogCatHelper
@synthesize mFilePath;

#pragma mark ctor
-(id) init
{
    if(self=[super init])
    {
        if (gFileHelper==nil) {
            gFileHelper=[FileHelper new];
        }
        //时间
        if (gDbDateHelper==nil) {
            gDbDateHelper=[DbDateHelper new];
        }
        //默认路径
        self.mFilePath=[self todayPath];
        //不存在就创建(这个只能建目录，不要文件)
        //self.mFilePath=[self dataPath:self.mFilePath];
    }
    return self;
}

//写日志到文档文件xxx.txt
-(id) initWithLogDocPath:(NSString *) pPathFile
{
    if (self=[super init]) {
        if (gFileHelper==nil) {
            gFileHelper=[FileHelper new];
        }
        //时间
        if (gDbDateHelper==nil) {
            gDbDateHelper=[DbDateHelper new];
        }
        self.mFilePath=[gFileHelper dirDoc:pPathFile];
        //不存在就创建
        //self.mFilePath=[self dataPath:self.mFilePath];
    }
    return self;
}
//写日志到文档文件doc/xxx.txt
-(id) initWithLogFullPath:(NSString *) pPathFile
{
    if (self=[super init]) {
        if (gFileHelper==nil) {
            gFileHelper=[FileHelper new];
        }
        //时间
        if (gDbDateHelper==nil) {
            gDbDateHelper=[DbDateHelper new];
        }
        self.mFilePath=pPathFile;
        //不存在就创建
        self.mFilePath=[self dataPath:self.mFilePath];
    }
    return self;
}
#pragma mark func
//写入文件
-(void) WritelogCatWithCommonTagMsg:(NSString *)pMsg
{
    [self WritelogCatWithTag:[self commonTag] mMsg:pMsg];
}
//写入文件
-(void) WritelogCatWithTag:(NSString *) pTag mMsg:(NSString *)pMsg
{
    NSString * tAppendStr=[NSString stringWithFormat:@"tag:%@,date:%@\r\n msg:%@",pTag,[gDbDateHelper GetDateString],pMsg];
    NSString * OldStr=[self ReadlogCatFromPath:self.mFilePath];
    //第一次
    if (OldStr==nil) {
        OldStr=@"";
    }
    OldStr=[OldStr stringByAppendingString:tAppendStr];
    [gFileHelper writeFileFullPath:self.mFilePath contentString:OldStr];
}
//错误
-(void) WritelogCatWithTagError:(NSString *) pTag mWithError:(NSError *)err
{
    [self WritelogCatWithTag:pTag mMsg:[err description]];
}
//错误
-(void) WritelogCatWithTagError:(NSString *) pTag mWithNSException:(NSException *)err
{
    [self WritelogCatWithTag:pTag mMsg:[err description]];
}
//读取日志
-(NSString *) ReadlogCatFromPath:(NSString *)pPath
{
    return [gFileHelper readFileFullPath:pPath];
}
-(NSString *) ReadlogCatFromDocPath:(NSString *)pPath
{
    return [gFileHelper readFileFullPath:[gFileHelper dirDoc:pPath]];
}
-(void) ClearDefLogCatFromPath
{
    [self ClearlogCatFromFullPath:self.mFilePath];
}
-(void) ClearlogCatFromFullPath:(NSString *)pPath
{

    [gFileHelper deleteFileWithFullPath:pPath];
    //重新放一个进去
    self.mFilePath=[self todayPath];
}
-(void) ClearlogCatFromDicPath:(NSString *)pDocPath
{
    [self ClearlogCatFromFullPath:[gFileHelper dirDoc:pDocPath]];
}
#pragma mark common
//标志
-(NSString *) commonTag
{
    return kCommonTagI;
}
-(NSString *)dataPath:(NSString *)pFilePath
{
    NSError * error=nil;
    BOOL bo = [[NSFileManager defaultManager] createDirectoryAtPath:pFilePath withIntermediateDirectories:YES attributes:nil error:&error];
//    NSAssert(bo,@"创建目录失败");
    if (bo) {
        NSLog(@"创建目录成功");
    }else
    {
        NSLog(@"创建目录失败%@",[error description]);
    }
    return pFilePath;
}
-(NSString *)todayPath
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *strDate = [dateFormatter stringFromDate:[NSDate date]];
    NSString * todayDir=[NSString stringWithFormat:@"%@.log",strDate];
    
    NSString * tDocDir=[gFileHelper dirDoc:[self rootDir]];
    //新建文件夹
    tDocDir=[self dataPath:tDocDir];
    //最终路径
    NSString * rToDayDir=[NSString stringWithFormat:@"%@%@",[self rootDir],todayDir];
    return [gFileHelper dirDoc:rToDayDir];
}
-(NSString *)todayRelationPath
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *strDate = [dateFormatter stringFromDate:[NSDate date]];
    NSString * todayDir=[NSString stringWithFormat:@"%@.log",strDate];
    
    NSString * tDocDir=[gFileHelper dirDoc:[self rootDir]];
    //新建文件夹
    tDocDir=[self dataPath:tDocDir];
    //最终路径
    NSString * rToDayDir=[NSString stringWithFormat:@"%@%@",[self rootDir],todayDir];
    return rToDayDir;
}
//根目录文件夹
-(NSString *)rootDir
{
    return kBaseDir;
}
//默认路径
-(NSString *)defLogPath
{
    return self.mFilePath;
}
//默认日志
-(NSString *)defReadlogCatFromPath
{
    return [self ReadlogCatFromPath:[self defLogPath]];
}
@end
