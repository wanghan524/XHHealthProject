//
//  LoginVC.m
//  XHHealthProject
//
//  Created by 菁优数学 on 15/6/15.
//  Copyright (c) 2015年 AlexYang. All rights reserved.
//

#import "LoginVC.h"
#import "XHNavigationView.h"
#import "WSRequestManager.h"
#import "MBProgressHUD.h"

@interface LoginVC ()<UITextFieldDelegate,MBProgressHUDDelegate>
@property(nonatomic,strong)XHNavigationView *navView;

@property(nonatomic,strong)UIView *bgView;
@property(nonatomic,strong)UITextField *userTxt;
@property(nonatomic,strong)UITextField *passwordTxt;
@property(nonatomic,strong)UILabel *promptLab;
@property(nonatomic,strong)UILabel *userLab;
@property(nonatomic,strong)UILabel *passLab;
@property(nonatomic,strong)UIButton *loginBtn;
@property(nonatomic,strong)MBProgressHUD *hud;

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self bulidNav];
    [self buildLoginView];
}




















-(void)buildLoginView
{
    self.bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth,ScreenHeight-64)];
    self.bgView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.bgView];
    
    self.userLab = [[UILabel alloc]initWithFrame:CGRectMake(20, 20, ScreenWidth - 40, 20)];
    self.userLab.backgroundColor = [UIColor clearColor];
    self.userLab.text = @"用户名";
    self.userLab.font = [UIFont systemFontOfSize:14];
    [self.bgView addSubview:self.userLab];
    
    
    self.userTxt = [[UITextField alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(self.userLab.frame), ScreenWidth-10, 40)];
    self.userTxt.borderStyle = UITextBorderStyleRoundedRect;
    self.userTxt.font = [UIFont systemFontOfSize:13];
    self.userTxt.delegate = self;
    [self.bgView addSubview:self.userTxt];
    
    
    self.passLab = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(self.userTxt.frame)+10, ScreenWidth-40, 20)];
    self.passLab.backgroundColor = [UIColor clearColor];
    self.passLab.text = @"密码";
    self.passLab.font = [UIFont systemFontOfSize:14];
    [self.bgView addSubview:self.passLab];
    
    self.passwordTxt = [[UITextField alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(self.passLab.frame), ScreenWidth-10, 40)];
    self.passwordTxt.borderStyle = UITextBorderStyleRoundedRect;
    self.passwordTxt.font = [UIFont systemFontOfSize:13];
    self.passwordTxt.delegate = self;
    [self.bgView addSubview:self.passwordTxt];
    
    self.promptLab = [[UILabel alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(self.passwordTxt.frame), ScreenWidth-5, 20)];
    self.promptLab.font = [UIFont systemFontOfSize:12];
    self.promptLab.adjustsFontSizeToFitWidth = YES;
    self.promptLab.text = @"初始密码为身份证后6位,可修改密码,密码丢失后不能找回";
    [self.bgView addSubview:self.promptLab];
    
    self.loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.loginBtn.frame = CGRectMake(20, CGRectGetMaxY(self.promptLab.frame)+20, ScreenWidth-40, 40);
    self.loginBtn.layer.cornerRadius = 10;
    self.loginBtn.layer.masksToBounds = YES;
    self.loginBtn.backgroundColor = NAVColor;
    [self.loginBtn addTarget:self action:@selector(loginClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [self.bgView addSubview:self.loginBtn];
    
}

-(void)showErrorHUDWithStr:(NSString *)str
{
    self.hud = [[MBProgressHUD alloc]initWithView:self.bgView];
    [self.bgView addSubview:self.hud];
    
    self.hud.mode = MBProgressHUDModeCustomView;
    self.hud.delegate = self;
    self.hud.labelText = str;
    [self.hud show:YES];
    [self.hud hide:YES afterDelay:2.0f];
}



-(void)makeMB
{
    self.hud = [MBProgressHUD showHUDAddedTo:self.bgView animated:YES] ;
    self.hud.delegate = self;
    self.hud.mode = MBProgressHUDModeDeterminateHorizontalBar;
    
}

#pragma mark MB代理 start
-(void)hudWasHidden:(MBProgressHUD *)hud
{
    [self.hud removeFromSuperview];
    self.hud = nil;
}
#pragma mark MB代理 end




-(void)loginClick:(UIButton *)sender
{
    

    
    [WSRequestManager XHGetRequestParameters:@{@"_IDNumber":self.userTxt.text,@"_Pwd":self.passwordTxt.text} withMethodName:ONLOGIN SuccessRequest:^(id data) {
        NSArray *resultArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];

        if([resultArray count] > 0)
        {
            NSDictionary *resultDic = resultArray[0];
            
            NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
            [user setObject:[resultDic objectForKey:@"Address"] forKey:@"Address"];
            [user setObject:[resultDic objectForKey:@"Email"] forKey:@"Email"];
            [user setObject:[resultDic objectForKey:@"Phone"] forKey:@"Phone"];
            [user setObject:[resultDic objectForKey:@"Sex"] forKey:@"Sex"];
            
            [user setObject:[resultDic objectForKey:@"Success"] forKey:@"Success"];
            [user setObject:[resultDic objectForKey:@"UserImage"] forKey:@"UserImage"];
            [user setObject:[resultDic objectForKey:@"UserName"] forKey:@"UserName"];
            [user setObject:self.userTxt.text forKey:@"IdNumber"];
            
            
            [self showErrorHUDWithStr:resultDic[@"ExMessage"]];
        }

    } FailRequest:^(id data, NSError *error) {
        
    }];
    

    
}



-(void)bulidNav
{
    self.navView = [[XHNavigationView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth,64)];
    [self.navView layoutXHNavWithType:Type_LoginNav];
    self.navView.backgroundColor = NAVColor;
    [self.navView.btn_login setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [self.navView.btn_login addTarget:self action:@selector(backBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.navView.lbl_login_middle.text = @"登录";
    [self.view addSubview:self.navView];
}

-(void)backBtn:(UIButton *)sender
{
    
    if ([self.flagString isEqualToString:@"left"]) {
        HomePageVC *homeVC = [[HomePageVC alloc]init];
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:homeVC];
        
        AppDelegate *delegate = [UIApplication sharedApplication].delegate;
        [delegate.draw closeDrawerAnimated:YES completion:nil];
        delegate.draw.centerViewController = nav;
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
