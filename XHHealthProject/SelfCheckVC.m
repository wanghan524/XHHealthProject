//
//  SelfCheckVC.m
//  XHHealthProject
//
//  Created by 菁优数学 on 15/6/28.
//  Copyright (c) 2015年 AlexYang. All rights reserved.
//

#import "SelfCheckVC.h"
#import "XHNavigationView.h"
#import "ListButton.h"
@interface SelfCheckVC ()
@property(nonatomic,strong)XHNavigationView *navView;
@property(nonatomic,strong)UIView *bgView;

@property(nonatomic,strong)UITableView *generalTableView;
@property(nonatomic,strong)UITableView *heightTableView;
@property(nonatomic,strong)UITableView *sexTableView;
@property(nonatomic,strong)UITableView *ageTableView;
@property(nonatomic,strong)UILabel *testLabel;
@property(nonatomic,strong)UILabel *sexLabel;
@property(nonatomic,strong)UILabel *ageLabel;
@property(nonatomic,strong)UILabel *standleLabel;
@property(nonatomic,strong)UITextField *textField;
@property(nonatomic,strong)UIButton *testButton;

@property(nonatomic,strong)ListButton *generButton;
@property(nonatomic,strong)ListButton *heightButton;
@property(nonatomic,strong)ListButton *sexButton;
@property(nonatomic,strong)ListButton *ageButton;


@end

@implementation SelfCheckVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self bulidNav];
    [self makeBgView];
    [self bulidContext];
}
-(void)makeBgView
{
    self.bgView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.navView.frame), ScreenWidth, ScreenHeight)];
    self.bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.bgView];
}


-(void)bulidContext
{
    self.testLabel = [[UILabel alloc]initWithFrame:CGRectMake(2, 5, 200, 30)];
    self.testLabel.text = @"测试指标";
    self.testLabel.backgroundColor = [UIColor clearColor];
    self.testLabel.font = [UIFont boldSystemFontOfSize:14];
    [self.bgView addSubview:self.testLabel];
    
    self.generButton = [[ListButton alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(self.testLabel.frame)+5, ScreenWidth - 10, 40)];
    self.generButton.btnName.text = @"一般体质";
    [self.bgView addSubview:self.generButton];
    
    self.heightButton = [[ListButton alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(self.generButton.frame)+10, ScreenWidth - 10 , 40)];
    self.heightButton.btnName.text = @"身高";
    [self.bgView addSubview:self.heightButton];
    
    self.sexLabel = [[UILabel alloc]initWithFrame:CGRectMake(2, CGRectGetMaxY(self.heightButton.frame)+10, 200, 30)];
    self.sexLabel.text = @"性别";
    self.sexLabel.font = [UIFont boldSystemFontOfSize:14];
    self.sexLabel.backgroundColor = [UIColor clearColor];
    [self.bgView addSubview:self.sexLabel];
    
    self.sexButton = [[ListButton alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.sexLabel.frame)+5, (ScreenWidth - 40)/2, 40)];
    self.sexButton.btnName.text = @"男";
    [self.bgView addSubview:self.sexButton];
    
    self.ageLabel = [[UILabel alloc]initWithFrame:CGRectMake((ScreenWidth -40)/2 + 30, CGRectGetMinY(self.sexLabel.frame), 100, 30)];
    self.ageLabel.text = @"年龄";
    self.ageLabel.font = [UIFont boldSystemFontOfSize:14];
    
    self.ageLabel.backgroundColor = [UIColor clearColor];
    [self.bgView addSubview:self.ageLabel];
    
    self.ageButton = [[ListButton alloc]initWithFrame:CGRectMake((ScreenWidth - 40)/2 + 30, CGRectGetMinY(self.sexButton.frame),(ScreenWidth - 40)/2,40)];
    self.ageButton.btnName.text = @"1";
    [self.bgView addSubview:self.ageButton];
    
    
    self.standleLabel = [[UILabel alloc]initWithFrame:CGRectMake(2, CGRectGetMaxY(self.sexButton.frame)+10, 200, 30)];
    self.standleLabel.text = @"指标值(cm)";
    self.standleLabel.font = [UIFont boldSystemFontOfSize:14];
    self.standleLabel.backgroundColor = [UIColor clearColor];
    [self.bgView addSubview:self.standleLabel];
    
    self.textField = [[UITextField alloc]initWithFrame:CGRectMake(2, CGRectGetMaxY(self.standleLabel.frame)+5, ScreenWidth - 4, 40)];
    self.textField.borderStyle = UITextBorderStyleRoundedRect;
    self.textField.font = [UIFont systemFontOfSize:14];
    self.textField.layer.borderColor = [UIColor orangeColor].CGColor;
    self.textField.layer.borderWidth = 1.0f;
    [self.bgView addSubview:self.textField];
    
    
    self.testButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.testButton.frame = CGRectMake(2, CGRectGetMaxY(self.textField.frame)+5, ScreenWidth - 4, 40);
    self.testButton.backgroundColor = NAVColor;
    [self.testButton setTitle:@"测试" forState:UIControlStateNormal];
    self.testButton.layer.cornerRadius = 5;
    self.testButton.layer.masksToBounds = YES;
    [self.bgView addSubview:self.testButton];
    
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.testButton.frame)+10, ScreenWidth, 4)];
    line.backgroundColor = NAVColor;
    [self.bgView addSubview:line];
    
    
    
    
}










- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
-(void)bulidNav
{
    self.navView = [[XHNavigationView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth,64)];
    [self.navView layoutXHNavWithType:Type_LoginNav];
    self.navView.backgroundColor = NAVColor;
    [self.navView.btn_login setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [self.navView.btn_login addTarget:self action:@selector(backBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.navView.lbl_login_middle.text = @"自测";
    [self.view addSubview:self.navView];
}

-(void)backBtn:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
