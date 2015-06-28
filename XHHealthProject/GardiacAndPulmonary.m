//
//  GardiacAndPulmonary.m
//  XHHealthProject
//
//  Created by BlueApp on 15-6-24.
//  Copyright (c) 2015年 AlexYang. All rights reserved.
//

#import "GardiacAndPulmonary.h"

#import "XHNavigationView.h"
#import "WSRequestManager.h"
#import "MBProgressHUD.h"

#import "GardiacModel.h"
#import "PulmonaryInfoCell.h"
#import "pulmonaryModel.h"

#import "ThirdInfoCell.h"

@interface GardiacAndPulmonary ()<UITableViewDataSource,UITableViewDelegate>{
    BOOL firstSecondFlag;
    BOOL secondSectionFlag;
}


@property(nonatomic,strong)XHNavigationView *navView;
@property(nonatomic,strong)UITableView *infoTableView;
@property(nonatomic,strong)UIView *bgView;


@property (nonatomic, strong) NSMutableArray *gardiacDataArray;
@property (nonatomic, strong) NSMutableArray *pulmonaryDataArray;

@property (nonatomic, strong) NSMutableArray *gardiacOrderArray;
@property (nonatomic, strong) NSMutableArray *pulmonaryOrderArray;

@property(nonatomic,strong)NSMutableArray *headMuArr;

@end

@implementation GardiacAndPulmonary

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.gardiacDataArray == nil) {
        self.gardiacDataArray = [[NSMutableArray alloc] init];
    }
    
    if (self.gardiacOrderArray == nil) {
        self.gardiacOrderArray = [[NSMutableArray alloc] init];
    }
    
    if (self.pulmonaryDataArray == nil) {
        self.pulmonaryDataArray = [[NSMutableArray alloc] init];
    }
    
    if (self.pulmonaryOrderArray == nil) {
        self.pulmonaryOrderArray = [[NSMutableArray alloc] init];
    }
    
    
    if (self.headMuArr == nil) {
        self.headMuArr = [[NSMutableArray alloc] init];
    }
    
    [self loadHeadArr];
    [self loadGardiacKey];
    [self loadPulmonaryKey];
    
    [self bulidHomePageNav];
    [self bulidTable];
    
    [self requestGardiacData];
    [self requestPulmonaryInfoData];
    // Do any additional setup after loading the view.
}

-(void)loadPulmonaryKey
{
    
    [self.pulmonaryOrderArray addObject:@{@"Vt":@"潮气量(L)"}];
    [self.pulmonaryOrderArray addObject:@{@"Bf":@"呼吸频率(次/分)"}];
    [self.pulmonaryOrderArray addObject:@{@"Mv":@"每分钟通气量(L/min)"}];
    [self.pulmonaryOrderArray addObject:@{@"Erv":@"补呼气量(L)"}];
    [self.pulmonaryOrderArray addObject:@{@"Ic":@"深吸气量(L)"}];
    [self.pulmonaryOrderArray addObject:@{@"Vc":@"肺活量（L）"}];
    [self.pulmonaryOrderArray addObject:@{@"Fvc":@"用力肺活量（L）"}];
    [self.pulmonaryOrderArray addObject:@{@"Fev1":@"一秒钟用力呼气容积（L）"}];
    [self.pulmonaryOrderArray addObject:@{@"Fev1Fvc":@"一秒用力呼气量占用力肺活量的比值（%）"}];
    [self.pulmonaryOrderArray addObject:@{@"Pef":@"最高呼气流速（L/s）"}];
    [self.pulmonaryOrderArray addObject:@{@"Fef25":@"用力呼出25%肺活量时的呼气流速（L/s）"}];
    [self.pulmonaryOrderArray addObject:@{@"Fef50":@"用力呼出50%肺活量时的呼气流速（L/s）"}];
    [self.pulmonaryOrderArray addObject:@{@"Fef75":@"用力呼出75%肺活量时的呼气流速（L/s）"}];
    [self.pulmonaryOrderArray addObject:@{@"Mmef":@"最大呼气中段流速（L/s）"}];
    [self.pulmonaryOrderArray addObject:@{@"Mvv":@"最大通气量（L）"}];
    
}

-(void)loadGardiacKey
{
    
    [self.gardiacOrderArray addObject:@{@"Ef":@"左室射血分数(%)"}];
    [self.gardiacOrderArray addObject:@{@"LvidD":@"左室舒张末期内径(cm)"}];
    
    
}


-(void)loadHeadArr
{
    
    [self.headMuArr addObject:@"心功能"];
    [self.headMuArr addObject:@"肺功能"];
}
-(void)bulidTable
{
    self.infoTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64) style:UITableViewStyleGrouped];
    self.infoTableView.delegate = self;
    self.infoTableView.dataSource = self;
    self.infoTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.infoTableView];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 36)];
    imageView.image = [UIImage imageNamed:@"headfunction"];
    self.infoTableView.tableHeaderView = imageView;

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


