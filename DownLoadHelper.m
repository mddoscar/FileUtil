//
//  DownLoadHelper.m
//  onemap
//
//  Created by 月光 on 15/3/26.
//  Copyright (c) 2015年 肖光. All rights reserved.
//

#import "DownLoadHelper.h"


@interface DownLoadHelper()
//属性
//公有化
@property (assign) long long contentLength;
@property (assign) long long receiveLength;
@property (strong) NSMutableData *receiveData;
@property (strong) NSString *fileName;
@property (strong) NSURLConnection *theConnection;
@property (strong) NSURLRequest *theRequest;

@end


@implementation DownLoadHelper
@synthesize receiveData = _receiveData, fileName = _fileName,
theConnection=_theConnection, theRequest=_theRequest,saveAsFilePath=_saveAsFilePath;

//初始化下载
+(DownLoadHelper *) initWithURL:(NSURL *) url{
    DownLoadHelper *asynDownload = [[DownLoadHelper alloc] init];
    asynDownload.theRequest=[NSURLRequest requestWithURL:url
                                             cachePolicy:NSURLRequestUseProtocolCachePolicy
                                         timeoutInterval:60.0];
    // create the connection with the request
    // and start loading the data
    return asynDownload;
}
//开始进程
-(void) startAsyn{
    _contentLength=0;
    _receiveLength=0;
    self.receiveData = [[NSMutableData alloc] init];
    self.theConnection = [[NSURLConnection alloc] initWithRequest:self.theRequest delegate:self];
}

//接收到http响应
-(void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    _contentLength = [response expectedContentLength];
    _fileName = [response suggestedFilename];
    if (self.initProgress != nil) {
        self.initProgress(_contentLength);
    }
    NSLog(@"data length is %lli", _contentLength);
}

//传输数据
-(void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    _receiveLength += data.length;
    [_receiveData appendData:data];
    if (self.loadedData != nil) {
        self.loadedData(data.length);
    }
    NSLog(@"data recvive is %lli", _receiveLength);
}

//错误
-(void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    [self releaseObjs];
    NSLog(@"%@",error.description);
}

//释放对象
-(void) releaseObjs{
    self.receiveData = nil;
    self.fileName = nil;
    self.theRequest = nil;
    self.theConnection = nil;
    self.saveAsFilePath=nil;
}

//设置保存路径
-(void) setSavePath:(NSString *)pLocalFolder shortFileName:(NSString *)pShortFileName
{
    //获取完整目录名字
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    //Document/(文件夹)/(文件名)
    self.saveAsFilePath=[[documentsDirectory stringByAppendingPathComponent:pLocalFolder]stringByAppendingPathComponent:pShortFileName];
    NSLog(@"path:%@",self.saveAsFilePath);
    
}
//保存路径
-(void) setFullSavePath:(NSString *) pFullFilePath
{
    self.saveAsFilePath=pFullFilePath;
    NSLog(@"path:%@",self.saveAsFilePath);
    
}

//成功下载完毕
-(void) connectionDidFinishLoading:(NSURLConnection *)connection{
    //数据写入doument
    //获取完整目录名字
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    //为空默认下载到document中
    if(_saveAsFilePath==nil||[_saveAsFilePath isEqualToString:@""])
    {
        _saveAsFilePath = [NSString stringWithFormat:@"%@/%@",documentsDirectory, _fileName];
    }
    //创建文件
    [_receiveData writeToFile:_saveAsFilePath atomically:YES];
    NSLog(@"保存路径:%@",_saveAsFilePath);
    [self releaseObjs];
}


@end
