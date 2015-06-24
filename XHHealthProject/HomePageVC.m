//
//  HomePageVC.m
//  XHHealthProject
//
//  Created by 菁优数学 on 15/6/14.
//  Copyright (c) 2015年 AlexYang. All rights reserved.
//

#import "HomePageVC.h"
#import "XHNavigationView.h"
#import "LoginVC.h"
#import "PersonInfoVC.h"
#import "BodyCheckVC.h"
#import "BodyCompositionVC.h"
#import "SurveyInfoVC.h"
#import "PressAndEcg.h"
#import "GardiacAndPulmonary.h"
#import "BMDViewController.h"
#import "RoutineBloodAndBloodViewController.h"
#import "BiochemistryAndImmunityVC.h"
#import "EyeFundusExamVC.h"
@interface HomePageVC ()
@property(nonatomic,strong)XHNavigationView *navView;
@property(nonatomic,strong)UIImageView *middleImgView;
@property(nonatomic,strong)UIButton *selfCheckBtn;
@property(nonatomic,strong)UITextField *cardTextField;
@property(nonatomic,strong)UIButton *searchBtn;
@property(nonatomic,strong)UILabel *bottomLab;

@property(nonatomic,strong)NSMutableArray *btnNameArray;


@end

@implementation HomePageVC
{
    CGFloat perWidth;
    CGFloat perHeight;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBgColor];
    [self bulidHomePageNav];
    [self buildMiddleImg];
    [self buildCheckView];
    [self setBtnNameBtn];
    [self buildsearchView];
    [self calculationPerWidthOrHeight];

    [self buildNineBtn];
    [self buildBottom];
}


-(void)setBtnNameBtn
{
    self.btnNameArray = [[NSMutableArray alloc]initWithCapacity:0];
    [self.btnNameArray addObject:@"问卷信息"];
    [self.btnNameArray addObject:@"体制检查"];
    [self.btnNameArray addObject:@"身体成分"];
    [self.btnNameArray addObject:@"血压和心电"];
    [self.btnNameArray addObject:@"心肺功能"];
    [self.btnNameArray addObject:@"骨密度"];
    [self.btnNameArray addObject:@"眼科检查"];
    [self.btnNameArray addObject:@"血常规/血型"];
    [self.btnNameArray addObject:@"血生化和免疫"];
    
    
}


-(void)buildBottom
{
    self.bottomLab = [[UILabel alloc]initWithFrame:CGRectMake(0, ScreenHeight - 30, ScreenWidth-10, 30)];
    self.bottomLab.backgroundColor = [UIColor clearColor];
    self.bottomLab.text = @"备注:身份证信息不对?请致电69156476";
    self.bottomLab.textAlignment = NSTextAlignmentRight;
    self.bottomLab.font = [UIFont systemFontOfSize:13];
    
    [self.view addSubview:self.bottomLab];
}



-(void)calculationPerWidthOrHeight
{
    perWidth = (ScreenWidth - 2)/3;
    perHeight = (ScreenHeight - CGRectGetMaxY(self.middleImgView.frame) - 60-2)/3;

}


