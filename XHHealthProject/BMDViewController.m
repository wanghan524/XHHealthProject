//
//  BMDViewController.m
//  XHHealthProject
//
//  Created by BlueApp on 15-6-24.
//  Copyright (c) 2015年 AlexYang. All rights reserved.
//

#import "BMDViewController.h"

#import "XHNavigationView.h"
#import "WSRequestManager.h"
#import "MBProgressHUD.h"

#import "BMDModel.h"
#import "ThirdInfoCell.h"

#import "FirstCell.h"

#import "AppDelegate.h"
#import "HomePageVC.h"

@interface BMDViewController ()<UITableViewDataSource,UITableViewDelegate>{
    BOOL firstSecondFlag;
    
}


@property(nonatomic,strong)XHNavigationView *navView;
@property(nonatomic,strong)UITableView *infoTableView;
@property(nonatomic,strong)UIView *bgView;


@property (nonatomic, strong) NSMutableArray *bmdDataArray;
@property (nonatomic, strong) NSMutableArray *bmdOrderArray;


@property(nonatomic,strong)NSMutableArray *headMuArr;

@end

@implementation BMDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.bmdOrderArray == nil) {
        self.bmdOrderArray = [[NSMutableArray alloc] init];
    }
    
    if (self.bmdDataArray == nil) {
        self.bmdDataArray = [[NSMutableArray alloc] init];
    }
    
    if (self.headMuArr == nil) {
        self.headMuArr = [[NSMutableArray alloc] init];
    }
    
    [self loadBMDkey];
    [self loadHeadArr];
    
    
    [self bulidHomePageNav];
    [self bulidTable];
    
    [self requestBMDInfoData];
    
    // Do any additional setup after loading the view.
}

-(void)bulidTable
{
    self.infoTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 70, ScreenWidth, ScreenHeight - 70) style:UITableViewStyleGrouped];
    self.infoTableView.delegate = self;
    self.infoTableView.dataSource = self;
    self.infoTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.infoTableView];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 36)];
    imageView.image = [UIImage imageNamed:@"bond"];
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
    self.navView.lbl_login_middle.text = @"骨密度";
    
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

- (void)loadBMDkey{
    [self.bmdOrderArray addObject:@{@"TTTTTTT":@"检测指标"}];
    [self.bmdOrderArray addObject:@{@"T":@"T值"}];
    [self.bmdOrderArray addObject:@{@"Z":@"Z值"}];
    [self.bmdOrderArray addObject:@{@"Bua":@"宽带超声振幅衰减（db/MHz）"}];
    [self.bmdOrderArray addObject:@{@"Sos":@"声速（m/s）"}];
    [self.bmdOrderArray addObject:@{@"Ht":@"足跟厚度（mm）"}];
    [self.bmdOrderArray addObject:@{@"Diagnosis":@"骨密度诊断结果"}];
    
}

-(void)loadHeadArr
{
    firstSecondFlag = YES;
    
    [self.headMuArr addObject:@"骨密度"];
    
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

- (void)requestBMDInfoData{
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    NSString *numberString = [user stringForKey:@"IdNumber"];
    
    [WSRequestManager XHGetRequestParameters:@{@"_IDNumber":numberString} withMethodName:BMD SuccessRequest:^(id data) {
        NSArray *resultArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        
        if([resultArray count] > 0)
        {
            NSDictionary *resultDic = resultArray[0];
            
            BMDModel *bmdInfoModel = [[BMDModel alloc] init];
            
            [bmdInfoModel setValuesForKeysWithDictionary:resultDic];
            
            [self.bmdDataArray addObject:bmdInfoModel];
            
            
            
            
            
            //[self showErrorHUDWithStr:resultDic[@"ExMessage"]];
            
            
            
            [self.infoTableView reloadData];
        }
        
    } FailRequest:^(id data, NSError *error) {
        
    }];
    
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


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
        return self.bmdOrderArray.count;
    
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
        
    
        
    NSDictionary *infoDic = [self.bmdOrderArray objectAtIndex:indexPath.row];
    NSString *keyString = [[infoDic allKeys] firstObject];
    
    if ([keyString isEqualToString:@"Diagnosis"]) {
        
        static NSString *identifier = @"BoodCell";
        
        BoodCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"BoodCell" owner:self options:nil] lastObject];
        }
        
        if (self.bmdDataArray.count > 0) {
            
            
            BMDModel *bmdModel = [self.bmdDataArray objectAtIndex:0];
            
            cell.one.text = [NSString stringWithFormat:@"%@",[bmdModel valueForKeyPath:[NSString stringWithFormat:@"%@_cn",keyString]]] ;
            cell.two.text = [NSString stringWithFormat:@"%@",[bmdModel valueForKeyPath:[NSString stringWithFormat:@"%@_value",keyString]]];
            
        }else{
            cell.one.text = [NSString stringWithFormat:@"%@",[infoDic objectForKey:keyString]];
            cell.two.text = @"--";
        }
        
        return cell;
        
    }else{
        static NSString *identifier = @"ThirdInfoCell";
        
        ThirdInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"ThirdInfoCell" owner:self options:nil] lastObject];
        }
        cell.backgroundColor = [UIColor whiteColor];
        
        if (self.bmdDataArray.count > 0) {
            
            if(indexPath.row == 0)
            {
                cell.thirdFierstLabel.text = @"检测指标";
                cell.thirdSecondLabel.text = @"检测值";
                cell.thirdThirdLabel.text = @"参考值范围";
                cell.backgroundColor = [UIColor colorWithHexString:@"EAEAEA"];
                return cell;
                
            }
            
            BMDModel *gardiacModel = [self.bmdDataArray objectAtIndex:0];
            
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
