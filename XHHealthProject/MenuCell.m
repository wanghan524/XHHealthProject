//
//  MenuCell.m
//  XHHealthProject
//
//  Created by 菁优数学 on 15/6/14.
//  Copyright (c) 2015年 AlexYang. All rights reserved.
//

#import "MenuCell.h"

@implementation MenuCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self makeUI];
    }
    return self;
}



-(void)makeUI
{
    self.img = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 40, 30)];
    self.img.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.img];
    
    self.lab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.img.frame)+5, 10, 250, 30)];
    self.lab.backgroundColor = [UIColor clearColor];
    self.lab.textColor = [UIColor lightGrayColor];
    self.lab.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.lab];
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

   
}

@end
