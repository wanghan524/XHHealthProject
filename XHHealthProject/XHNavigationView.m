//
//  XHNavigationView.m
//  XHHealthProject
//
//  Created by 菁优数学 on 15/6/14.
//  Copyright (c) 2015年 AlexYang. All rights reserved.
//

#import "XHNavigationView.h"
@implementation XHNavigationView


-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        self.type = Type_LoginNav;
        self.backgroundColor = NAVColor;
    }
    return self;
}

-(void)layoutXHNavWithType:(Type_XHNav)type
{
    switch (type)
    {
        case Type_LoginNav:
            [self bulidingloginNav];
            break;
            
        default:
            break;
    }
}



-(void)bulidingloginNav
{
    CGPoint centers = self.center;
    self.btn_login = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btn_login.frame = CGRectMake(10, NAVIGATIONHEIGHT + 6, 32,32);
    
    [self.btn_login setBackgroundColor:[UIColor clearColor]];
    [self addSubview:self.btn_login];
    
    
    self.lbl_login = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.btn_login.frame)+5, NAVIGATIONHEIGHT+6,100, 32)];
    self.lbl_login.backgroundColor = [UIColor clearColor];
    self.lbl_login.textAlignment = NSTextAlignmentLeft;
    self.lbl_login.font = [UIFont systemFontOfSize:14];
    self.lbl_login.textColor = [UIColor whiteColor];
    self.lbl_login.adjustsFontSizeToFitWidth = YES;
    [self addSubview:self.lbl_login];
    
    self.lbl_login_middle = [[UILabel alloc]initWithFrame:CGRectMake(0, NAVIGATIONHEIGHT, 250, 32)];
    self.lbl_login_middle.backgroundColor = [UIColor clearColor];
    self.lbl_login_middle.textColor = [UIColor whiteColor];
    self.lbl_login_middle.textAlignment = NSTextAlignmentCenter;
    self.lbl_login_middle.font = [UIFont systemFontOfSize:20];
    
    centers.y += 6;
    self.lbl_login_middle.center = centers;
    
    [self addSubview:self.lbl_login_middle];
}


@end
