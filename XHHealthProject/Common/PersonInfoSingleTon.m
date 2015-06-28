//
//  PersonInfoSingleTon.m
//  XHHealthProject
//
//  Created by BlueApp on 15-6-28.
//  Copyright (c) 2015年 AlexYang. All rights reserved.
//

#import "PersonInfoSingleTon.h"

static PersonInfoSingleTon *infoSingleTon = nil;


@implementation PersonInfoSingleTon


+ (id)personInfoShareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        infoSingleTon = [[PersonInfoSingleTon alloc] init];
    });
    return infoSingleTon;
}
@end
