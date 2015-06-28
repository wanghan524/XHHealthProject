//
//  HeadView.m
//  XHHealthProject
//
//  Created by 菁优数学 on 15/6/28.
//  Copyright (c) 2015年 AlexYang. All rights reserved.
//

#import "HeadView.h"

@implementation HeadView

-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        [self makeUI];
    }
    return self;
    
}


-(void)tapClick:(UITapGestureRecognizer *)tap
{
    [self.delegate headerImageViewClick];
}


-(void)makeUI
{
    self.headImgView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 20, 70, 70)];
    self.headImgView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
    [self.headImgView addGestureRecognizer:tap];
    
    
    
    
    self.headImgView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.headImgView];
    
    
    self.name = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.headImgView.frame)+10, CGRectGetMinY(self.headImgView.frame)+10,200 - 47 - (CGRectGetMaxX(self.headImgView.frame) + 10), 30)];
    self.name.font = [UIFont systemFontOfSize:13];
    self.name.backgroundColor = [UIColor clearColor];
    self.name.textColor = [UIColor blackColor];
    [self addSubview:self.name];
    
    self.card = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.name.frame), CGRectGetMaxY(self.name.frame)+5, 200 - 47 - (CGRectGetMaxX(self.headImgView.frame) + 10), 30)];
    self.card.backgroundColor = [UIColor clearColor];
    [self.card setFont:[UIFont systemFontOfSize:13]];
    [self addSubview:self.card];
    
    
    self.indicatorImgView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.card.frame)+5, CGRectGetMinY(self.name.frame)+15, 74/2, 20)];
    self.indicatorImgView.image = [UIImage imageNamed:@"more" ];
    [self addSubview:self.indicatorImgView];

    
    
    self.button  = [UIButton buttonWithType:UIButtonTypeCustom];
    self.button.backgroundColor = [UIColor redColor];
    [self.button setTitle:@"体质检查参考结论" forState:UIControlStateNormal];
    self.button.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.button setFrame:CGRectMake(0, CGRectGetMaxY(self.headImgView.frame)+10, 210, 40)];
    [self addSubview:self.button];
    
}


@end
