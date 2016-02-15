//
//  UploadFile.m
//  ChildrenLocation
//
//  Created by szalarm on 15/8/27.
//  Copyright (c) 2015年 szalarm. All rights reserved.
//

#import "UploadFile.h"

#define YYEncode(str) [str dataUsingEncoding:NSUTF8StringEncoding]

@implementation UploadFile
// 拼接字符串
static NSString *boundaryStr = @"--";   // 分隔字符串
static NSString *randomIDStr;           // 本次上传标示字符串
static NSString *uploadID;              // 上传(php)脚本中，接收文件字段

- (instancetype)init
{
    self = [super init];
    if (self) {
        randomIDStr = @"itcast";
        uploadID = @"uploadFile";
    }
    return self;
}

#pragma mark - 私有方法
- (NSString *)topStringWithMimeType:(NSString *)mimeType uploadFile:(NSString *)uploadFile
{
    NSMutableString *strM = [NSMutableString string];
    
    [strM appendFormat:@"%@%@\n", boundaryStr, randomIDStr];
    [strM appendFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\n", uploadID, uploadFile];
    [strM appendFormat:@"Content-Type: %@\n\n", mimeType];
    
    NSLog(@"%@", strM);
    return @"";//[strM copy];
}

- (NSString *)bottomString
{
    NSMutableString *strM = [NSMutableString string];
    
    [strM appendFormat:@"%@%@\n", boundaryStr, randomIDStr];
    [strM appendString:@"Content-Disposition: form-data; name=\"submit\"\n\n"];
    [strM appendString:@"Submit\n"];
    [strM appendFormat:@"%@%@--\n", boundaryStr, randomIDStr];
    
    NSLog(@"%@", strM);
    return [strM copy];
}

#pragma mark - 上传文件
- (void)uploadFileWithURL:(NSURL *)url data:(NSData *)data fileName:(NSString *) pFileName
{
    // 1> 数据体
    NSString *topStr = @"";//[self topStringWithMimeType:@"image/png" uploadFile:pFileName];
    NSString *bottomStr = @"";//[self bottomString];
    
    NSMutableData *dataM = [NSMutableData data];
    [dataM appendData:[topStr dataUsingEncoding:NSUTF8StringEncoding]];
    [dataM appendData:data];
    [dataM appendData:[bottomStr dataUsingEncoding:NSUTF8StringEncoding]];
    
    // 1. Request
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:0 timeoutInterval:2.0f];
    
    // dataM出了作用域就会被释放,因此不用copy
    request.HTTPBody = dataM;
    
    // 2> 设置Request的头属性
    request.HTTPMethod = @"POST";
    
    // 3> 设置Content-Length
    NSString *strLength = [NSString stringWithFormat:@"%ld", (long)dataM.length];
    [request setValue:strLength forHTTPHeaderField:@"Content-Length"];
    
    // 4> 设置Content-Type
    NSString *strContentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", randomIDStr];
    [request setValue:strContentType forHTTPHeaderField:@"Content-Type"];
    
    // 3> 连接服务器发送请求
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"%@", result);
        
    }];
}


//上船
- (void)uploadFileWithURL:(NSURL *)url data:(NSData *)data fileName:(NSString *) pFileName success:(void(^)(id pResult)) pSuccessHandler error:(void(^)(NSException *pError))pErrorHandler
{
//    @try {
        // 1> 数据体
        NSString *topStr = @"";//[self topStringWithMimeType:@"image/png" uploadFile:pFileName];
        NSString *bottomStr = @"";//[self bottomString];
        
        NSMutableData *dataM = [NSMutableData data];
        [dataM appendData:[topStr dataUsingEncoding:NSUTF8StringEncoding]];
        [dataM appendData:data];
        [dataM appendData:[bottomStr dataUsingEncoding:NSUTF8StringEncoding]];
        
        // 1. Request
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:0 timeoutInterval:2.0f];
        
        // dataM出了作用域就会被释放,因此不用copy
        request.HTTPBody = dataM;
        
        // 2> 设置Request的头属性
        request.HTTPMethod = @"POST";
        
        // 3> 设置Content-Length
        NSString *strLength = [NSString stringWithFormat:@"%ld", (long)dataM.length];
        [request setValue:strLength forHTTPHeaderField:@"Content-Length"];
        
        // 4> 设置Content-Type
        NSString *strContentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", randomIDStr];
        [request setValue:strContentType forHTTPHeaderField:@"Content-Type"];
