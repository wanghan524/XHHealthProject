//
//  PressAndEcg.m
//  XHHealthProject
//
//  Created by 菁优数学 on 15/6/22.
//  Copyright (c) 2015年 AlexYang. All rights reserved.
//

#import "PressAndEcg.h"
#import "XHNavigationView.h"
#import "ThirdInfoCell.h"
#import "WSRequestManager.h"
#import "XHHealthRequest.h"
#import "FitNessModel.h"
#import "UIImageView+WebCache.h"
#import "BloodPressureModel.h"
#import "EcgModel.h"
#import "ThirdInfoCell.h"
#import "BloodPressCell.h"
#import "EcgBottomCell.h"

#import "AppDelegate.h"
#import "HomePageVC.h"

@interface PressAndEcg ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)XHNavigationView *navView;
@property(nonatomic,strong)NSMutableArray *headMuArr;
@property(nonatomic,strong)NSMutableArray *bloodAndRateAndTempMuKeyArr;
@property(nonatomic,strong)NSMutableArray *ecgMuKeyArr;


@property (nonatomic, strong) NSMutableArray *personDataArray;
@property (nonatomic, strong) NSMutableArray *bodyDataArray;


@property(nonatomic,strong)UITableView *infoTableView;


@end

@implementation PressAndEcg
{
    BOOL firstSecondFlag;
    BOOL secondSectionFlag;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    [self bulidHomePageNav];
    [self loadHeadArr];
    [self loadBloodKey];
    
    [self loadEcgKey];
    [self bulidTable];
    [self requestBodyData];
    [self requestUserInfoData];
    
    

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



-(void)loadData
{
    if (self.personDataArray == nil) {
        self.personDataArray = [[NSMutableArray alloc] init];
    }
    
    if (self.bodyDataArray == nil) {
        self.bodyDataArray = [[NSMutableArray alloc] init];
    }

}
-(void)bulidTable
{
    self.infoTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 70, ScreenWidth, ScreenHeight - 64) style:UITableViewStyleGrouped];
    self.infoTableView.delegate = self;
    self.infoTableView.dataSource = self;
    self.infoTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.infoTableView];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 36)];
    imageView.image = [UIImage imageNamed:@"pressecg"];
    self.infoTableView.tableHeaderView = imageView;

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.headMuArr.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [self.headMuArr objectAtIndex:section];
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

- (void)requestUserInfoData{
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    NSString *numberString = [user stringForKey:@"IdNumber"];
    
    [WSRequestManager XHGetRequestParameters:@{@"_IDNumber":numberString} withMethodName:PRESSANDRACE SuccessRequest:^(id data) {
        NSArray *resultArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        
        if([resultArray count] > 0)
        {
            NSDictionary *resultDic = resultArray[0];
            
            BloodPressureModel *personInfoModel = [[BloodPressureModel alloc] init];
            
            [personInfoModel setValuesForKeysWithDictionary:resultDic];
            
            [self.personDataArray addObject:personInfoModel];
            
            
            
            
            
            //[self showErrorHUDWithStr:resultDic[@"ExMessage"]];
            
            
            
            [self.infoTableView reloadData];
        }
        
    } FailRequest:^(id data, NSError *error) {
        
    }];
    
}


