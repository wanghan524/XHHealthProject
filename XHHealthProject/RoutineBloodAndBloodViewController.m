//
//  RoutineBloodAndBloodViewController.m
//  XHHealthProject
//
//  Created by BlueApp on 15-6-24.
//  Copyright (c) 2015年 AlexYang. All rights reserved.
//

#import "RoutineBloodAndBloodViewController.h"

#import "XHNavigationView.h"
#import "WSRequestManager.h"
#import "MBProgressHUD.h"

#import "ThirdInfoCell.h"

#import "RoutineBloodAndBloodModel.h"

@interface RoutineBloodAndBloodViewController ()<UITableViewDataSource,UITableViewDelegate>{
    BOOL firstSecondFlag;
    
}

@property(nonatomic,strong)XHNavigationView *navView;
@property(nonatomic,strong)UITableView *infoTableView;
@property(nonatomic,strong)UIView *bgView;


@property (nonatomic, strong) NSMutableArray *routineBloodAndBloodDataArray;
@property (nonatomic, strong) NSMutableArray *routineBloodAndBloodOrderArray;


@property(nonatomic,strong)NSMutableArray *headMuArr;




@end

@implementation RoutineBloodAndBloodViewController

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
    [self.routineBloodAndBloodOrderArray addObject:@{@"Wbc":@"白细胞计数（10⁹/L）"}];
    [self.routineBloodAndBloodOrderArray addObject:@{@"Hct":@"红细胞压积(%)"}];
    [self.routineBloodAndBloodOrderArray addObject:@{@"Lymphp":@"淋巴细胞百分比(%)"}];
    [self.routineBloodAndBloodOrderArray addObject:@{@"Mcv":@"平均红细胞体积(fL)"}];
    [self.routineBloodAndBloodOrderArray addObject:@{@"Monop":@"单核细胞百分比(%)"}];
    [self.routineBloodAndBloodOrderArray addObject:@{@"Mchc":@"平均红细胞血红蛋白浓度(g/L)"}];
    [self.routineBloodAndBloodOrderArray addObject:@{@"Neutp":@"中性粒细胞百分比(%)"}];
    [self.routineBloodAndBloodOrderArray addObject:@{@"Mch":@"平均红细胞血红蛋白(pg)"}];
    [self.routineBloodAndBloodOrderArray addObject:@{@"Eop":@"嗜酸性粒细胞百分比(%)"}];
    [self.routineBloodAndBloodOrderArray addObject:@{@"Rdwsd":@"红细胞分布宽度标准差"}];
    [self.routineBloodAndBloodOrderArray addObject:@{@"Basop":@"嗜碱性粒细胞百分比(%)"}];
    [self.routineBloodAndBloodOrderArray addObject:@{@"Rdwcv":@"红细胞体积分布宽度"}];
    [self.routineBloodAndBloodOrderArray addObject:@{@"Lymph":@"淋巴细胞绝对值（10⁹/L）"}];
    [self.routineBloodAndBloodOrderArray addObject:@{@"Plt":@"血小板计数（10⁹/L）"}];
    [self.routineBloodAndBloodOrderArray addObject:@{@"Mono":@"单核细胞绝对值（10⁹/L）"}];
    [self.routineBloodAndBloodOrderArray addObject:@{@"Pct":@"血小板压积(%)"}];
    [self.routineBloodAndBloodOrderArray addObject:@{@"Neut":@"中性粒细胞绝对值（10⁹/L）"}];
    [self.routineBloodAndBloodOrderArray addObject:@{@"Pdw":@"血小板体积分布宽度(%)"}];
    [self.routineBloodAndBloodOrderArray addObject:@{@"Eo":@"嗜酸性粒细胞绝对值（10⁹/L）"}];
    [self.routineBloodAndBloodOrderArray addObject:@{@"Mpv":@"平均血小板体积(fL)"}];
    [self.routineBloodAndBloodOrderArray addObject:@{@"Baso":@"嗜碱性粒细胞绝对值（10⁹/L）"}];
    [self.routineBloodAndBloodOrderArray addObject:@{@"Xx":@"血型"}];
    [self.routineBloodAndBloodOrderArray addObject:@{@"Rbc":@"红细胞计数（10¹²/L ）"}];
    [self.routineBloodAndBloodOrderArray addObject:@{@"Rh":@"Rh血型"}];
    [self.routineBloodAndBloodOrderArray addObject:@{@"Hgb":@"血红蛋白(g/L)"}];
    
}

-(void)loadHeadArr
{
    
    [self.headMuArr addObject:@"血常规和血型"];
    
}

- (void)requestRoutineBloodAndBloodInfoData{
    
    
    [WSRequestManager XHGetRequestParameters:@{@"_IDNumber":CARD} withMethodName:ROUTINEBLOODANDBLOOD SuccessRequest:^(id data) {
        NSArray *resultArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        
        if([resultArray count] > 0)
        {
            NSDictionary *resultDic = resultArray[0];
            
            RoutineBloodAndBloodModel *routineBloodAndBloodInfoModel = [[RoutineBloodAndBloodModel alloc] init];
            
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
        
        
        RoutineBloodAndBloodModel *gardiacModel = [self.routineBloodAndBloodDataArray objectAtIndex:0];
        
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
