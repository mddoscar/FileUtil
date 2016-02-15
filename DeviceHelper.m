//
//  DeviceHelper.h
//  onemap
//
//  Created by 月光 on 15/3/26.
//  Copyright (c) 2015年 肖光. All rights reserved.
//

#import "DeviceHelper.h"

//
#include <sys/socket.h> // Per msqr
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
@implementation DeviceHelper

+ (BOOL)isPortrait:(UIView *)view{
    if(view){
        return (view.bounds.size.width<view.bounds.size.height);
    }
    return YES;
}


+ (BOOL)isLandscape:(UIView *)view{
    if(view){
        return (view.bounds.size.width>view.bounds.size.height);
    }
    return NO;
}

+(NSUInteger)screenWidth{
    return [UIScreen mainScreen].bounds.size.width;
}

+(NSUInteger)screenHeight{
    return [UIScreen mainScreen].bounds.size.height;
}

+(CGPoint)screenCenter{
    return CGPointMake([self screenWidth]/2, [self screenHeight]/2);
}

+(NSString *) macaddress
{
    int                    mib[6];
    size_t                len;
    char                *buf;
    unsigned char        *ptr;
    struct if_msghdr    *ifm;
    struct sockaddr_dl    *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error/n");
        return NULL;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1/n");
        return NULL;
    }
    
    if ((buf = malloc(len)) == NULL) {
        printf("Could not allocate memory. error!/n");
        return NULL;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 2");
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    // NSString *outstring = [NSString stringWithFormat:@"%02x:%02x:%02x:%02x:%02x:%02x", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    NSString *outstring = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    free(buf);
    return [outstring uppercaseString];
}

@end
