//
//  EcgModel.h
//  XHHealthProject
//
//  Created by 菁优数学 on 15/6/22.
//  Copyright (c) 2015年 AlexYang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EcgModel : NSObject
@property(nonatomic,copy)NSString *Rate_cn;
@property(nonatomic,copy)NSString *Rate_value;
@property(nonatomic,copy)NSString *Rate_refinterVal;


@property(nonatomic,copy)NSString *Pr_cn;
@property(nonatomic,copy)NSString *Pr_value;
@property(nonatomic,copy)NSString *Pr_refinterVal;

@property(nonatomic,copy)NSString *Qrs_cn;
@property(nonatomic,copy)NSString *Qrs_value;
@property(nonatomic,copy)NSString *Qrs_refinterVal;

@property(nonatomic,copy)NSString *Qt_cn;
@property(nonatomic,copy)NSString *Qt_value;
@property(nonatomic,copy)NSString *Qt_refinterVal;


@property(nonatomic,copy)NSString *Qtc_cn;
@property(nonatomic,copy)NSString *Qtc_value;
@property(nonatomic,copy)NSString *Qtc_refinterVal;


@property(nonatomic,copy)NSString *Raxis_cn;
@property(nonatomic,copy)NSString *Raxis_value;
@property(nonatomic,copy)NSString *Raxis_refinterVal;

@property(nonatomic,copy)NSString *SokolowLyon_cn;
@property(nonatomic,copy)NSString *SokolowLyon_value;
@property(nonatomic,copy)NSString *SokolowLyon_refinterVal;

@property(nonatomic,copy)NSString *Cornell_cn;
@property(nonatomic,copy)NSString *Cornell_value;
@property(nonatomic,copy)NSString *Cornell_refinterVal;

@property(nonatomic,copy)NSString *EcgResult_cn;
@property(nonatomic,copy)NSString *EcgResult_value;
@property(nonatomic,copy)NSString *EcgUrl;


@property(nonatomic,copy)NSString *Exmessage;


@end
