//
//  BiochemistryAndImmunityVC.m
//  XHHealthProject
//
//  Created by 菁优数学 on 15/6/24.
//  Copyright (c) 2015年 AlexYang. All rights reserved.
//

#import "BiochemistryAndImmunityVC.h"
#import "XHNavigationView.h"
#import "WSRequestManager.h"
#import "MBProgressHUD.h"

#import "ThirdInfoCell.h"
#import "BiochemistryAndImmunityModel.h"
@interface BiochemistryAndImmunityVC ()<UITableViewDataSource,UITableViewDelegate>{
    BOOL firstSecondFlag;
    
}

@property(nonatomic,strong)XHNavigationView *navView;
@property(nonatomic,strong)UITableView *infoTableView;
@property(nonatomic,strong)UIView *bgView;


@property (nonatomic, strong) NSMutableArray *routineBloodAndBloodDataArray;
@property (nonatomic, strong) NSMutableArray *routineBloodAndBloodOrderArray;


@property(nonatomic,strong)NSMutableArray *headMuArr;


@end

@implementation BiochemistryAndImmunityVC

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    if (self.routineBloodAndBloodDataArray == nil) {
        self.routineBloodAndBloodDataArray = [[NSMutableArray alloc] init];
    }
    
    if (self.routineBloodAndBloodOrderArray == nil) {
        self.routineBloodAndBloodOrderArray = [[NSMutableArray alloc] init];
    }
    
    if (self.headMuArr == nil) {
        self.headMuArr = [[NSMutableArray alloc] init];
    }
    
    [self loadRoutineBloodAndBloodkey];
    [self loadHeadArr];
    
    
    [self bulidHomePageNav];
    [self bulidTable];
    
    [self requestRoutineBloodAndBloodInfoData];
    // Do any additional setup after loading the view.
}

-(void)bulidTable
{
    self.infoTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64) style:UITableViewStyleGrouped];
    self.infoTableView.delegate = self;
    self.infoTableView.dataSource = self;
    self.infoTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.infoTableView];
}
-(void)bulidHomePageNav
{
    self.navView = [[XHNavigationView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth,64)];
    [self.navView layoutXHNavWithType:Type_LoginNav];
    self.navView.backgroundColor = NAVColor;
    [self.navView.btn_login setImage:[UIImage imageNamed:@"head"] forState:UIControlStateNormal];
    self.navView.lbl_login.text = @"登录";
    self.navView.lbl_login_middle.text = @"协和健康管理";
    //    [self.navView.btn_login addTarget:self action:@selector(loginBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.navView];
}

- (void)loadRoutineBloodAndBloodkey{
    [self.routineBloodAndBloodOrderArray addObject:@{@"Alt":@"丙氨酸氨基转移酶（U/L）"}];
    [self.routineBloodAndBloodOrderArray addObject:@{@"Tp":@"总蛋白（g/L）"}];
    [self.routineBloodAndBloodOrderArray addObject:@{@"Alb":@"白蛋白（g/L）"}];
    [self.routineBloodAndBloodOrderArray addObject:@{@"Ag":@"白蛋白与球蛋白的比值"}];
    
    
    [self.routineBloodAndBloodOrderArray addObject:@{@"Ggt":@"γ-谷氨酰转移酶（U/L）"}];
    
    
    [self.routineBloodAndBloodOrderArray addObject:@{@"Alp":@"碱性磷酸酶（U/L）"}];
    
    
    [self.routineBloodAndBloodOrderArray addObject:@{@"Ast":@"天门冬氨酸氨基转移酶（U/L）"}];
    [self.routineBloodAndBloodOrderArray addObject:@{@"Ca":@"钙（mmol/L）"}];
    [self.routineBloodAndBloodOrderArray addObject:@{@"Cr":@"肌酐（酶法）（μmol/L）"}];
    
    
    [self.routineBloodAndBloodOrderArray addObject:@{@"Urea":@"尿素（mmol/L）"}];
    
    [self.routineBloodAndBloodOrderArray addObject:@{@"Glu":@"血糖（mmol/L）"}];
    
    
    [self.routineBloodAndBloodOrderArray addObject:@{@"Ua":@"尿酸（μmol/L）"}];
    
    
    [self.routineBloodAndBloodOrderArray addObject:@{@"P":@"无机磷（mmol/L）"}];
    
    
    [self.routineBloodAndBloodOrderArray addObject:@{@"Tc":@"总胆固醇（mmol/L）"}];
    
    
    [self.routineBloodAndBloodOrderArray addObject:@{@"Tg":@"甘油三酯（mmol/L）"}];
    
    
    [self.routineBloodAndBloodOrderArray addObject:@{@"Hdlc":@"高密度脂蛋白胆固醇（mmol/L）"}];
    
    
    [self.routineBloodAndBloodOrderArray addObject:@{@"Ldlc":@"低密度脂蛋白胆固醇（mmol/L）"}];
    
    
    [self.routineBloodAndBloodOrderArray addObject:@{@"IgG":@"免疫球蛋白G（g/L）"}];
    
    
    [self.routineBloodAndBloodOrderArray addObject:@{@"IgA":@"免疫球蛋白A（g/L）"}];
    
    
    
    [self.routineBloodAndBloodOrderArray addObject:@{@"IgM":@"免疫球蛋白M（g/L）"}];
    
    
    
    [self.routineBloodAndBloodOrderArray addObject:@{@"Hbv":@"乙型肝炎表面抗原"}];
    
}

