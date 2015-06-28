//
//  PersonInfoSingleTon.h
//  XHHealthProject
//
//  Created by BlueApp on 15-6-28.
//  Copyright (c) 2015年 AlexYang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersonInfoSingleTon : NSObject

+(id)personInfoShareInstance;

@property (nonatomic, strong) NSString *addressString;
@property (nonatomic, strong) NSString *emailString;
@property (nonatomic, strong) NSString *exMessageString;
@property (nonatomic, strong) NSString *phoneString;
@property (nonatomic, strong) NSString *sexString;
@property (nonatomic, strong) NSString *successString;
@property (nonatomic, strong) NSString *userImageString;
@property (nonatomic, strong) NSString *userNameString;

@property (nonatomic, strong) NSString *idNumberString;
@end
