//
//  MddBlueToothHelper.m
//  ChildrenLocation
//
//  Created by szalarm on 15/10/13.
//  Copyright © 2015年 szalarm. All rights reserved.
//

#import "MddBlueToothHelper.h"

#import <CoreBluetooth/CoreBluetooth.h>

@implementation MddBlueToothHelper


-(void)startBluetooth{
//#if TARGET_IPHONE_SIMULATOR
//    exit( EXIT_SUCCESS ) ;
//#else
//    /* this works in iOS 4.2.3 */
//    Class BluetoothManager = objc_getClass( "BluetoothManager" ) ;
//
//    id btCont = [BluetoothManager sharedInstance] ;
//    [self performSelector:@selector(toggle:) withObject:btCont afterDelay:1.0f] ;
//#endif
}

#if TARGET_IPHONE_SIMULATOR
#else
- (void)toggle:(id)btCont
{
    //反射1
//    SEL selector = NSSelectorFromString(@"enabled");
//    IMP imp = [btCont methodForSelector:selector];
//    BOOL currentState = imp;//[btCont enabled] ;
//    [btCont setEnabled:!currentState] ;
//    
////    [btCont setPowered:!currentState] ;
//    
//    SEL selectorPower = NSSelectorFromString(@"setPowered");
//    [self performSelector:@selector(selectorPower:) withObject:!currentState ] ;
    
    
}
#endif

@end
