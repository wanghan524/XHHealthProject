//
//  EditPassVC.m
//  XHHealthProject
//
//  Created by 菁优数学 on 15/6/28.
//  Copyright (c) 2015年 AlexYang. All rights reserved.
//

#import "EditPassVC.h"
#import "XHNavigationView.h"
#import "WSRequestManager.h"

@interface EditPassVC ()<UITextFieldDelegate>
@property(nonatomic,strong)XHNavigationView *navView;
@property(nonatomic,strong)UIView *bgView;




@property(nonatomic,strong)UILabel *originPass;
@property(nonatomic,strong)UILabel *newsPass;
@property(nonatomic,strong)UILabel *confirmPass;

@property(nonatomic,strong)UITextField *originText;
@property(nonatomic,strong)UITextField *newsText;
@property(nonatomic,strong)UITextField *confirmText;


@end

@implementation EditPassVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self bulidNav];
    [self makeBGView];
    [self makeUI];
}


-(void)makeUI
{
    self.originPass = [[UILabel alloc]initWithFrame:CGRectMake(2, 10, 200, 30)];
    self.originPass.text = @"原密码";
    self.originPass.backgroundColor = [UIColor clearColor];
    self.originPass.font  =[ UIFont systemFontOfSize:14];
    [self.bgView addSubview:self.originPass];
    
    self.originText = [[UITextField alloc]initWithFrame:CGRectMake(2, CGRectGetMaxY(self.originPass.frame)+5, ScreenWidth - 4, 40)];
    self.originText.layer.borderColor = [UIColor grayColor].CGColor;
    self.originText.layer.cornerRadius = 5;
    self.originText.layer.masksToBounds = YES;
    self.originText.layer.borderWidth = 1.f;
    self.originText.delegate = self;
    self.originText.borderStyle = UITextBorderStyleRoundedRect;
    self.originText.font = [UIFont systemFontOfSize:14];
    [self.bgView addSubview:self.originText];
    
    self.newsPass = [[UILabel alloc]initWithFrame:CGRectMake(2, CGRectGetMaxY(self.originText.frame)+10, 100, 30)];
    self.newsPass.text = @"新密码";
    self.newsPass.backgroundColor = [UIColor clearColor];
    self.newsPass.font = [UIFont systemFontOfSize:14];
    [self.bgView addSubview:self.newsPass];
    
    self.newsText = [[UITextField alloc]initWithFrame:CGRectMake(2, CGRectGetMaxY(self.newsPass.frame)+5, ScreenWidth -4, 40)];
    self.newsText.layer.borderWidth = 1.f;
    self.newsText.layer.borderColor = [UIColor grayColor].CGColor;
    
    self.newsText.layer.cornerRadius = 5;
    self.newsText.layer.masksToBounds = YES;
    self.newsText.delegate = self;
    
    self.newsText.borderStyle  = UITextBorderStyleRoundedRect;
    self.newsText.font = [UIFont systemFontOfSize:14];
    [self.bgView addSubview:self.newsText];
    
    self.confirmPass = [[UILabel alloc]initWithFrame:CGRectMake(2, CGRectGetMaxY(self.newsText.frame)+10, 100, 30)];
    self.confirmPass.text = @"确认新密码";
    self.confirmPass.backgroundColor = [UIColor clearColor];
    self.confirmPass.font = [UIFont systemFontOfSize:14];
    [self.bgView addSubview:self.confirmPass];
    
    self.confirmText = [[UITextField alloc]initWithFrame:CGRectMake(2, CGRectGetMaxY(self.confirmPass.frame)+5, ScreenWidth - 4 , 40)];
    self.confirmText.layer.borderColor = [UIColor grayColor].CGColor;
    self.confirmText.layer.borderWidth = 1.f;
    
    self.confirmText.layer.cornerRadius = 5;
    self.confirmText.layer.masksToBounds = YES;
    //self.confirmText.secureTextEntry = YES;
    
    self.confirmText.delegate = self;
    self.confirmText.font = [UIFont systemFontOfSize:14];
    self.confirmText.borderStyle = UITextBorderStyleRoundedRect;
    [self.bgView addSubview:self.confirmText];

    
    
}

-(void)makeBGView
{
    self.bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64)];
    self.bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.bgView];
}







-(void)bulidNav
{
    self.navView = [[XHNavigationView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth,64)];
    [self.navView layoutXHNavWithType:Type_RightBtn];
    self.navView.backgroundColor = NAVColor;
    [self.navView.btn_login setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [self.navView.btn_login addTarget:self action:@selector(backBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.navView.lbl_login_middle.text = @"修改密码";
    [self.navView.rightBtn setTitle:@"完成" forState:UIControlStateNormal];
    [self.navView.rightBtn addTarget:self action:@selector(finishButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view addSubview:self.navView];
}

- (void)finishButtonClick{
    DLog(@"finish ");
    
    if ([self.originText.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入原密码!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        return;
    }
    
    if (![self.newsText.text isEqualToString:self.confirmText.text]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"新密码输入不同,请重输..." delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        return;
    }
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    [WSRequestManager XHGetRequestParameters:@{@"_IDNumber":[user stringForKey:@"IdNumber"],@"_OldPwd":self.originText.text,@"_NewPwd":self.newsText.text} withMethodName:CHANGEPASSWORD SuccessRequest:^(id data) {
        NSArray *resultArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        
        if([resultArray count] > 0)
        {
            NSDictionary *resultDic = resultArray[0];
            
            if ([[resultDic objectForKey:@"Success"] isEqualToString:@"true"]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"修改成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alert show];
            }else{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:resultDic[@"ExMessage"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alert show];
            }
            
            //[self showErrorHUDWithStr:resultDic[@"ExMessage"]];
        }
        
    } FailRequest:^(id data, NSError *error) {
        
    }];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    /*
     
     @property(nonatomic,strong)UITextField *originText;
     @property(nonatomic,strong)UITextField *newsText;
     @property(nonatomic,strong)UITextField *confirmText;
     */
    if (textField == self.originText ) {
        self.originText.layer.borderColor = [UIColor orangeColor].CGColor;
        self.newsText.layer.borderColor = [UIColor grayColor].CGColor;
        self.confirmText.layer.borderColor = [UIColor grayColor].CGColor;
    }
    
    else if (textField == self.newsText){
        self.originText.layer.borderColor = [UIColor grayColor].CGColor;
        self.newsText.layer.borderColor = [UIColor orangeColor].CGColor;
        self.confirmText.layer.borderColor = [UIColor grayColor].CGColor;
    }
    
    else if (textField == self.confirmText){
        self.originText.layer.borderColor = [UIColor grayColor].CGColor;
        self.newsText.layer.borderColor = [UIColor grayColor].CGColor;
        self.confirmText.layer.borderColor = [UIColor orangeColor].CGColor;
    }
}


-(void)backBtn:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}


@end