-(void)buildNineBtn
{
    for(NSInteger i = 0 ;i < 9; i++)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = NAVColor;
        btn.frame = CGRectMake(i%3*perWidth+i%3*1,CGRectGetMaxY(self.middleImgView.frame)+20+i/3*perHeight+1*(i/3), perWidth, perHeight);
        [btn setTitle:self.btnNameArray[i] forState:UIControlStateNormal];
        btn.titleLabel.adjustsFontSizeToFitWidth = YES;
        [btn addTarget:self action:@selector(infoClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 10+i;
        [self.view addSubview:btn];
    }
}


-(void)infoClick:(UIButton *)sender
{
//    PersonInfoVC *vc = [[PersonInfoVC alloc]init];
//    [self.navigationController pushViewController:vc animated:YES];
    
    
    switch (sender.tag - 10) {
        case 0:
        {
            SurveyInfoVC *infoVC = [[SurveyInfoVC alloc] init];
            [self.navigationController pushViewController:infoVC animated:YES];
        }
        break;
        case 1:
        {
            
            BodyCheckVC *check = [[BodyCheckVC alloc]init];
            [self.navigationController pushViewController:check animated:YES];
            break;
        }
        case 2:
        {
            BodyCompositionVC *composition = [[BodyCompositionVC alloc]init];
            [self.navigationController pushViewController:composition animated:YES];
            break;
        }
        case 3:
        {
            PressAndEcg *composition = [[PressAndEcg alloc]init];
            [self.navigationController pushViewController:composition animated:YES];

            break;
        }
        case 4:
        {
            GardiacAndPulmonary *composition = [[GardiacAndPulmonary alloc]init];
            [self.navigationController pushViewController:composition animated:YES];
            
            break;
        }
        case 5:
        {
            BMDViewController *composition = [[BMDViewController alloc]init];
            [self.navigationController pushViewController:composition animated:YES];
            
            break;
        }
        case 6:
        {
            EyeFundusExamVC *exam = [[EyeFundusExamVC alloc]init];
            [self.navigationController pushViewController:exam animated:YES];
            break;
        }
        case 7:
        {
            RoutineBloodAndBloodViewController *composition = [[RoutineBloodAndBloodViewController alloc]init];
            [self.navigationController pushViewController:composition animated:YES];
            
            break;
        }
        case 8:
        {
            BiochemistryAndImmunityVC *biochemistryVC = [[BiochemistryAndImmunityVC alloc]init];
            [self.navigationController pushViewController:biochemistryVC animated:YES];
            break;
        }
            
        default:
            break;
    }
}



-(void)setBgColor
{
    [self.view setBackgroundColor:COLOR(245, 245, 245, 1)];
}

-(void)buildsearchView
{
    self.cardTextField = [[UITextField alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(self.selfCheckBtn.frame)+15, ScreenWidth - 120, 40)];
    self.cardTextField.backgroundColor = [UIColor whiteColor];
    self.cardTextField.placeholder = @"  请输入身份证号码";
    self.cardTextField.keyboardType = UIKeyboardTypeNamePhonePad;
    self.cardTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.cardTextField.textColor = [UIColor lightGrayColor];
    [self.view addSubview:self.cardTextField];
    
    
    self.searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.searchBtn setFrame:CGRectMake(CGRectGetMaxX(self.cardTextField.frame)-5, CGRectGetMinY(self.cardTextField.frame),ScreenWidth-CGRectGetMaxX(self.cardTextField.frame)-20, 40)];
    self.searchBtn.backgroundColor = NAVColor;
    [self.searchBtn setTitle:@"查询" forState:UIControlStateNormal];
    [self.view addSubview:self.searchBtn];
}

-(void)buildCheckView
{
    self.selfCheckBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.selfCheckBtn.backgroundColor = [UIColor clearColor];
    [self.selfCheckBtn setFrame:CGRectMake(ScreenWidth - 140, 64, 60, 80)];
    [self.selfCheckBtn setImage:[UIImage imageNamed:@"self"] forState:UIControlStateNormal];
    [self.view addSubview:self.selfCheckBtn];
    
}

-(void)buildMiddleImg
{
    self.middleImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, 150)];
    self.middleImgView.image = [UIImage imageNamed:@"searchbg.jpg"];
    self.middleImgView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.middleImgView];
}


-(void)bulidHomePageNav
{
    self.navView = [[XHNavigationView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth,64)];
    [self.navView layoutXHNavWithType:Type_LoginNav];
    self.navView.backgroundColor = NAVColor;
    [self.navView.btn_login setImage:[UIImage imageNamed:@"head"] forState:UIControlStateNormal];
    self.navView.lbl_login.text = @"登录";
    self.navView.lbl_login_middle.text = @"协和健康管理";
    [self.navView.btn_login addTarget:self action:@selector(loginBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.navView];
}


-(void)loginBtn:(UIButton *)sender
{
    LoginVC *vc = [[LoginVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}


@end