//        NSError *err;
        // 3> 连接服务器发送请求
        [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            
            NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            //NSLog(@"%@", result);
            pSuccessHandler(result);
        }];

//    }
//    @catch (NSException *exception) {
//        pErrorHandler(exception);
//    }


}


#pragma  mark 上传

- (void)upload:(NSString *)name filename:(NSString *)filename mimeType:(NSString *)mimeType data:(NSData *)data parmas:(NSDictionary *)params mUrl:(NSString *) pUrl
{
    // 文件上传
    NSURL *url = [NSURL URLWithString:pUrl];//[NSURL URLWithString:@"http://192.168.1.200:8080/YYServer/upload"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    
    // 设置请求体
    NSMutableData *body = [NSMutableData data];
    
    /***************文件参数***************/
    // 参数开始的标志
    [body appendData:YYEncode(@"--YY\r\n")];
    // name : 指定参数名(必须跟服务器端保持一致)
    // filename : 文件名
    NSString *disposition = [NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n", name, filename];
    [body appendData:YYEncode(disposition)];
    NSString *type = [NSString stringWithFormat:@"Content-Type: %@\r\n", mimeType];
    [body appendData:YYEncode(type)];
    
    [body appendData:YYEncode(@"\r\n")];
    [body appendData:data];
    [body appendData:YYEncode(@"\r\n")];
    
    /***************普通参数***************/
    [params enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        // 参数开始的标志
        [body appendData:YYEncode(@"--YY\r\n")];
        NSString *disposition = [NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n", key];
        [body appendData:YYEncode(disposition)];
        
        [body appendData:YYEncode(@"\r\n")];
        [body appendData:YYEncode(obj)];
        [body appendData:YYEncode(@"\r\n")];
    }];
    
    /***************参数结束***************/
    // YY--\r\n
    [body appendData:YYEncode(@"--YY--\r\n")];
    request.HTTPBody = body;
    
    // 设置请求头
    // 请求体的长度
    [request setValue:[NSString stringWithFormat:@"%zd", body.length] forHTTPHeaderField:@"Content-Length"];
    // 声明这个POST请求是个文件上传
    [request setValue:@"multipart/form-data; boundary=YY" forHTTPHeaderField:@"Content-Type"];
    
    // 发送请求
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (data) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            NSLog(@"%@", dict);
        } else {
            NSLog(@"上传失败");
        }
    }];
}

- (void)uploadFileWithHost:(NSString  *)pUrl fileName:(NSString *)pFileName mFilePath:(NSString *) pPath
{
    // Socket 实现断点上传
    
    //apache-tomcat-6.0.41/conf/web.xml 查找 文件的 mimeType
    //    UIImage *image = [UIImage imageNamed:@"test"];
    //    NSData *filedata = UIImagePNGRepresentation(image);
    //    [self upload:@"file" filename:@"test.png" mimeType:@"image/png" data:filedata parmas:@{@"username" : @"123"}];
    
    // 给本地文件发送一个请求
    NSURL *fileurl = [[NSBundle mainBundle] URLForResource:pPath withExtension:nil];
    NSURLRequest *request = [NSURLRequest requestWithURL:fileurl];
    NSURLResponse *repsonse = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&repsonse error:nil];
    
    // 得到mimeType
    NSLog(@"%@", repsonse.MIMEType);
    [self upload:@"file" filename:pFileName mimeType:repsonse.MIMEType data:data parmas:nil mUrl:pUrl];
}

@end

