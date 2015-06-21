//
//  XHNavigationView.h
//  XHHealthProject
//
//  Created by 菁优数学 on 15/6/14.
//  Copyright (c) 2015年 AlexYang. All rights reserved.
//




#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, Type_XHNav)
{
    Type_LoginNav
};




@interface XHNavigationView : UIView
@property (nonatomic,assign) Type_XHNav type;
@property (nonatomic,strong) UIButton *btn_login;
@property (nonatomic,strong) UILabel  *lbl_login;
@property (nonatomic,strong) UILabel  *lbl_login_middle;

-(void)layoutXHNavWithType:(Type_XHNav)type;

@end
