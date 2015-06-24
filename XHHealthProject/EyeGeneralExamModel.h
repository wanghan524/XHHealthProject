//
//  EyeGeneralExamModel.h
//  XHHealthProject
//
//  Created by 菁优数学 on 15/6/24.
//  Copyright (c) 2015年 AlexYang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EyeGeneralExamModel : NSObject

@property(nonatomic,copy)NSString *Vision_cn;
@property(nonatomic,copy)NSString *Od_value;
@property(nonatomic,copy)NSString *Os_value;

@property(nonatomic,copy)NSString *PeryGium_cn;
@property(nonatomic,copy)NSString *Nasal_cn;
@property(nonatomic,copy)NSString *Nasalact_cn;

@property(nonatomic,copy)NSString *Temporal_cn;
@property(nonatomic,copy)NSString *Temporalact_cn;
@property(nonatomic,copy)NSString *RpteryGium_value;

@property(nonatomic,copy)NSString *Rnasal_value;
@property(nonatomic,copy)NSString *Rnasalact_value;
@property(nonatomic,copy)NSString *Rtemporal_value;

@property(nonatomic,copy)NSString *Rtemporalact_value;
@property(nonatomic,copy)NSString *LpteryGium_value;
@property(nonatomic,copy)NSString *Lnasal_value;

@property(nonatomic,copy)NSString *Lnasalact_value;
@property(nonatomic,copy)NSString *Ltemporal_value;
@property(nonatomic,copy)NSString *Ltemporalact_value;

@property(nonatomic,copy)NSString *ExMessage;

@end
