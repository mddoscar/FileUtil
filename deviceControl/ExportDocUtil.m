//
//  ExportDocUtil.m
//  com.mddoscar.mddhelper
//
//  Created by mac on 16/6/13.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ExportDocUtil.h"
//

//#import "MFMailComposeViewController.h"

@implementation ExportDocUtil
- (void) exportImpl
{
//    NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
//    
//    NSArray* documentPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSSystemDomainMask, YES);
//    NSString* documentsDir = [documentPaths objectAtIndex:0];
//    NSString* csvPath = [documentsDir stringByAppendingPathComponent: @"export.csv"];
//    
//    // TODO: mutex lock?
//    [sqliteDb exportCsv: csvPath];
//    
//    [pool release];
//    
//    // mail is graphical and must be run on UI thread
//    [self performSelectorOnMainThread: @selector(mail:) withObject: csvPath waitUntilDone: NO];
}

- (void) mail: (NSString*) filePath
{
//    // here I stop animating the UIActivityIndicator
//    
//    // http://howtomakeiphoneapps.com/home/2009/7/14/how-to-make-your-iphone-app-send-email-with-attachments.html
//    BOOL success = NO;
//    if ([MFMailComposeViewController canSendMail]) {
//        // TODO: autorelease pool needed ?
//        NSData* database = [NSData dataWithContentsOfFile: filePath];
//        
//        if (database != nil) {
//            MFMailComposeViewController* picker = [[MFMailComposeViewController alloc] init];
//            picker.mailComposeDelegate = self;
//            [picker setSubject:[NSString stringWithFormat: @"%@ %@", [[UIDevice currentDevice] model], [filePath lastPathComponent]]];
//            
//            NSString* filename = [filePath lastPathComponent];
//            [picker addAttachmentData: database mimeType:@"application/octet-stream" fileName: filename];
//            NSString* emailBody = @"Attached is the SQLite data from my iOS device.";
//            [picker setMessageBody:emailBody isHTML:YES];
//            
//            [self presentModalViewController:picker animated:YES];
//            success = YES;
//            [picker release];
//        }
//    }
//    
//    if (!success) {
//        UIAlertView* warning = [[UIAlertView alloc] initWithTitle: @"Error"
//                                                          message: @"Unable to send attachment!"
//                                                         delegate: self
//                                                cancelButtonTitle: @"Ok"
//                                                otherButtonTitles: nil];
//        [warning show];
//        [warning release];
//    }
}
@end
