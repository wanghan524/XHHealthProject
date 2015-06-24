//
//  BloodPressureModel.h
//  XHHealthProject
//
//  Created by 菁优数学 on 15/6/22.
//  Copyright (c) 2015年 AlexYang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BloodPressureModel : NSObject


@property(nonatomic,copy)NSString *Hsbp_cn;
@property(nonatomic,copy)NSString *Hsbp_value;
@property(nonatomic,copy)NSString *Hsbp_refinterVal;


@property(nonatomic,copy)NSString *Hdbp_cn;
@property(nonatomic,copy)NSString *Hdbp_value;
@property(nonatomic,copy)NSString *Hdbp_refinterVal;

@property(nonatomic,copy)NSString *Pulse_cn;
@property(nonatomic,copy)NSString *Pulse_value;
@property(nonatomic,copy)NSString *Pulse_refinterVal;

@property(nonatomic,copy)NSString *Temp_cn;
@property(nonatomic,copy)NSString *Temp_value;
@property(nonatomic,copy)NSString *Temp_refinterVal;


@property(nonatomic,copy)NSString *Exmessage;


@end
