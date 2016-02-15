//
//  DownLoadHelper.h
//  onemap
//
//  Created by 月光 on 15/3/26.
//  Copyright (c) 2015年 肖光. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark 定义blocks
//初始化进度
typedef void (^initProgress)(long long initValue);
//下载数据
typedef void (^loadedData)(long long loadedLength);

@interface DownLoadHelper : NSObject<NSURLConnectionDataDelegate>
#pragma mark 属性
@property (strong) NSURL *httpURL;
@property (copy) void (^initProgress)(long long initValue);
@property (copy) void (^loadedData)(long long loadedLength);
//另存为本地路径
@property (strong) NSString *saveAsFilePath;
#pragma  mark 方法
+(DownLoadHelper *) initWithURL:(NSURL *) url;
-(void) startAsyn;
//设置保存在document中
-(void) setSavePath:(NSString *) pLocalFolder shortFileName:(NSString *) pShortFileName;
//保存在自定义路径中
-(void) setFullSavePath:(NSString *) pFullFilePath;

//执行结束
//-(void) connectionDidFinishLoading:(NSURLConnection *)connection success:(void(^)(id pResult))pSuccessHandler;

@end