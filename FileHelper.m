//
//  FileHelper.m
//  onemap
//
//  Created by 月光 on 15/3/26.
//  Copyright (c) 2015年 肖光. All rights reserved.
//

#import "FileHelper.h"


//
#define kYes @"Y" //是
#define kNo @"N" //非
@implementation FileHelper


//资源文件路径
-(NSString *)dirResource
{
    NSString *defaultDBPath = [[NSBundle mainBundle] resourcePath];
//    NSLog(@"resource:%@",defaultDBPath);
    return defaultDBPath;
}
//文件资源路径
-(NSString *)dirResource :(NSString *)pfilePath
{
    NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:pfilePath];
//    NSLog(@"resource:%@",defaultDBPath);
    return  defaultDBPath;
}
//获取home目录
-(NSString *)dirHome{
    NSString *result=NSHomeDirectory();
//    NSLog(@"app_home: %@",result);
    return result;
}
//获取Documents目录
-(NSString *)dirDoc{
    //[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
//    NSLog(@"app_home_doc: %@",documentsDirectory);
    return documentsDirectory;
}
//文件文档路径
-(NSString *)dirDoc :(NSString *) pFilePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString * result=[documentsDirectory stringByAppendingPathComponent:pFilePath];
//    NSLog(@"app_home_doc: %@",result);
    return result;
}

//获取Library目录
-(NSString *)dirLib{
    //[NSHomeDirectory() stringByAppendingPathComponent:@"Library"];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *libraryDirectory = [paths objectAtIndex:0];
//    NSLog(@"app_home_lib: %@",libraryDirectory);
    return  libraryDirectory;
}

//获取Cache目录
-(NSString *)dirCache{
    NSArray *cacPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [cacPath objectAtIndex:0];
//    NSLog(@"app_home_lib_cache: %@",cachePath);
    return  cachePath;
}

//获取Tmp目录
-(NSString *)dirTmp{
    //[NSHomeDirectory() stringByAppendingPathComponent:@"tmp"];
    NSString *tmpDirectory = NSTemporaryDirectory();
//    NSLog(@"app_home_tmp: %@",tmpDirectory);
    return  tmpDirectory;
}

