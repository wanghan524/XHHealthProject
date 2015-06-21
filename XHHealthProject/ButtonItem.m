//
//  ButtonItem.m
//  JingyouMath
//
//  Created by 菁优数学 on 15/5/21.
//  Copyright (c) 2015年 jemmy. All rights reserved.
//

#import "ButtonItem.h"

@implementation ButtonItem

-(id)forwardingTargetForSelector:(SEL)aSelector
{
    if(aSelector)
    {
        DLog(@"%@",NSStringFromSelector(aSelector));
        return NSStringFromSelector(aSelector);
    }
    return nil;
}

@end
