//
//  BaseVC.m
//  XHHealthProject
//
//  Created by 菁优数学 on 15/6/14.
//  Copyright (c) 2015年 AlexYang. All rights reserved.
//

#import "BaseVC.h"

@interface BaseVC ()

@end

@implementation BaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationHidden:YES];
    [self setBGColor];
    
}

-(void)setBGColor
{
    self.view.backgroundColor = [UIColor whiteColor];
}

-(void)setNavigationHidden:(BOOL)hidden
{
    self.navigationController.navigationBar.hidden = hidden;
    if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)])
    {
        self.navigationController.interactivePopGestureRecognizer.enabled = hidden;
    }
    if(CD(7))
    {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
