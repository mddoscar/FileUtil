//
//  NumberHelper.m
//  ChildrenLocation
//
//  Created by szalarm on 15/10/5.
//  Copyright © 2015年 szalarm. All rights reserved.
//

#import "NumberHelper.h"

@implementation NumberHelper

#pragma mark private
-(int)getRandomNumber:(int)from to:(int)to

{
    return (int)(from + (arc4random() % (to-from + 1)))+1;
}

//获取9999内的随机数
-(int)getDoubleHounderRandom
{
    return (int)(0 + (arc4random() % (10000-0 + 1)))+1;
}
#pragma  mark static
+(int)getRandomNumber:(int)from to:(int)to

{
    return (int)(from + (arc4random() % (to-from + 1)))+1;
}

//获取9999内的随机数
+(int)getDoubleHounderRandom
{
    return (int)(0 + (arc4random() % (10000-0 + 1)))+1;
}


@end
