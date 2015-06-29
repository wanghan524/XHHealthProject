//
//  PersonLoginInfoVC.m
//  XHHealthProject
//
//  Created by 菁优数学 on 15/6/28.
//  Copyright (c) 2015年 AlexYang. All rights reserved.
//

#import "PersonLoginInfoVC.h"
#import "XHNavigationView.h"
#import "WSRequestManager.h"

@interface PersonLoginInfoVC ()
@property(nonatomic,strong)XHNavigationView *navView;
@end

@implementation PersonLoginInfoVC
-(void)bulidNav
{
    self.navView = [[XHNavigationView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth,64)];
    [self.navView layoutXHNavWithType:Type_LoginNav];
    self.navView.backgroundColor = NAVColor;
    [self.navView.btn_login setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [self.navView.btn_login addTarget:self action:@selector(backBtn:) forControlEvents:UIControlEventTouchUpInside];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    if ([user valueForKey:@"UserName"] != nil) {
        self.navView.lbl_login.text = [user valueForKey:@"UserName"];
    }else{
        self.navView.lbl_login.text = @"登录";
    }
    [self.view addSubview:self.navView];
}

-(void)backBtn:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self bulidNav];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
