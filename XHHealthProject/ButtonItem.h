//
//  ButtonItem.h
//  JingyouMath
//
//  Created by 菁优数学 on 15/5/21.
//  Copyright (c) 2015年 jemmy. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ButtonItem : NSObject
@property(nonatomic,copy)NSString *buttonImgName;
@property(nonatomic,copy)NSString *buttonLabName;
@property(nonatomic,assign)SEL selector;
@property(nonatomic,strong)id  target;
@property(nonatomic,assign)NSInteger tagNum;
@end
