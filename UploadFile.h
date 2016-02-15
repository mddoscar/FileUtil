//
//  UploadFile.h
//  ChildrenLocation
//
//  Created by szalarm on 15/8/27.
//  Copyright (c) 2015年 szalarm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UploadFile : NSObject

#pragma mark - 上传文件
//单文件下载
- (void)uploadFileWithURL:(NSURL *)url data:(NSData *)data fileName:(NSString *) pFileName;
//下载
- (void)uploadFileWithURL:(NSURL *)url data:(NSData *)data fileName:(NSString *) pFileName success:(void(^)(id pResult)) pSuccessHandler error:(void(^)(NSException *pError))pErrorHandler;

//
- (void)uploadFileWithHost:(NSString  *)pUrl fileName:(NSString *)pFileName mFilePath:(NSString *) pPath;

@end