- (void)requestPulmonaryInfoData{
    
    
    [WSRequestManager XHGetRequestParameters:@{@"_IDNumber":CARD} withMethodName:PULMONARY SuccessRequest:^(id data) {
        NSArray *resultArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        
        if([resultArray count] > 0)
        {
            NSDictionary *resultDic = resultArray[0];
            
            pulmonaryModel *pulmonaryInfoModel = [[pulmonaryModel alloc] init];
            
            [pulmonaryInfoModel setValuesForKeysWithDictionary:resultDic];
            
            [self.pulmonaryDataArray addObject:pulmonaryInfoModel];
            
            
            
            
            
            //[self showErrorHUDWithStr:resultDic[@"ExMessage"]];
            
            
            
            [self.infoTableView reloadData];
        }
        
    } FailRequest:^(id data, NSError *error) {
        
    }];
    
}


- (void)requestGardiacData{
    [WSRequestManager XHGetRequestParameters:@{@"_IDNumber":CARD} withMethodName:GARDIAC SuccessRequest:^(id data) {
        NSArray *resultArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        
        if([resultArray count] > 0)
        {
            NSDictionary *resultDic = resultArray[0];
            
            GardiacModel *gardiacInfoModel = [[GardiacModel alloc] init];
            
            [gardiacInfoModel setValuesForKeysWithDictionary:resultDic];
            
            [self.gardiacDataArray addObject:gardiacInfoModel];
            
            
            
            
            
            //[self showErrorHUDWithStr:resultDic[@"ExMessage"]];
            
            
            
            [self.infoTableView reloadData];
        }
        
    } FailRequest:^(id data, NSError *error) {
        
    }];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.headMuArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    if (section == 0) {
        
        if (!firstSecondFlag) {
            return 0;
        }else{
            return self.gardiacOrderArray.count;
        }
        
        
    }
    else{
        if (!secondSectionFlag) {
            return 0;
        }
        else{
            return self.pulmonaryOrderArray.count;
        }
        
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        static NSString *identifier = @"ThirdInfoCell";
        
        NSDictionary *infoDic = [self.gardiacOrderArray objectAtIndex:indexPath.row];
        NSString *keyString = [[infoDic allKeys] firstObject];
        
        ThirdInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"ThirdInfoCell" owner:self options:nil] lastObject];
        }
        
        if (self.gardiacDataArray.count > 0) {
            GardiacModel *gardiacModel = [self.gardiacDataArray objectAtIndex:0];
            
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
    else{
        
        static NSString *identifier = @"pulmonaryInfoCell";
        
        NSDictionary *infoDic = [self.pulmonaryOrderArray objectAtIndex:indexPath.row];
        NSString *keyString = [[infoDic allKeys] firstObject];
        
        PulmonaryInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"PulmonaryInfoCell" owner:self options:nil] lastObject];
        }
        if (self.pulmonaryDataArray.count > 0) {
            pulmonaryModel *pulmonaryInfoModal = [self.pulmonaryDataArray objectAtIndex:0];
            cell.left_middleLabel.text = [NSString stringWithFormat:@"%@",[pulmonaryInfoModal valueForKeyPath:[NSString stringWithFormat:@"%@_cn",keyString]]];
            cell.middle_leftLabel.text = [NSString stringWithFormat:@"%@",[pulmonaryInfoModal valueForKeyPath:[NSString stringWithFormat:@"%@_value",keyString]]];
            cell.middle_rightLabel.text = [NSString stringWithFormat:@"%@",[pulmonaryInfoModal valueForKeyPath:[NSString stringWithFormat:@"%@_refinterVal",keyString]]];
            cell.right_middleLabel.text = [NSString stringWithFormat:@"%@",[pulmonaryInfoModal valueForKeyPath:[NSString stringWithFormat:@"%@_perc",keyString]]];
                                           
        }
        
        else{
            cell.left_middleLabel.text = [NSString stringWithFormat:@"%@",[infoDic objectForKey:keyString]];
            cell.middle_leftLabel.text = @"--";
            cell.middle_rightLabel.text = @"--";
            cell.right_middleLabel.text = @"--";
        }
        return cell;
    }
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

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
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
                img = [UIImage imageNamed:@"top"];
            }
            else
            {
                img = [UIImage imageNamed:@"bottom"];
            }
            break;
        }
        case 1:
        {
            if(secondSectionFlag)
            {
                img = [UIImage imageNamed:@"top"];
            }
            else
            {
                img = [UIImage imageNamed:@"bottom"];
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
    else if (bpt.tag == 11){
        secondSectionFlag = !secondSectionFlag;
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
