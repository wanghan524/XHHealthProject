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

#import "AppDelegate.h"
#import "HomePageVC.h"
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
   
    firstSecondFlag = YES;
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
- (void)viewWillAppear:(BOOL)animated{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    if ([user valueForKey:@"UserName"] != nil) {
        self.navView.lbl_login.text = [user valueForKey:@"UserName"];
        
        NSURL *docsUrl = [[[NSFileManager defaultManager]URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask]lastObject];
        NSString *resultStr = [[docsUrl path]stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",@"headImage"]];
        UIImage *imgs = [UIImage imageWithContentsOfFile:resultStr];
        if (imgs != nil) {
            [self.navView.btn_login setImage:imgs forState:UIControlStateNormal];
        }else{
            [self.navView.btn_login setImage:[UIImage imageNamed:@"head"] forState:UIControlStateNormal];
        }
        
        self.navView.btn_login.layer.cornerRadius = 15.f;
        self.navView.btn_login.layer.masksToBounds  = YES;
        
        
    }else{
        self.navView.lbl_login.text = @"登录";
    }
}

-(void)bulidTable
{
    self.infoTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 70, ScreenWidth, ScreenHeight - 70) style:UITableViewStyleGrouped];
    self.infoTableView.delegate = self;
    self.infoTableView.dataSource = self;
    self.infoTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.infoTableView];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 36)];
    imageView.image = [UIImage imageNamed:@"shenghua"];
    self.infoTableView.tableHeaderView = imageView;

}
-(void)bulidHomePageNav
{
    self.navView = [[XHNavigationView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth,64)];
    [self.navView layoutXHNavWithType:Type_RightBtn];
    self.navView.backgroundColor = NAVColor;
    [self.navView.btn_login setImage:[UIImage imageNamed:@"head"] forState:UIControlStateNormal];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    if ([user valueForKey:@"UserName"] != nil) {
        self.navView.lbl_login.text = [user valueForKey:@"UserName"];
    }else{
        self.navView.lbl_login.text = @"登录";
    }
    self.navView.lbl_login_middle.text = @"血生化和免疫";
    
    
    [self.navView.rightBtn setTitle:@"返回" forState:UIControlStateNormal];
    [self.navView.rightBtn addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
    //    [self.navView.btn_login addTarget:self action:@selector(loginBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.navView];
}

- (void)backButtonClick{
    if ([self.flagString isEqualToString:@"now"]) {
        HomePageVC *homeVC = [[HomePageVC alloc]init];
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:homeVC];
        
        AppDelegate *delegate = [UIApplication sharedApplication].delegate;
        [delegate.draw closeDrawerAnimated:YES completion:nil];
        delegate.draw.centerViewController = nav;
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)loadRoutineBloodAndBloodkey{
    
    [self.routineBloodAndBloodOrderArray addObject:@{@"TTTTTT":@"*****"}];
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
    
    [self.headMuArr addObject:@"生化与免疫"];
    
}

- (void)requestRoutineBloodAndBloodInfoData{
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    NSString *numberString = [user stringForKey:@"IdNumber"];
    [WSRequestManager XHGetRequestParameters:@{@"_IDNumber":numberString} withMethodName:BIOCHEMISTRYANDIMMUNITY SuccessRequest:^(id data) {
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
    
    
    return self.routineBloodAndBloodOrderArray.count;
    
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    
    
    NSDictionary *infoDic = [self.routineBloodAndBloodOrderArray objectAtIndex:indexPath.row];
    NSString *keyString = [[infoDic allKeys] firstObject];
    
    static NSString *identifier = @"ThirdInfoCell";
    
    ThirdInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ThirdInfoCell" owner:self options:nil] lastObject];
    }
    cell.backgroundColor = [UIColor whiteColor];
    
    if (self.routineBloodAndBloodDataArray.count > 0) {
        
        
        if(indexPath.row == 0)
        {
            cell.thirdFierstLabel.text = @"检测指标";
            cell.thirdSecondLabel.text = @"检测值";
            cell.thirdThirdLabel.text = @"参考值范围";
            cell.backgroundColor = [UIColor colorWithHexString:@"EAEAEA"];
            return cell;
            
        }

        
        
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
    return 56;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    UIView *headViewT = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 56)];
    headViewT.backgroundColor = [UIColor whiteColor];



    UIImageView *pointImgView  = [[UIImageView alloc]initWithFrame:CGRectMake(10, (56-18)/2, 18, 18)];
    pointImgView.image = [UIImage imageNamed:@"point"];
    [headViewT addSubview:pointImgView];

    UILabel *nameLab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(pointImgView.frame)+5, (56-18)/2, 180, 18)];
    nameLab.text = [self.headMuArr objectAtIndex:section];
    nameLab.backgroundColor = [UIColor clearColor];
    nameLab.textAlignment = NSTextAlignmentLeft;
    [headViewT addSubview:nameLab];

    UIImageView *line = [[UIImageView alloc]initWithFrame:CGRectMake(0, 46, ScreenWidth, 10)];
    line.image = [UIImage imageNamed:@"line.gif"];
    [headViewT addSubview:line];

    UIImageView *indicatorImgView = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth - 16 - 20, (56-36)/2, 16, 36)];


    indicatorImgView.image = [self selectedWithSection:section];
    indicatorImgView.tag = 100 + section;
    [headViewT addSubview:indicatorImgView];


    UIButton *clickButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    clickButton.frame = CGRectMake(0, 0, ScreenWidth, 36);
    clickButton.tag = 10 + section;
    clickButton.backgroundColor = [UIColor clearColor];

    [clickButton addTarget:self action:@selector(clickButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [headViewT addSubview:clickButton];

    return headViewT;
}
-(UIImage*)selectedWithSection:(NSUInteger)section
{
    UIImage *img = nil;
    switch (section) {
        case 0:
        {
            if(firstSecondFlag)
            {
                //img = [UIImage imageNamed:@"top"];
            }
            else
            {
                //img = [UIImage imageNamed:@"bottom"];
            }
            break;
        }
        default:
            break;
    }
    return img;
}


- (void)clickButtonClick:(UIButton *)bpt{
    
    if (bpt.tag == 10) {
        firstSecondFlag = !firstSecondFlag;
        
        
    }
    
    [self.infoTableView reloadData];
    //[self requestDataWithIndex:bpt.tag];
    
    
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
