//
//  FourthInfoCell.m
//  XHHealthProject
//
//  Created by BlueApp on 15-6-21.
//  Copyright (c) 2015年 AlexYang. All rights reserved.
//

#import "FourthInfoCell.h"

@implementation FourthInfoCell

- (void)awakeFromNib {
    
    self.translatesAutoresizingMaskIntoConstraints = NO;
    [self.middle_downLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.middle_upLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.right_downLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.right_upLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    self.middle_downLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.middle_upLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.right_downLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.right_upLabel.translatesAutoresizingMaskIntoConstraints = NO;
    // Initialization code
}

- (void)setTranslatesAutoresizingMaskIntoConstraints:(BOOL)flag{

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