-(void)loadHeadArr
{
    
    [self.headMuArr addObject:@"生化与免疫数据"];
    
}

- (void)requestRoutineBloodAndBloodInfoData{
    
    
    [WSRequestManager XHGetRequestParameters:@{@"_IDNumber":CARD} withMethodName:BIOCHEMISTRYANDIMMUNITY SuccessRequest:^(id data) {
        NSArray *resultArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        
        if([resultArray count] > 0)
        {
            NSDictionary *resultDic = resultArray[0];
            
            BiochemistryAndImmunityModel *routineBloodAndBloodInfoModel = [[BiochemistryAndImmunityModel alloc] init];
            
            [routineBloodAndBloodInfoModel setValuesForKeysWithDictionary:resultDic];
            
            [self.routineBloodAndBloodDataArray addObject:routineBloodAndBloodInfoModel];
            
            
            
            
            
            //[self showErrorHUDWithStr:resultDic[@"ExMessage"]];
            
            
            
            [self.infoTableView reloadData];
        }
        
    } FailRequest:^(id data, NSError *error) {
        
    }];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (!firstSecondFlag) {
        return 0;
    }else{
        return self.routineBloodAndBloodOrderArray.count;
    }
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    
    
    NSDictionary *infoDic = [self.routineBloodAndBloodOrderArray objectAtIndex:indexPath.row];
    NSString *keyString = [[infoDic allKeys] firstObject];
    
    static NSString *identifier = @"ThirdInfoCell";
    
    ThirdInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ThirdInfoCell" owner:self options:nil] lastObject];
    }
    
    if (self.routineBloodAndBloodDataArray.count > 0) {
        
        
        BiochemistryAndImmunityModel *gardiacModel = [self.routineBloodAndBloodDataArray objectAtIndex:0];
        
        cell.thirdFierstLabel.text =[NSString stringWithFormat:@"%@",[gardiacModel valueForKeyPath:[NSString stringWithFormat:@"%@_cn",keyString]]] ;
        cell.thirdSecondLabel.text = [NSString stringWithFormat:@"%@",[gardiacModel valueForKeyPath:[NSString stringWithFormat:@"%@_value",keyString]]];
        cell.thirdThirdLabel.text = [NSString stringWithFormat:@"%@",[gardiacModel valueForKeyPath:[NSString stringWithFormat:@"%@_refinterVal",keyString]]] ;
        
    }
    else{
        cell.thirdFierstLabel.text = [NSString stringWithFormat:@"%@",[infoDic objectForKey:keyString]];
        cell.thirdSecondLabel.text = @"--";
        cell.thirdThirdLabel.text = @"--";
    }
    return cell;
    
    
    
    
    
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIButton *clickButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    clickButton.frame = CGRectMake(0, 0, ScreenWidth, 30);
    clickButton.tag = 10 + section;
    
    [clickButton setTitle:[self.headMuArr objectAtIndex:section] forState:UIControlStateNormal];
    [clickButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    clickButton.titleLabel.textAlignment = NSTextAlignmentLeft;
    //clickButton.titleEdgeInsets = UIEdgeInsetsZero;
    clickButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    clickButton.contentEdgeInsets = UIEdgeInsetsMake(0,10, 0, 0);
    
    [clickButton addTarget:self action:@selector(clickButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    return clickButton;
}


- (void)clickButtonClick:(UIButton *)bpt{
    
    if (bpt.tag == 10) {
        firstSecondFlag = !firstSecondFlag;
        
        
    }
    
    [self.infoTableView reloadData];
    //[self requestDataWithIndex:bpt.tag];
    NSLog(@"tag : %ld",bpt.tag);
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