//创建目录
-(BOOL)createDir:(NSString *)folderName{
    NSString *documentsPath =[self dirDoc];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *testDirectory = [documentsPath stringByAppendingPathComponent:folderName];
    // 创建目录
    BOOL res=[fileManager createDirectoryAtPath:testDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    if (res) {
        NSLog(@"文件夹创建成功");
    }else
    {
        NSLog(@"文件夹创建失败");
    }
    return  res;
}
//创建文件
-(BOOL) createFile:(NSString *)pFileShortName folderName:(NSString *)pFolderName
{
    NSString *documentsPath =[self dirDoc];
    NSString *testDirectory = [documentsPath stringByAppendingPathComponent:pFolderName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *testPath = [testDirectory stringByAppendingPathComponent:pFileShortName];
    BOOL res=[fileManager createFileAtPath:testPath contents:nil attributes:nil];
    if (res) {
        NSLog(@"文件创建成功: %@" ,testPath);
    }else
        NSLog(@"文件创建失败");
    return  res;
}
//写文件
-(BOOL)writeFile:(NSString *)pFileShortName folderName:(NSString *)pFolderName contentString:(NSString *)pContentString{
    NSString *documentsPath =[self dirDoc];
    NSString *testDirectory = [documentsPath stringByAppendingPathComponent:pFolderName];
    NSString *testPath = [testDirectory stringByAppendingPathComponent:pFileShortName];
    //NSString *content=@"测试写入内容！";
    BOOL res=[pContentString writeToFile:testPath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    if (res) {
        NSLog(@"文件写入成功");
    }else
        NSLog(@"文件写入失败");
    return  res;
}
//读取文件
-(NSString *) readFile:(NSString *)pFileShortName folderName:(NSString *)pFolderName {
    NSString *documentsPath =[self dirDoc];
    NSString *testDirectory = [documentsPath stringByAppendingPathComponent:pFolderName];
    NSString *testPath = [testDirectory stringByAppendingPathComponent:pFileShortName];
    NSString *content=[NSString stringWithContentsOfFile:testPath encoding:NSUTF8StringEncoding error:nil];
//    NSLog(@"文件读取成功: %@",content);
    return content;
}
- (long long) fileSizeAtPath:(NSString*) fileFullPath{
    
    NSFileManager* manager = [NSFileManager defaultManager];
    
    if ([manager fileExistsAtPath:fileFullPath]){
        
        return [[manager attributesOfItemAtPath:fileFullPath error:nil] fileSize];
    }
    return 0;
}
//写文本到文件
-(BOOL)writeFileFullPath:pFilePath contentString:(NSString *)pContentString
{
    NSError * err;
    BOOL res=[pContentString writeToFile:pFilePath atomically:YES encoding:NSUTF8StringEncoding error:&err];
    if (res) {
        NSLog(@"文件写入成功");
    }else {
        NSLog(@"文件写入失败,%@",err);
    //21
        //如果编码
        if (err.code==21) {
            //删除文件夹
            [self deleteFileWithFullPath:pFilePath];
        }
    }
    return  res;

}
//读取文件
-(NSString *) readFileFullPath:(NSString *)pFilePath
{
    NSString *content=[NSString stringWithContentsOfFile:pFilePath encoding:NSUTF8StringEncoding error:nil];
    return content;
}
//根据编码读取文件
-(NSString *) readFileFullPath:(NSString *)pFilePath encoding:(NSStringEncoding) pEncoding
{
    NSError * err=nil;
    NSString *content=[NSString stringWithContentsOfFile:pFilePath encoding:pEncoding error:&err];
    if (err!=nil) {
        NSLog(@"%@",err);
    }
    return content;
    
}
-(NSString *) readFileFullPath:(NSString *)pFilePath usedencoding:(NSStringEncoding) pEncoding
{
    NSString *rContent=[NSString new];
    NSError * err=nil;
    NSData *_dataBuffer=[[NSData alloc] initWithContentsOfFile:pFilePath];
    
    _dataBuffer=[self replaceNoUtf8:_dataBuffer];
    int len=4;
    long count=[_dataBuffer length]/len;
    long rest=[_dataBuffer length]%len;
    for (int i=0; i<count; i++) {
        NSData *adata = [_dataBuffer subdataWithRange:NSMakeRange(i*len,len)];
        NSString *content = [[NSString alloc]initWithData:adata encoding:pEncoding];
//        NSLog(@"%@,str:%@",adata,content);
        if (content!=nil) {
                    rContent=[rContent stringByAppendingString:content];
        }
    }
    //有余数
    if (rest>0) {
       NSData *adata = [_dataBuffer subdataWithRange:NSMakeRange(count*len,rest)];
        NSString *content = [[NSString alloc]initWithData:adata encoding:pEncoding];
//        NSLog(@"%@,str:%@",adata,content);
//        rContent=[rContent stringByAppendingString:content];
        if (content!=nil) {
            rContent=[rContent stringByAppendingString:content];
        }
    //没有余数
    }else{
    
    }

//    NSString *content = [[NSString alloc]initWithData:_dataBuffer encoding:pEncoding];//-2147482062];
//    NSString *content=[NSString stringWithContentsOfFile:pFilePath usedEncoding:pEncoding error:&err];
    if (err!=nil) {
        NSLog(@"%@",err);
    }
    return rContent;
    
}
- (NSData *)replaceNoUtf8:(NSData *)data
{
    char aa[] = {'A','A','A','A','A','A'};                      //utf8最多6个字符，当前方法未使用
    NSMutableData *md = [NSMutableData dataWithData:data];
    int loc = 0;
    while(loc < [md length])
    {
        char buffer;
        [md getBytes:&buffer range:NSMakeRange(loc, 1)];
        if((buffer & 0x80) == 0)
        {
            loc++;
            continue;
        }
        else if((buffer & 0xE0) == 0xC0)
        {
            loc++;
            [md getBytes:&buffer range:NSMakeRange(loc, 1)];
            if((buffer & 0xC0) == 0x80)
            {
                loc++;
                continue;
            }
            loc--;
            //非法字符，将这个字符（一个byte）替换为A
            [md replaceBytesInRange:NSMakeRange(loc, 1) withBytes:aa length:1];
            loc++;
            continue;
        }
        else if((buffer & 0xF0) == 0xE0)
        {
            loc++;
            [md getBytes:&buffer range:NSMakeRange(loc, 1)];
            if((buffer & 0xC0) == 0x80)
            {
                loc++;
                [md getBytes:&buffer range:NSMakeRange(loc, 1)];
                if((buffer & 0xC0) == 0x80)
                {
                    loc++;
                    continue;
                }
                loc--;
            }
            loc--;
            //非法字符，将这个字符（一个byte）替换为A
            [md replaceBytesInRange:NSMakeRange(loc, 1) withBytes:aa length:1];
            loc++;
            continue;
        }
        else
        {
            //非法字符，将这个字符（一个byte）替换为A
            [md replaceBytesInRange:NSMakeRange(loc, 1) withBytes:aa length:1];
            loc++;
            continue;
        }
    }
    
    return md;
}
//获取文件属性
-(NSDictionary *) getfileAttriutes:(NSString *)pFileShortName folderName:(NSString *)pFolderName {
    NSString *documentsPath =[self dirDoc];
    NSString *testDirectory = [documentsPath stringByAppendingPathComponent:pFolderName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *testPath = [testDirectory stringByAppendingPathComponent:pFileShortName];
    NSDictionary *fileAttributes = [fileManager attributesOfItemAtPath:testPath error:nil];
    return fileAttributes;
}
//删除文件
-(BOOL)deleteFile:(NSString *)pFileShortName folderName:(NSString *)pFolderName{
    NSString *documentsPath =[self dirDoc];
    NSString *testDirectory = [documentsPath stringByAppendingPathComponent:pFolderName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *testPath = [testDirectory stringByAppendingPathComponent:pFileShortName];
    BOOL res=[fileManager removeItemAtPath:testPath error:nil];
    if (res) {
        NSLog(@"文件删除成功");
    }else
        NSLog(@"文件删除失败");
    NSLog(@"文件是否存在: %@",[fileManager isExecutableFileAtPath:testPath]?@"YES":@"NO");
    return  res;
}
-(BOOL)deleteFileWithFullPath:(NSString *)pFilePath
{
   return [[NSFileManager defaultManager] removeItemAtPath:pFilePath error:nil];
}
//接收数据保存到文件
-(BOOL)downloadFileWithURL:(NSString *) pURL saveFilePath:(NSString *)pSaveFilePath
{
    NSString *documentsPath =[self dirDoc];
    NSString *filePath=[documentsPath stringByAppendingPathComponent:pSaveFilePath];
    //block
    __block BOOL result=false;
    NSURL * url=[NSURL URLWithString:pURL];
    NSURLRequest *urlRequest=[NSURLRequest requestWithURL:url];
    NSOperationQueue * queue=[[NSOperationQueue alloc]init];
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if ([data length]>0&& connectionError==nil) {
            NSLog(@"%ld",(unsigned long)[data length]);
            result=[data writeToFile:filePath atomically:YES];
            
        }else if([data length]==0&&connectionError==nil)
        {
            NSLog(@"nothing was downloaded");
        }else if(connectionError!=nil)
        {
            NSLog(@"err:%@",connectionError);
        }
    }];
    return result;
}
//异步下载
-(void)downloadFileWithURLAscInDocument:(NSString *) pURL fileShortName:(NSString *)pFileShortName folderName:(NSString *)pFolderName
{
    DownLoadHelper *dwn = [DownLoadHelper initWithURL:[[NSURL alloc] initWithString:pURL]];
    //总共
    __block long long _sum=0;
    //接收到
    __block long long _rcv=0;
    dwn.initProgress = ^(long long initValue){
        _sum = initValue;
        NSLog(@"%lli",initValue);
        _rcv = 0;
        dispatch_async(dispatch_get_main_queue(), ^{
            //ui界面
        });
    };
    
    dwn.loadedData = ^(long long loadedLength){
        dispatch_async(dispatch_get_main_queue(), ^{
            if (_rcv == _sum) {
                
            } else {
                _rcv += loadedLength;
                NSLog(@"%f",_rcv/(1.0*_sum));
                
            }
        });
    };
    //设置另存为路径（默认在Document根目录下）
    [dwn setSavePath:pFolderName shortFileName:pFileShortName];
    //开始下载
    [dwn startAsyn];
}

//异步下载
-(void)downloadFileWithURLAsc:(NSString *) pURL fileFullPath:(NSString *)pfileFullPath
{
    DownLoadHelper *dwn = [DownLoadHelper initWithURL:[[NSURL alloc] initWithString:pURL]];
    //总共
    __block long long _sum=0;
    //接收到
    __block long long _rcv=0;
    dwn.initProgress = ^(long long initValue){
        _sum = initValue;
        NSLog(@"%lli",initValue);
        _rcv = 0;
        dispatch_async(dispatch_get_main_queue(), ^{
            //ui界面
        });
    };
    
    dwn.loadedData = ^(long long loadedLength){
        dispatch_async(dispatch_get_main_queue(), ^{
            if (_rcv == _sum) {
                
            } else {
                _rcv += loadedLength;
                NSLog(@"%f",_rcv/(1.0*_sum));
                
            }
        });
    };
    //设置另存为路径(全路径自定义)
    [dwn setFullSavePath:pfileFullPath];
    //开始下载
    [dwn startAsyn];
}
//保存流到文件
-(BOOL)downloadFileWithDataInDocument:(NSData *) pData saveFilePath:(NSString *)pSaveFilePath
{
    NSString *documentsPath =[self dirDoc];
    NSString *filePath=[documentsPath stringByAppendingPathComponent:pSaveFilePath];
    return [pData writeToFile:filePath atomically:YES];
}
//保存流到文件(自定义路径)
-(BOOL)downloadFileWithData:(NSData *) pData saveFilePath:(NSString *)pSaveFilePath
{
    return [pData writeToFile:pSaveFilePath atomically:YES];
}
//上传文件到网址(回头再搞)
-(BOOL) uploadFileWithPath:(NSString *) pFilePath serverURL:(NSString *)pURL mFileName:(NSString *) pFileNAme
{
    BOOL result=false;
    UploadFile *upload = [[UploadFile alloc] init];
    
    
    [upload uploadFileWithHost:pURL fileName:pFileNAme mFilePath:pFilePath];
    return result;
}
//上传流到网址
-(BOOL) uploadFileWithData:(NSData *) pData serverURL:(NSString *)pURL mFileName:(NSString *) pFileName
{
    BOOL result=false;
    
    UploadFile *upload = [[UploadFile alloc] init];
    
    NSString *urlString =pURL;//@"http://localhost/upload.php";
    
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"头像1.png" ofType:nil];
//    NSData *data = [NSData dataWithContentsOfFile:path];
    
    [upload uploadFileWithURL:[NSURL URLWithString:urlString] data:pData fileName:pFileName];
    
    return result;
}
//上传文件到网址
-(void) uploadFileWithPath:(NSString *) pFilePath serverURL:(NSString *)pURL mFileName:(NSString *) pFileNAme success:(void(^)(id pResult)) pSuccessHandler error:(void(^)(NSException *pError))pErrorHandler
{
    @try {
        UploadFile *upload = [[UploadFile alloc] init];
        [upload uploadFileWithHost:pURL fileName:pFileNAme mFilePath:pFilePath];
    }
    @catch (NSException *exception) {
        pErrorHandler(exception);
    }
    @finally {
        pSuccessHandler(@"");
    }
  
}
//上传流到网址
-(void) uploadFileWithData:(NSData *) pData serverURL:(NSString *)pURL mFileName:(NSString *) pFileName success:(void(^)(id pResult)) pSuccessHandler error:(void(^)(NSException *pError))pErrorHandler
{
    UploadFile *upload = [[UploadFile alloc] init];
    NSLog(@"地址:%@",pURL);
    NSString *urlString =pURL;
    [upload uploadFileWithURL:[NSURL URLWithString:urlString] data:pData fileName:pFileName success:^(id pResult) {
        pSuccessHandler(pResult);
    } error:^(NSException *pError) {
        pErrorHandler(pError);
    }];
}

-(void) uploadFileExtWithData:(NSData *) pData serverURL:(NSString *)pURL mFileName:(NSString *) pFileName mExt:(id )pExt success:(void(^)(id pResult,id pExt)) pSuccessHandler error:(void(^)(NSException *pError))pErrorHandler
{
    UploadFile *upload = [[UploadFile alloc] init];
    NSLog(@"地址:%@",pURL);
    NSString *urlString =pURL;
    [upload uploadFileWithURL:[NSURL URLWithString:urlString] data:pData fileName:pFileName success:^(id pResult) {
        //额外回传值
        pSuccessHandler(pResult,pExt);
    } error:^(NSException *pError) {
        pErrorHandler(pError);
    }];

}

//文件存在
-(BOOL) fileIsExistByPath:(NSString *) pFilePath
{
    BOOL result=false;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    result=[fileManager fileExistsAtPath:pFilePath];
    return  result;
}
//文件是否在doc目录
-(BOOL) fileIsExistByPathInDoc:(NSString *) pFilePath
{
    BOOL result=false;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString * basePath=[self dirDoc];
    NSString * path=[basePath stringByAppendingString:pFilePath];
    
    result=[fileManager fileExistsAtPath:path];
    NSLog(@"路径:%@,%@",path,result?@"y":@"n");
    return  result;

}
-(BOOL) fileIsExistByPathInResource:(NSString *) pFilePath
{
    BOOL result=false;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString * basePath=[self dirResource];
    NSString * path=[basePath stringByAppendingString:pFilePath];
    result=[fileManager fileExistsAtPath:path];
    return  result;
}
-(BOOL) fileIsExistByPathApp:(NSString *) pAppfilePath type:(NSString *) pType
{
    BOOL result=false;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString * basePath=[self dirResource];
    NSString * path=[basePath stringByAppendingString:[NSString stringWithFormat:@"%@.%@",pAppfilePath,pType]];
    result=[fileManager fileExistsAtPath:path];
    return  result;
}
+(BOOL) fileIsExistByPathApp:(NSString *) pAppfilePath  type:(NSString *) pType
{
    BOOL result=false;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString * path=[[NSBundle mainBundle] pathForResource:pAppfilePath ofType:pType];
    result=[fileManager fileExistsAtPath:path];
    return  result;
}
#pragma  mark 路径转换
-(NSString *) convertPathToFilename:(NSString *) pFilePath
{
    NSString * result=@"";
    //这里使用分隔符 “/”
    NSRange range = [pFilePath rangeOfString:@"/"];
    result = [pFilePath substringFromIndex:NSMaxRange(range)];
    return  result;
}
//路径拚串到资源文件夹下
-(NSString *) convertToResourcePathFileShortName:(NSString *) pFileShortName folderName:(NSString *)pFolderName
{
    NSString *documentsPath =[self dirResource];
    NSString * result=[documentsPath stringByAppendingPathComponent:pFolderName];
    result=[result stringByAppendingPathComponent:pFileShortName];
    NSLog(@"path->:%@",result);
    return  result;
}
//路径拚串到文档文件夹下
-(NSString *) convertToDocumentPathFileShortName:(NSString *) pFileShortName folderName:(NSString *)pFolderName
{
    NSString *documentsPath =[self dirDoc];
    NSString * result=[documentsPath stringByAppendingPathComponent:pFolderName];
    result=[result stringByAppendingPathComponent:pFileShortName];
    NSLog(@"path->:%@",result);
    return  result;
}
//通过路径获取文件名
-(NSString *) converPathToShortName:(NSString *) fileName
{
    NSString * result=[NSString string];
    if (nil!=fileName&&![@"" isEqualToString:fileName]) {
        //特殊处理
        fileName=[fileName stringByReplacingOccurrencesOfString:@"\\" withString:@"/"];
        NSArray * tmpArray=[fileName componentsSeparatedByString:@"/"];
        result=tmpArray[[tmpArray count]-1];
    }
    return  result;
}
#pragma  mark 移动方法
-(BOOL) moveDirToDocumentFrom:(NSString *)pFrom ToFolder:(NSString *)pToFolder
{
    BOOL result=false;
    NSString *ToPath=[self dirDoc];
    //如果文件夹不为空
    if(nil!=pToFolder)
    {
        //路径拼接
        ToPath=[ToPath stringByAppendingString:pToFolder];
    }
    NSFileManager * tFileManager=[NSFileManager defaultManager];
    NSError * error;
    result=[tFileManager copyItemAtPath:pFrom toPath:pToFolder error:&error];
    if(result)
    {
        NSLog(@"success");
    }else{
        NSLog(@"{reason:%@}",error);
    }
    
    return  result;

}
-(BOOL) moveDirToFrom:(NSString *)pFromDir ToDir:(NSString *)pToDir
{
    BOOL result=false;
    NSFileManager * fFileManager=[NSFileManager defaultManager];
    NSError * error;
    result= [fFileManager copyItemAtPath:pFromDir toPath:pToDir error:&error];
    if (result) {
        NSLog(@"success");
    }else {
        NSLog( @"{reason:%@}",error);
    }
    return result;
}
-(BOOL) moveProjectFolderToDocumentFrom:(NSString *)pFromFolder ToFolder:(NSString *)pToFolder
{
    BOOL result=false;
    NSString *pFrom=[self dirResource];
    NSString *ToPath=[self dirDoc ];
    if (nil!=pFromFolder) {
        pFrom=[pFrom stringByAppendingPathComponent:pFromFolder];
    }
    //如果文件夹不为空
    if(nil!=pToFolder)
    {
        //路径拼接
        ToPath=[ToPath stringByAppendingPathComponent:pToFolder];
    }
    NSFileManager * tFileManager=[NSFileManager defaultManager];
    NSError * error;
    result=[tFileManager copyItemAtPath:pFrom toPath:pToFolder error:&error];
    if(result)
    {
        NSLog(@"success");
    }else{
        NSLog(@"{reason:%@}",error);
    }
    
    return  result;

}

#pragma  mark 搜索方法
//在路径下搜索扩展名(扩展名（txt），目标文件夹，是否需要子文件夹)
-(NSMutableArray *) searchFileWithExt:(NSString *) pExtStr forDir:(NSString *) pDir hasChild:(BOOL )pHasChild
{
    NSMutableArray * rArr=[NSMutableArray array];
    NSString * pDesdirPrix=[self dirDoc];
    NSFileManager * tFileManager=[NSFileManager defaultManager];
    NSError * error;
    //    NSArray * subFilePathsInfo=[tFileManager subpathsAtPath:[pSrcDirPrix stringByAppendingPathComponent:pSrcdir]];
    NSArray * subFileInfo=[tFileManager subpathsOfDirectoryAtPath:[pDesdirPrix stringByAppendingPathComponent:pDir]  error:&error];
    //    NSArray *files = [tFileManager subpathsAtPath:[pDesdirPrix stringByAppendingPathComponent:pDir] ];
    if (pHasChild) {
        for (NSString * fileItem in subFileInfo) {
            //需要 根目录
            NSMutableDictionary * tFileInfo=[self expectPathStr:fileItem];
            //创建陌路(不为空并且，不是路径)
            if ([kNo isEqualToString:tFileInfo[kMddFileIsPath]]&&[kNo isEqualToString:tFileInfo[kMddFileEmpty]]) {
               if([tFileInfo[kMddFileExt] isEqualToString:pExtStr])
               {
                   [rArr addObject:fileItem];

               }
                
            }
            
        }
        //当前目录
    }else{
        for (NSString * fileItem in subFileInfo) {
            //需要 根目录
            NSMutableDictionary * tFileInfo=[self expectPathStr:fileItem];
            //创建陌路(不为空并且，不是路径)
            if ([kNo isEqualToString:tFileInfo[kMddFileIsPath]]&&[kNo isEqualToString:tFileInfo[kMddFileEmpty]]) {
                //0个文件夹的
                if ([@"0" isEqualToString:tFileInfo[kMddFilePathCount]]) {
                    if([tFileInfo[kMddFileExt] isEqualToString:pExtStr])
                    {
                        [rArr addObject:fileItem];
                        
                    }
                }
            }
            
        }
    }
    return rArr;
}
//在路径下搜索扩展名(文件名，目标文件夹，是否需要子文件夹)
-(NSMutableArray *) searchFileWithFileName:(NSString *) pFileName forDir:(NSString *) pDir hasChild:(BOOL )pHasChild
{
    NSMutableArray * rArr=[NSMutableArray array];
    NSString * pDesdirPrix=[self dirDoc];
    NSFileManager * tFileManager=[NSFileManager defaultManager];
    NSError * error;
    //    NSArray * subFilePathsInfo=[tFileManager subpathsAtPath:[pSrcDirPrix stringByAppendingPathComponent:pSrcdir]];
    NSArray * subFileInfo=[tFileManager subpathsOfDirectoryAtPath:[pDesdirPrix stringByAppendingPathComponent:pDir]  error:&error];
//    NSArray *files = [tFileManager subpathsAtPath:[pDesdirPrix stringByAppendingPathComponent:pDir] ];
    if (pHasChild) {
        for (NSString * fileItem in subFileInfo) {
            //需要 根目录
            NSMutableDictionary * tFileInfo=[self expectPathStr:fileItem];
            //创建陌路(不为空并且，不是路径)
            if ([kNo isEqualToString:tFileInfo[kMddFileIsPath]]&&[kNo isEqualToString:tFileInfo[kMddFileEmpty]]) {
                //全部文件
                if([@"*" isEqualToString:pFileName])
                {
                    [rArr addObject:fileItem];
                    //名字包含
                }else{
                    NSRange range;
                    
                    range=[fileItem rangeOfString:pFileName];
                    if (range.location!=NSNotFound)
                    {
                        
                        //带点
                        if (range.location>0) {
                            [rArr addObject:fileItem];
                        }
                    }
                }
            }
            
        }
    //当前目录
    }else{
        for (NSString * fileItem in subFileInfo) {
            //需要 根目录
            NSMutableDictionary * tFileInfo=[self expectPathStr:fileItem];
            //创建陌路(不为空并且，不是路径)
             if ([kNo isEqualToString:tFileInfo[kMddFileIsPath]]&&[kNo isEqualToString:tFileInfo[kMddFileEmpty]]) {
                 //0个文件夹的
                 if ([@"0" isEqualToString:tFileInfo[kMddFilePathCount]]) {
                     //全部文件
                     if([@"*" isEqualToString:pFileName])
                     {
                         [rArr addObject:fileItem];
                         //名字包含
                     }else{
                         NSRange range;
                         
                         range=[fileItem rangeOfString:pFileName];
                         if (range.location!=NSNotFound)
                         {
                             //带点
                             if (range.location>0) {
                                 [rArr addObject:fileItem];
                             }
                         }
                     }
                 }
            }
            
        }
    }
    return rArr;
}

-(NSMutableDictionary *) expectPathStr:(NSString *)pPathStr{
    NSMutableDictionary * rDic=[NSMutableDictionary dictionary];
    rDic[kMddFileRoot]=@"";
    rDic[kMddFileName]=@"";
    rDic[kMddFileExt]=@"";
    rDic[kMddFileIsPath]=kNo;
    rDic[kMddFileEmpty]=kYes;
    rDic[kMddFileRawPath]=@"";
    rDic[kMddFilePathCount]=@"0";
    
    //非空
    if(nil!=pPathStr&&(![@"" isEqualToString:pPathStr]))
    {
        //检索字符串
         rDic[kMddFileRawPath]=pPathStr;
        
        NSRange range;
        
        range=[pPathStr rangeOfString:@"."];
        
        if (range.location!=NSNotFound)
        {
            
            //带点
            if (range.location>0) {
                    rDic[kMddFileIsPath]=kNo;
                    rDic[kMddFileEmpty]=kNo;
                NSArray *array = [pPathStr componentsSeparatedByString:@"/"];
                rDic[kMddFileRoot]=array[0];
                rDic[kMddFileName]=array[[array count]-1];
                rDic[kMddFilePathCount]=[NSString stringWithFormat:@"%lu",[array count]-1];
                //后缀名
                 NSArray *arrayExt = [pPathStr componentsSeparatedByString:@"."];
                rDic[kMddFileExt]=arrayExt[[arrayExt count]-1];
            //不带点
            }else{
                    rDic[kMddFileName]=@"";
                    rDic[kMddFileExt]=@"";
                    rDic[kMddFileIsPath]=kYes;
                    rDic[kMddFileEmpty]=kNo;
            }
            //得到字符串的位置和长度
            
//            NSLog(@"%d,%d",range.location,range.length);
        //不带点
        }else{
            rDic[kMddFileName]=@"";
            rDic[kMddFileExt]=@"";
            rDic[kMddFileIsPath]=kYes;
            rDic[kMddFileEmpty]=kNo;
        }
        //不带点
        if ([kYes isEqualToString:rDic[kMddFileIsPath]]) {
            NSArray *array = [pPathStr componentsSeparatedByString:@"/"];
            rDic[kMddFileRoot]=array[0];
            rDic[kMddFilePathCount]=[NSString stringWithFormat:@"%lu",[array count]-1];
        }
        
    }else{
        rDic[kMddFileEmpty]=kYes;
    }
    
    return rDic;
}
-(NSMutableArray *) searchFileListforDir:(NSString *) pDir
{
    NSFileManager *fileman = [NSFileManager defaultManager];
    NSString *docdir = [self dirDoc:pDir];//[NSString stringWithFormat: @"%@/Documents", NSHomeDirectory()];
    NSMutableArray *outfiles = [[NSMutableArray alloc] init];
    NSDirectoryEnumerator *direnum = [fileman enumeratorAtPath:docdir];
    NSString *file;
    BOOL isdir;
    while (file = [direnum nextObject]) {
        NSString *filepath = [docdir stringByAppendingPathComponent:file];
        if ([fileman fileExistsAtPath:filepath isDirectory:&isdir] && !isdir) {
            //本身是根目录
            if ([@"" isEqualToString:pDir]) {
                 [outfiles addObject:file];
            }else{
                [outfiles addObject:[NSString stringWithFormat:@"%@/%@",pDir,file]];
            }
        }
    }
    return outfiles;
}
-(NSMutableArray *) searchFileListDicforDir:(NSString *) pDir
{
    NSFileManager *fileman = [NSFileManager defaultManager];
    NSString *docdir = [self dirDoc:pDir];//[NSString stringWithFormat: @"%@/Documents", NSHomeDirectory()];
    NSMutableArray *rDicOutfiles = [[NSMutableArray alloc] init];
    NSMutableArray *outfiles = [[NSMutableArray alloc] init];
    NSDirectoryEnumerator *direnum = [fileman enumeratorAtPath:docdir];
    NSString *file;
    BOOL isdir;
    while (file = [direnum nextObject]) {
        NSString *filepath = [docdir stringByAppendingPathComponent:file];
        if ([fileman fileExistsAtPath:filepath isDirectory:&isdir] && !isdir) {
            //本身是根目录
            if ([@"" isEqualToString:pDir]) {
                [outfiles addObject:file];
            }else{
                [outfiles addObject:[NSString stringWithFormat:@"%@/%@",pDir,file]];
            }
        }
    }
    for (NSString * fileItem in outfiles) {
         NSMutableDictionary * tFileInfo=[self expectPathStr:fileItem];
        [rDicOutfiles addObject:tFileInfo];
    }
    return rDicOutfiles;
}
//全文件夹拷贝
-(BOOL) CopyDirectory:(NSString *) pSrcdir desdir:(NSString*) pDesdir
{
    BOOL result=false;
    //项目源前缀
    NSString * pSrcDirPrix=[self dirResource];
    //项目目标前缀
    NSString * pDesdirPrix=[self dirDoc];
    NSFileManager * tFileManager=[NSFileManager defaultManager];
    NSError * error;
//    NSArray * subFilePathsInfo=[tFileManager subpathsAtPath:[pSrcDirPrix stringByAppendingPathComponent:pSrcdir]];
    NSLog(@"pSrcdir:%@:pDesdir:%@",pSrcdir,pDesdir);
    NSArray * subFileInfo=[tFileManager subpathsOfDirectoryAtPath:[pSrcDirPrix stringByAppendingPathComponent:pSrcdir]  error:&error];
    for (NSString * fileItem in subFileInfo) {
        //需要 根目录
        NSString * tmpSrcdir=[[pSrcDirPrix stringByAppendingPathComponent:pSrcdir] stringByAppendingPathComponent:fileItem];
        NSString * tmpDesdir=[pDesdirPrix stringByAppendingPathComponent:pDesdir];
        tmpDesdir=[[self class] dataPath:tmpDesdir];
        tmpDesdir=[tmpDesdir stringByAppendingPathComponent:fileItem];
        //创建陌路
//        tmpDesdir=[[self class] dataPath:tmpDesdir];
        //NSLog(@"from(%@)->to(%@)",tmpSrcdir,tmpDesdir);
       result= [self CopyDirectory:tmpSrcdir desdir:tmpDesdir fileManager:tFileManager];
    }
    //result=[self CopyDirectory:pSrcdir desdir:pDesdir fileManager:tFileManager ];
    return  result;
}

-(BOOL)CopyDirectory:(NSString *) pSrcdir desdir:(NSString*) pDesdir fileManager:(NSFileManager *)pFileManager
{
    BOOL result=false;
    @try {
        NSError * error;
        result=[pFileManager copyItemAtPath:pSrcdir toPath:pDesdir error:&error];
        NSLog(@"pSrcdir:%@,pDesdir:%@",pSrcdir,pDesdir);
        //result=true;
    }
    @catch (NSException *exception) {
        NSLog(@"{reason:%@}",exception);
    }
    @finally {
        
    }
    return  result;
}

#pragma mark others
+(NSString*)GetCurrentLongTimeString
{
    NSDateFormatter *dateformat = [[NSDateFormatter  alloc]init];
    [dateformat setDateFormat:@"yyyy-MM-dd HH:mm:ss:fff"];//添加毫秒
    return [dateformat stringFromDate:[NSDate date]];
}
-(NSString*)GetCurrentTimeString{
    NSDateFormatter *dateformat = [[NSDateFormatter  alloc]init];
    [dateformat setDateFormat:@"yyyyMMddHHmmssfff"];//添加毫秒
    return [dateformat stringFromDate:[NSDate date]];
}
-(NSString*)GetCurrentLongTimeString
{
    NSDateFormatter *dateformat = [[NSDateFormatter  alloc]init];
    [dateformat setDateFormat:@"yyyy-MM-dd HH:mm:ss:fff"];//添加毫秒
    return [dateformat stringFromDate:[NSDate date]];
}
-(NSString*) GetDateTimeString
{
    NSDate * senddate=[NSDate date];
    NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString * locationString=[dateformatter stringFromDate:senddate];
    return locationString;
}
+ (NSString *)dataPath:(NSString *)pFilePath
{
    BOOL bo = [[NSFileManager defaultManager] createDirectoryAtPath:pFilePath withIntermediateDirectories:YES attributes:nil error:nil];
    NSAssert(bo,@"创建目录失败");
    return pFilePath;
    
}
-(NSString *)getDayString:(int)dayDelay{
    //    NSString *weekDay;
    NSDate *dateNow;
    dateNow=[NSDate dateWithTimeIntervalSinceNow:dayDelay*24*60*60];//dayDelay代表向后推几天，如果是0则代表是今天，如果是1就代表向后推24小时，如果想向后推12小时，就可以改成dayDelay*12*60*60,让dayDelay＝1
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];//设置成中国阳历
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;//这句我也不明白具体时用来做什么。。。
    comps = [calendar components:unitFlags fromDate:dateNow];
    //    long weekNumber = [comps weekday]; //获取星期对应的长整形字符串
    long day=[comps day];//获取日期对应的长整形字符串
    long year=[comps year];//获取年对应的长整形字符串
    long month=[comps month];//获取月对应的长整形字符串
    //    long hour=[comps hour];//获取小时对应的长整形字符串
    //    long minute=[comps minute];//获取月对应的长整形字符串
    //    long second=[comps second];//获取秒对应的长整形字符串
    //    NSString *riQi =[NSString stringWithFormat:@"%ld日",day];//把日期长整形转成对应的汉字字符串
    //    switch (weekNumber) {
    //        case 1:
    //            weekDay=@"星期日";
    //            break;
    //        case 2:
    //            weekDay=@"星期一";
    //            break;
    //        case 3:
    //            weekDay=@"星期二";
    //            break;
    //        case 4:
    //            weekDay=@"星期三";
    //            break;
    //        case 5:
    //            weekDay=@"星期四";
    //            break;
    //        case 6:
    //            weekDay=@"星期五";
    //            break;
    //        case 7:
    //            weekDay=@"星期六";
    //            break;
    //
    //        default:
    //            break;
    //    }
    //    weekDay=[riQi stringByAppendingString:weekDay];//这里我本身的程序里只需要日期和星期，所以上面的年月时分秒都没有用上
    return [NSString stringWithFormat:@"%ld-%ld-%ld",year,month,day];
}

- (NSString *)intervalFromLastDate: (NSString *) dateString1  toTheDate:(NSString *) dateString2
{
    NSArray *timeArray1=[dateString1 componentsSeparatedByString:@"."];
    dateString1=[timeArray1 objectAtIndex:0];
    
    
    NSArray *timeArray2=[dateString2 componentsSeparatedByString:@"."];
    dateString2=[timeArray2 objectAtIndex:0];
    
    NSLog(@"%@.....%@",dateString1,dateString2);
    NSDateFormatter *date=[[NSDateFormatter alloc] init];
    [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    
    NSDate *d1=[date dateFromString:dateString1];
    
    NSTimeInterval late1=[d1 timeIntervalSince1970]*1;
    
    
    
    NSDate *d2=[date dateFromString:dateString2];
    
    NSTimeInterval late2=[d2 timeIntervalSince1970]*1;
    
    
    
    NSTimeInterval cha=late2-late1;
    NSString *timeString=@"";
    NSString *house=@"";
    NSString *min=@"";
    NSString *sen=@"";
    
    sen = [NSString stringWithFormat:@"%d", (int)cha%60];
    //        min = [min substringToIndex:min.length-7];
    //    秒
    sen=[NSString stringWithFormat:@"%@", sen];
    
    
    
    min = [NSString stringWithFormat:@"%d", (int)cha/60%60];
    //        min = [min substringToIndex:min.length-7];
    //    分
    min=[NSString stringWithFormat:@"%@", min];
    
    
    //    小时
    house = [NSString stringWithFormat:@"%d", (int)cha/3600];
    //        house = [house substringToIndex:house.length-7];
    house=[NSString stringWithFormat:@"%@", house];
    timeString=[NSString stringWithFormat:@"%@:%@:%@",house,min,sen];
    return timeString;
}

/*
 C#
 //复制文件夹
 public bool CopyDirectory(string srcdir = "", string desdir = "", bool result = false)
 {
 try
 {
 string folderName = "";
 string[] filenames;
 string srcfileName = "";
 string mblj = "";
 if (!Directory.Exists(desdir))
 {
 Directory.CreateDirectory(desdir.Trim());
 }
 folderName = srcdir.Substring(srcdir.LastIndexOf("\\") + 1);
 filenames = Directory.GetFileSystemEntries(srcdir);
 foreach (string file in filenames)
 {
 if (Directory.Exists(file))
 {
 mblj = desdir + "\\" + file.Substring(file.LastIndexOf("\\") + 1);
 if (!Directory.Exists(mblj))
 {
 Directory.CreateDirectory(mblj);
 }
 CopyDirectory(file, mblj);
 }
 else
 {
 srcfileName = file.Substring(file.LastIndexOf("\\") + 1);
 mblj = desdir + "\\" + srcfileName;
 File.Copy(file, mblj, true);
 }
 }
 return result = true;
 }
 catch (Exception)
 {
 return result = false;
 }
 }
 
 */

/*
 NSString * path1 = [[NSBundle mainBundle] pathForResource: @"BaseMap/FoundationGeography" ofType: @"tpk"];
 /Users/oscar/Library/Developer/CoreSimulator/Devices/A61D6908-5AF4-477C-A2BD-D5EBCB22BD6A/data/Containers/Bundle/Application/C2DE0091-61E0-4C7D-BEB4-59989AB2A8FE/onemap.app/BaseMap/FoundationGeography.tpk
 */
@end
