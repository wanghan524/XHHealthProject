//
//  ListButton.m
//  XHHealthProject
//
//  Created by 菁优数学 on 15/6/28.
//  Copyright (c) 2015年 AlexYang. All rights reserved.
//

#import "ListButton.h"
#import "UIColor+Category.h"

@implementation ListButton
-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        [self makeUI];
    }
    return self;
}


-(void)makeUI
{
    self.listbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.listbtn setFrame:self.bounds];
    self.listbtn.backgroundColor = COLOR(217, 217, 217, 1);
    [self addSubview:self.listbtn];
    
    self.btnName = [[UILabel alloc]initWithFrame:CGRectMake(10, (self.frame.size.height - 30)/2, 150, 30)];
    self.btnName.backgroundColor = [UIColor clearColor];
    self.btnName.font = [UIFont boldSystemFontOfSize:13];
    self.btnName.userInteractionEnabled = YES;
    [self.listbtn addSubview:self.btnName];
    
    self.rightImgView = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width - 20, (40-15)/2, 15, 15)];
    self.rightImgView.image = [UIImage imageNamed:@"bottom"];
    [self.listbtn addSubview:self.rightImgView];
    
}



@end