- (void)requestBodyData{
    
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    NSString *numberString = [user stringForKey:@"IdNumber"];
    [WSRequestManager XHGetRequestParameters:@{@"_IDNumber":numberString} withMethodName:ECG SuccessRequest:^(id data) {
        NSArray *resultArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        
        if([resultArray count] > 0)
        {
            NSDictionary *resultDic = resultArray[0];
            
            EcgModel *personInfoModel = [[EcgModel alloc] init];
            
            [personInfoModel setValuesForKeysWithDictionary:resultDic];
            
            [self.bodyDataArray addObject:personInfoModel];
            
            
            
            
            
            //[self showErrorHUDWithStr:resultDic[@"ExMessage"]];
            
            
            
            [self.infoTableView reloadData];
        }
        
    } FailRequest:^(id data, NSError *error) {
        
    }];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        if (firstSecondFlag) {
            return self.bloodAndRateAndTempMuKeyArr.count;
        }else{
            return 0;
        }
        
    }
    
    if (section == 1) {
        
        if (secondSectionFlag) {
            return self.ecgMuKeyArr.count ;
        }else{
            return 0;
        }
        
    }
    
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    if (indexPath.section == 0)
    {

        NSDictionary *infoDic = [self.bloodAndRateAndTempMuKeyArr objectAtIndex:indexPath.row ];
            
        NSString *keyString = [[infoDic allKeys] firstObject];
        static NSString *identifier = @"ThirdInfoCell";
            
        ThirdInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"ThirdInfoCell" owner:self options:nil] lastObject];
        }
        
        
        if(indexPath.row == 0)
        {
            cell.thirdFierstLabel.text = @"检测指标";
            cell.thirdSecondLabel.text = @"检测值";
            cell.thirdThirdLabel.text = @"参考值范围";
            cell.backgroundColor = [UIColor colorWithHexString:@"EAEAEA"];
            return cell;
        }
        if([self.personDataArray count] > 0)
        {
            BloodPressureModel *personInfoModel = [self.personDataArray objectAtIndex:0];
            cell.thirdFierstLabel.text = [infoDic objectForKey:keyString];
            cell.thirdSecondLabel.text = [personInfoModel valueForKeyPath:[NSString stringWithFormat:@"%@_value",keyString]];
            cell.thirdThirdLabel.text = [personInfoModel valueForKeyPath:[NSString stringWithFormat:@"%@_refinterVal",keyString]];
            
        }else{
            cell.thirdFierstLabel.text = [infoDic objectForKey:keyString];
            cell.thirdSecondLabel.text = @"--";
            cell.thirdThirdLabel.text = @"--";
        }
        return cell;
        
        
    }
    else if (indexPath.section == 1){

        NSDictionary *infoDic = [self.ecgMuKeyArr objectAtIndex:indexPath.row];
        
        NSString *keyString = [[infoDic allKeys] firstObject];
        
        if([keyString isEqualToString:@"EcgResult"]){
            
                
            static NSString *idenStr = @"EcgBottomCell";
            EcgBottomCell *tmpCell = [tableView dequeueReusableCellWithIdentifier:idenStr];
            if(tmpCell == nil)
            {
                tmpCell = [[[NSBundle mainBundle]loadNibNamed:@"EcgBottomCell" owner:self options:nil]lastObject];
            }
            if([self.bodyDataArray count] > 0)
            {
                EcgModel *bodyCheckModel = [self.bodyDataArray objectAtIndex:0];
                tmpCell.one.text = [infoDic objectForKey:keyString];
                tmpCell.two.text = [bodyCheckModel valueForKeyPath:[NSString stringWithFormat:@"%@_value",keyString]];
                if([bodyCheckModel valueForKeyPath:@"EcgUrl"] )
                {
                    NSString *urlStr =  [bodyCheckModel valueForKeyPath:@"EcgUrl"];
                    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                    NSURL *url = [[NSURL alloc]initWithString:urlStr];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [tmpCell.threeImgView setImageWithURL:url];
                    });
                    
                    
                }
            
            }else{
                tmpCell.one.text = [infoDic objectForKey:keyString];
                tmpCell.two.text = @"--";
                tmpCell.threeImgView.image = [UIImage imageNamed:@""];
            }
            return tmpCell;
        }else{
            
            static NSString *thirdIdentifier = @"ThirdInfoCell";
            
            ThirdInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:thirdIdentifier];
            cell.backgroundColor = [UIColor whiteColor];
            if (cell == nil) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"ThirdInfoCell" owner:self options:nil] lastObject];
            }
            
            
            if(indexPath.row == 0)
            {
                cell.thirdFierstLabel.text = @"检测指标";
                cell.thirdSecondLabel.text = @"检测值";
                cell.thirdThirdLabel.text = @"参考值范围";
                cell.backgroundColor = [UIColor colorWithHexString:@"EAEAEA"];
                return cell;
                
            }
            if([self.bodyDataArray count] > 0)
            {
                EcgModel *bodyCheckModel = [self.bodyDataArray objectAtIndex:0];
                cell.thirdFierstLabel.text = [infoDic objectForKey:keyString];
                cell.thirdSecondLabel.text = [bodyCheckModel valueForKeyPath:[NSString stringWithFormat:@"%@_value",keyString]];
                cell.thirdThirdLabel.text = [bodyCheckModel valueForKeyPath:[NSString stringWithFormat:@"%@_refinterVal",keyString]];
            }else{
                cell.thirdFierstLabel.text = [infoDic objectForKey:keyString];
                cell.thirdSecondLabel.text = @"--";
                cell.thirdThirdLabel.text = @"--";
            }
            return cell;
        }
        
        
