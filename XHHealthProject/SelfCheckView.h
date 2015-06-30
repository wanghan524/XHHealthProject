//
//  SelfCheckView.h
//  XHHealthProject
//
//  Created by 菁优数学 on 15/7/1.
//  Copyright (c) 2015年 AlexYang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelfCheckView : UIView
@property(nonatomic,strong)UIView *maskView;
-(void)makeMidTableView:(CGRect)rect withArray:(NSArray*)dataArr;


@end
