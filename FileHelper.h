//
//  FileHelper.h
//  onemap
//
//  Created by 月光 on 15/3/26.
//  Copyright (c) 2015年 肖光. All rights reserved.
//

#import <Foundation/Foundation.h>
//下载
#import "DownLoadHelper.h"
//上传
#import "UploadFile.h"

//文件操作工具类
@interface FileHelper : NSObject

#pragma mark 读取方法
-(NSString *)dirResource;
-(NSString *)dirResource :(NSString *)pfilePath;
-(NSString *)dirHome;
-(NSString *)dirDoc;
-(NSString *)dirDoc :(NSString *) pFilePath;
-(NSString *)dirLib;
-(NSString *)dirCache;
-(NSString *)dirTmp;
#pragma mark 创建方法
//创建文件夹
-(BOOL)createDir:(NSString *)pFolderName;
//创建文本文件
-(BOOL)createFile:(NSString *)pFileShortName folderName:(NSString *)pFolderName;
//写文本到文件
-(BOOL)writeFile:(NSString *)pFileShortName folderName:(NSString *)pFolderName contentString:(NSString *)pContentString;
//读取文件
-(NSString *) readFile:(NSString *)pFileShortName folderName:(NSString *)pFolderName;
//获取文件属性
-(NSDictionary *) getfileAttriutes:(NSString *)pFileShortName folderName:(NSString *)pFolderName;
//删除文件
-(BOOL)deleteFile:(NSString *)pFileShortName folderName:(NSString *)pFolderName;
//删除某个路径下的文件
-(BOOL)deleteFileWithFullPath:(NSString *)pFilePath;
//接收数据保存到文件(同步请求)
-(BOOL)downloadFileWithURL:(NSString *) pURL saveFilePath:(NSString *)pSaveFilePath;
//接收数据保存到文件(异步请求)
-(void)downloadFileWithURLAscInDocument:(NSString *) pURL fileShortName:(NSString *)pFileShortName folderName:(NSString *)pFolderName;
//接收数据保存到文件(异步请求)
-(void)downloadFileWithURLAsc:(NSString *) pURL fileFullPath:(NSString *)pfileFullPath;
//保存流到文件
-(BOOL)downloadFileWithDataInDocument:(NSData *) pData saveFilePath:(NSString *)pSaveFilePath;
//保存流到文件
-(BOOL)downloadFileWithData:(NSData *) pData saveFilePath:(NSString *)pSaveFilePath;
//上传文件到网址
-(BOOL) uploadFileWithPath:(NSString *) pFilePath serverURL:(NSString *)pURL mFileName:(NSString *) pFileNAme;
//上传流到网址
-(BOOL) uploadFileWithData:(NSData *) pData serverURL:(NSString *)pURL mFileName:(NSString *) pFileName;
//上传文件到网址
-(void) uploadFileWithPath:(NSString *) pFilePath serverURL:(NSString *)pURL mFileName:(NSString *) pFileNAme success:(void(^)(id pResult)) pSuccessHandler error:(void(^)(NSException *pError))pErrorHandler;
//上传流到网址
-(void) uploadFileWithData:(NSData *) pData serverURL:(NSString *)pURL mFileName:(NSString *) pFileName success:(void(^)(id pResult)) pSuccessHandler error:(void(^)(NSException *pError))pErrorHandler;
//复写
//上传流到网址
-(void) uploadFileExtWithData:(NSData *) pData serverURL:(NSString *)pURL mFileName:(NSString *) pFileName mExt:(id )pExt success:(void(^)(id pResult,id pExt)) pSuccessHandler error:(void(^)(NSException *pError))pErrorHandler;

#pragma  mark 路径转换
//路径截取
-(NSString *) convertPathToFilename:(NSString *) pFilePath;
//路径拚串到资源文件夹下
-(NSString *) convertToResourcePathFileShortName:(NSString *) pFileShortName folderName:(NSString *)pFolderName;
//路径拚串到文档文件夹下
-(NSString *) convertToDocumentPathFileShortName:(NSString *) pFileShortName folderName:(NSString *)pFolderName;
//通过路径获取文件名
-(NSString *) converPathToShortName:(NSString *) fileName;
#pragma  mark 判断方法
//文件资源是否存在
-(BOOL) fileIsExistByPath:(NSString *) pFilePath;
-(BOOL) fileIsExistByPathInDoc:(NSString *) pFilePath;
-(BOOL) fileIsExistByPathInResource:(NSString *) pFilePath;
-(BOOL) fileIsExistByPathApp:(NSString *) pAppfilePath type:(NSString *) pType;
+(BOOL) fileIsExistByPathApp:(NSString *) pAppfilePath type:(NSString *) pType;
#pragma  mark 移动方法
//从文文件夹件拷贝到新的文件夹(源全路径，目标全路径)
-(BOOL) moveDirToFrom:(NSString *) pFromDir ToDir:(NSString *) pToDir;
//从文件夹到文档(源路径，目标文件夹)
-(BOOL) moveDirToDocumentFrom:(NSString *)pFrom ToFolder:(NSString *)pToFolder;
//从项目资源文件夹迁移
-(BOOL) moveProjectFolderToDocumentFrom:(NSString *)pFromFolder ToFolder:(NSString *)pToFolder;

//拷贝整个文件夹（源路径，目标路径，源路径前缀）
-(BOOL) CopyDirectory:(NSString *) pSrcdir desdir:(NSString*) pDesdir ;
//文件夹拷贝
-(BOOL) CopyDirectory:(NSString *) pSrcdir desdir:(NSString*) pDesdir fileManager:(NSFileManager *)pFileManager;
#pragma mark others
//获取系统当前时间
-(NSString*)GetCurrentTimeString;
-(NSString*)GetCurrentLongTimeString;
-(NSString*)GetDateTimeString;

@end
