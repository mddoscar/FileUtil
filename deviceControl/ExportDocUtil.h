//
//  ExportDocUtil.h
//  com.mddoscar.mddhelper
//
//  Created by mac on 16/6/13.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 导出工具类
 */
@interface ExportDocUtil : NSObject
- (void) exportImpl;

- (void) mail: (NSString*) filePath;
@end