//        ThirdInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:thirdIdentifier];
//        cell.backgroundColor = [UIColor whiteColor];
//        if (cell == nil) {
//            cell = [[[NSBundle mainBundle] loadNibNamed:@"ThirdInfoCell" owner:self options:nil] lastObject];
//        }
//        
//   
//        if(indexPath.row == 0)
//        {
//            cell.thirdFierstLabel.text = @"检测指标";
//            cell.thirdSecondLabel.text = @"检测值";
//            cell.thirdThirdLabel.text = @"参考值范围";
//            cell.backgroundColor = [UIColor colorWithHexString:@"EAEAEA"];
//            return cell;
//
//        }
//        
//        if([self.bodyDataArray count] > 0)
//        {
//            EcgModel *bodyCheckModel = [self.bodyDataArray objectAtIndex:0];
//        if(![keyString isEqualToString:@""])
//        {
//            if([keyString isEqualToString:@"EcgResult"])
//            {
//                static NSString *idenStr = @"EcgBottomCell";
//                EcgBottomCell *tmpCell = [tableView dequeueReusableCellWithIdentifier:idenStr];
//                if(tmpCell == nil)
//                {
//                    tmpCell = [[[NSBundle mainBundle]loadNibNamed:@"EcgBottomCell" owner:self options:nil]lastObject];
//                }
//                tmpCell.one.text = [infoDic objectForKey:keyString];
//                tmpCell.two.text = [bodyCheckModel valueForKeyPath:[NSString stringWithFormat:@"%@_value",keyString]];
//                
//                if([bodyCheckModel valueForKeyPath:@"EcgUrl"] )
//                {
//                        NSString *urlStr =  [bodyCheckModel valueForKeyPath:@"EcgUrl"];
//                        urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//                        NSURL *url = [[NSURL alloc]initWithString:urlStr];
//                        dispatch_async(dispatch_get_main_queue(), ^{
//                            [tmpCell.threeImgView setImageWithURL:url];
//                        });
//                    
//                    
//                }
//                return tmpCell;
//
//                
//            
//
//            }
//            else
//            {
//                
//                cell.thirdFierstLabel.text = [infoDic objectForKey:keyString];
//                cell.thirdSecondLabel.text = [bodyCheckModel valueForKeyPath:[NSString stringWithFormat:@"%@_value",keyString]];
//                cell.thirdThirdLabel.text = [bodyCheckModel valueForKeyPath:[NSString stringWithFormat:@"%@_refinterVal",keyString]];
//            }
//            return cell;
//        }
//        return cell;
//        }
        
        
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section == 1)
    {
        if(indexPath.row == self.ecgMuKeyArr.count-1)
        {
            return 288;
        }
    }
            return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 56;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}




-(void)loadEcgKey
{
    self.ecgMuKeyArr = [[NSMutableArray alloc]initWithCapacity:0];
    [self.ecgMuKeyArr addObject:@{@"TitTTTT":@"检测指标"}];
    [self.ecgMuKeyArr addObject:@{@"Rate":@"平均心率(心室率)((次/分))"}];
    [self.ecgMuKeyArr addObject:@{@"Pr":@"PR间期(ms)"}];
    [self.ecgMuKeyArr addObject:@{@"Qrs":@"QRS时限(ms)"}];
    [self.ecgMuKeyArr addObject:@{@"Qt":@"QT间期(ms)"}];
    [self.ecgMuKeyArr addObject:@{@"Qtc":@"QTc(ms)"}];
    [self.ecgMuKeyArr addObject:@{@"Raxis":@"QRS波额面电轴（°）"}];
    [self.ecgMuKeyArr addObject:@{@"SokolowLyon":@"Sokolow-Lyon指数（μV）"}];
    [self.ecgMuKeyArr addObject:@{@"Cornell":@"Cornell指数（μV）"}];
    [self.ecgMuKeyArr addObject:@{@"EcgResult":@"心电诊断结果"}];
    
    
    
}

-(void)loadBloodKey
{
    self.bloodAndRateAndTempMuKeyArr = [[NSMutableArray alloc]initWithCapacity:0];
    [self.bloodAndRateAndTempMuKeyArr addObject:@{@"TitTTTT":@"检测指标"}];
    [self.bloodAndRateAndTempMuKeyArr addObject:@{@"Hsbp":@"收缩压(mmHg)"}];
    [self.bloodAndRateAndTempMuKeyArr addObject:@{@"Hdbp":@"舒张压(mmHg)"}];
    [self.bloodAndRateAndTempMuKeyArr addObject:@{@"Pulse":@"心率(次/分)"}];
    [self.bloodAndRateAndTempMuKeyArr addObject:@{@"Temp":@"体温(*C)"}];
    
}

-(void)loadHeadArr
{
    self.headMuArr = [[NSMutableArray alloc]initWithCapacity:0];
    [self.headMuArr addObject:@"血压、心率、体温数据"];
    [self.headMuArr addObject:@"心电图数据"];
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
    self.navView.lbl_login_middle.text = @"血压和心电";
    
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}


@end
