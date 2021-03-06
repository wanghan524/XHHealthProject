//
//  EyeFundusExamVC.m
//  XHHealthProject
//
//  Created by 菁优数学 on 15/6/24.
//  Copyright (c) 2015年 AlexYang. All rights reserved.
//

#import "EyeFundusExamVC.h"
#import "XHNavigationView.h"
#import "BloodPressCell.h"
#import "WSRequestManager.h"
#import "XHHealthRequest.h"
#import "FitNessModel.h"
#import "UIImageView+WebCache.h"
#import "BloodPressureModel.h"
#import "EcgModel.h"
#import "ThirdInfoCell.h"
#import "BloodPressCell.h"
#import "EyeGenerCheckCell.h"
#import "EyeGeneralExamModel.h"
#import "EyeOphthalmologyExamModel.h"
#import "EyeFundusExamModel.h"
#import "EyeFundusExam.h"

#import "AppDelegate.h"
#import "HomePageVC.h"


@interface EyeFundusExamVC ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)XHNavigationView *navView;
@property(nonatomic,strong)NSMutableArray *headMuArr;
@property(nonatomic,strong)NSMutableArray *eyeGenerlMuKeyArr;
@property(nonatomic,strong)NSMutableArray *eyeQuGuangMuKeyArr;
@property(nonatomic,strong)NSMutableArray *eyeEyeBottomMuKeyArr;


@property (nonatomic, strong) NSMutableArray *generlDataArray;
@property (nonatomic, strong) NSMutableArray *quGuangDataArray;
@property(nonatomic,strong)NSMutableArray *bottomDataArray;


@property(nonatomic,strong)UITableView *infoTableView;

@end

@implementation EyeFundusExamVC

{
    BOOL firstSecondFlag;
    BOOL secondSectionFlag;
    BOOL thirdSectionFlag;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    [self bulidHomePageNav];
    [self loadHeadArr];
    [self loadBloodKey];
    [self loadBottomKey];
    
    [self loadEcgKey];
    [self bulidTable];
    [self requestBodyData];
    [self requestUserInfoData];
    [self requestLastData];
    
    
    
}

-(void)loadBottomKey
{
    self.eyeEyeBottomMuKeyArr = [[NSMutableArray alloc]initWithCapacity:0];
    [self.eyeEyeBottomMuKeyArr addObject:@{@"F_cn":@"图片"}];
    
}
-(void)loadData
{
    if (self.generlDataArray == nil) {
        self.generlDataArray = [[NSMutableArray alloc] initWithCapacity:0];
    }
    
    if (self.quGuangDataArray == nil) {
        self.quGuangDataArray = [[NSMutableArray alloc] initWithCapacity:0];
    }
    if(self.bottomDataArray == nil)
    {
        self.bottomDataArray = [[NSMutableArray alloc]initWithCapacity:0];
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
    imageView.image = [UIImage imageNamed:@"eye"];
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
        case 2:
        {
            if(thirdSectionFlag)
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
    else if(bpt.tag == 12)
    {
        thirdSectionFlag = !thirdSectionFlag;
    }
    
    [self.infoTableView reloadData];
    //[self requestDataWithIndex:bpt.tag];
    NSLog(@"tag : %ld",bpt.tag);
    
}

- (void)requestUserInfoData{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    NSString *numberString = [user stringForKey:@"IdNumber"];
    
    [WSRequestManager XHGetRequestParameters:@{@"_IDNumber":numberString} withMethodName:EYEGENERALEXAM SuccessRequest:^(id data) {
        NSArray *resultArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        
        if([resultArray count] > 0)
        {
            NSDictionary *resultDic = resultArray[0];
            
            EyeGeneralExamModel *personInfoModel = [[EyeGeneralExamModel alloc] init];
            
            [personInfoModel setValuesForKeysWithDictionary:resultDic];
            
            [self.generlDataArray addObject:personInfoModel];
            
            
            
            
            
            //[self showErrorHUDWithStr:resultDic[@"ExMessage"]];
            
            
            
            [self.infoTableView reloadData];
        }
        
    } FailRequest:^(id data, NSError *error) {
        
    }];
    
}


- (void)requestBodyData{
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    NSString *numberString = [user stringForKey:@"IdNumber"];
    
    [WSRequestManager XHGetRequestParameters:@{@"_IDNumber":numberString} withMethodName:EYEOPHTHALMOLOGYEXAM SuccessRequest:^(id data) {
        NSArray *resultArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        
        if([resultArray count] > 0)
        {
            NSDictionary *resultDic = resultArray[0];
            
            EyeOphthalmologyExamModel *personInfoModel = [[EyeOphthalmologyExamModel alloc] init];
            
            [personInfoModel setValuesForKeysWithDictionary:resultDic];
            
            [self.quGuangDataArray addObject:personInfoModel];
            
            
            
            
            
            //[self showErrorHUDWithStr:resultDic[@"ExMessage"]];
            
            
            
            [self.infoTableView reloadData];
        }
        
    } FailRequest:^(id data, NSError *error) {
        
    }];
    
}


- (void)requestLastData{
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    NSString *numberString = [user stringForKey:@"IdNumber"];
    
    [WSRequestManager XHGetRequestParameters:@{@"_IDNumber":numberString} withMethodName:EYEFUNDUSEXAM SuccessRequest:^(id data) {
        NSArray *resultArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        
        if([resultArray count] > 0)
        {
            NSDictionary *resultDic = resultArray[0];
            
            EyeFundusExamModel *personInfoModel = [[EyeFundusExamModel alloc] init];
            
            [personInfoModel setValuesForKeysWithDictionary:resultDic];
            
            [self.bottomDataArray addObject:personInfoModel];
            
            
            
            
            
            //[self showErrorHUDWithStr:resultDic[@"ExMessage"]];
            
            
            
            [self.infoTableView reloadData];
        }
        
    } FailRequest:^(id data, NSError *error) {
        
    }];
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        if([self.generlDataArray count] > 0)
        {
            if (firstSecondFlag)
            {
                return self.eyeGenerlMuKeyArr.count;
            }else{
                return 0;
            }
        }
        
    }
    
    if (section == 1) {
        if([self.quGuangDataArray count] > 0)
        {
            if (secondSectionFlag) {
                return self.eyeQuGuangMuKeyArr.count;
            }else{
                return 0;
            }
        }
    }
    if(section == 2)
    {
        if([self.bottomDataArray count] > 0)
        {
            if(thirdSectionFlag)
            {
                return self.eyeEyeBottomMuKeyArr.count;
            }else
            {
                return 0;
            }
        }
    }
    
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"BloodPressCell";
    
    
    if (indexPath.section == 0)
    {
        if([self.generlDataArray count] > 0)
        {
        
            EyeGeneralExamModel *personInfoModel = [self.generlDataArray objectAtIndex:0];
            NSDictionary *infoDic = [self.eyeGenerlMuKeyArr objectAtIndex:indexPath.row];
            
            NSString *keyString = [[infoDic allKeys] firstObject];
            
            BloodPressCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            cell.backgroundColor = [UIColor whiteColor];
            if (cell == nil) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"BloodPressCell" owner:self options:nil] lastObject];
            }
            
            if(indexPath.row == 0)
            {
                cell.one.text = @"检测指标";
                cell.two.text = @"右眼";
                cell.three.text= @"左眼";
                cell.backgroundColor = [UIColor colorWithHexString:@"#EAEAEA"];
                return cell;
            }
            
            
            if(![keyString isEqualToString:@""])
            {
                cell.one.text = [personInfoModel valueForKeyPath:keyString];
                if([keyString isEqualToString:@"Vision_cn"])
                {
                    
                    cell.two.text = personInfoModel.Od_value;
                    cell.three.text = personInfoModel.Os_value;
                    return cell;
                }
                if([keyString isEqualToString:@"PeryGium_cn"])
                {
                    cell.two.text = personInfoModel.RpteryGium_value;
                    cell.three.text = personInfoModel.LpteryGium_value;
                    return cell;
                }
                if([keyString isEqualToString:@"Nasal_cn"])
                {
                    cell.two.text = personInfoModel.Rnasal_value;
                    cell.three.text = personInfoModel.Lnasal_value;
                    return cell;
                }
                if([keyString isEqualToString:@"Nasalact_cn"])
                {
                    cell.two.text = personInfoModel.Rnasalact_value;
                    cell.three.text = personInfoModel.Lnasalact_value;
                    return cell;
                }
                if([keyString isEqualToString:@"Temporal_cn"])
                {
                    cell.two.text = personInfoModel.Rtemporal_value;
                    cell.three.text = personInfoModel.Ltemporal_value;
                    return cell;
                }
                if([keyString isEqualToString:@"Temporalact_cn"])
                {
                    cell.two.text = personInfoModel.Rtemporalact_value;
                    cell.three.text = personInfoModel.Ltemporalact_value;
                    return cell;
                }
                
            }
            
        }
        
        
    }
    else if (indexPath.section == 1)
    {
        
        if([self.quGuangDataArray count] > 0)
        {
            EyeOphthalmologyExamModel *bodyCheckModel = [self.quGuangDataArray objectAtIndex:0];
            
            static NSString *thirdIdentifier = @"BloodPressCell";
            
            NSDictionary *infoDic = [self.eyeQuGuangMuKeyArr objectAtIndex:indexPath.row];
            
            NSString *keyString = [[infoDic allKeys] firstObject];
            
            BloodPressCell *cell = [tableView dequeueReusableCellWithIdentifier:thirdIdentifier];
            if (cell == nil) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"BloodPressCell" owner:self options:nil] lastObject];
            }

            cell.backgroundColor = [UIColor whiteColor];
            if(indexPath.row == 0)
            {
                cell.one.text = @"检测指标";
                cell.two.text = @"右眼";
                cell.three.text= @"左眼";
                cell.backgroundColor = [UIColor colorWithHexString:@"#EAEAEA"];
                return cell;
            }

            
            if(![keyString isEqualToString:@""])
            {
                 cell.one.text = [bodyCheckModel valueForKeyPath:keyString];
                if([keyString isEqualToString:@"S_cn"])
                {
                    cell.two.text = bodyCheckModel.Ls_value;
                    cell.three.text = bodyCheckModel.Rs_value;
                    return cell;
                }
                if([keyString isEqualToString:@"C_cn"])
                {
                    cell.two.text = bodyCheckModel.Lc_value;
                    cell.three.text = bodyCheckModel.Rc_value;
                    return cell;
                }
                if([keyString isEqualToString:@"A_cn"])
                {
                    cell.two.text = bodyCheckModel.La_value;
                    cell.three.text= bodyCheckModel.Ra_value;
                    return cell;
                }
                if([keyString isEqualToString:@"R1mm_cn"])
                {
                    cell.two.text = bodyCheckModel.Lr1mm_value;
                    cell.three.text = bodyCheckModel.Rr1mm_value;
                    return cell;
                }
                if([keyString isEqualToString:@"R1d_cn"])
                {
                    cell.two.text = bodyCheckModel.Lr1d_value;
                    cell.three.text = bodyCheckModel.Rr1d_value;
                    return cell;
                }
                if([keyString isEqualToString:@"R1deg_cn"])
                {
                    cell.two.text = bodyCheckModel.Lr1deg_value;
                    cell.three.text = bodyCheckModel.Rr1deg_value;
                    return cell;
                }
                if([keyString isEqualToString:@"R2mm_cn"])
                {
                    cell.two.text = bodyCheckModel.Lr2mm_value;
                    cell.three.text = bodyCheckModel.Rr2mm_value;
                    return cell;
                }
                if([keyString isEqualToString:@"R2d_cn"])
                {
                    cell.two.text = bodyCheckModel.Lr2d_value;
                    cell.three.text = bodyCheckModel.Rr2d_value;
                    return cell;
                }
                if([keyString isEqualToString:@"R2deg_cn"])
                {
                    cell.two.text = bodyCheckModel.Lr2deg_value;
                    cell.three.text = bodyCheckModel.Rr2deg_value;
                    return cell;
                }
                if([keyString isEqualToString:@"Cyld_cn"])
                {
                    cell.three.text = bodyCheckModel.Rcyld_value;
                    cell.two.text = bodyCheckModel.Lcyld_value;
                    return cell;
                }
                
                if([keyString isEqualToString:@"Cyldeg_cn"])
                {
                    cell.two.text = bodyCheckModel.Lcyldeg_value;
                    cell.three.text = bodyCheckModel.RcyLdeg_value;
                    return cell;
                }
                if([keyString isEqualToString:@"Se_cn"])
                {
                    cell.two.text = bodyCheckModel.Lse_value;
                    cell.three.text = bodyCheckModel.Rse_value;
                    return cell;
                }
                
                
                if([keyString isEqualToString:@"Dia_cn"])
                {
                    cell.two.text = bodyCheckModel.Ldia_value;
                    cell.three.text = bodyCheckModel.Rdia_value;
                    return cell;
                }
                
                if([keyString isEqualToString:@"Ani_cn"])
                {
                    cell.two.text = bodyCheckModel.Lani_value;
                    cell.three.text = bodyCheckModel.Rani_value;
                    return cell;
                    
                }
                if([keyString isEqualToString:@"Qgdia_cn"])
                {
                 
                    static NSString *thirdIdentifier = @"EyeGenerCheckCell";
                    
                    
                    EyeGenerCheckCell *cell = [tableView dequeueReusableCellWithIdentifier:thirdIdentifier];
                    if (cell == nil) {
                        cell = [[[NSBundle mainBundle] loadNibNamed:@"EyeGenerCheckCell" owner:self options:nil] lastObject];
                    }
                    cell.one.text = @"屈光参差情况";
                    cell.two.text = bodyCheckModel.Qgdia_value;
                    return cell;

                }

            }
                
        }
    
    }
    else if(indexPath.section == 2)
    {
        if([self.bottomDataArray count] > 0)
        {
            EyeFundusExamModel *personInfoModel = [self.bottomDataArray objectAtIndex:0];
            NSDictionary *infoDic = [self.eyeEyeBottomMuKeyArr objectAtIndex:indexPath.row];
            
            NSString *keyString = [[infoDic allKeys] firstObject];
            static NSString *idenTmp = @"EyeFundusExam";
            
            EyeFundusExam *cell = [tableView dequeueReusableCellWithIdentifier:idenTmp];
            if (cell == nil) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"EyeFundusExam" owner:self options:nil] lastObject];
            }
            if(![keyString isEqualToString:@""])
            {
                if([keyString isEqualToString:@"F_cn"])
                {
                     cell.picLab.text = [personInfoModel valueForKeyPath:keyString];
                    if([personInfoModel valueForKeyPath:@"EfLUrl"] )
                    {
                        NSString *urlStr =  [personInfoModel valueForKeyPath:@"EfLUrl"];
                        urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                        NSURL *url = [[NSURL alloc]initWithString:urlStr];
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [cell.imgViewOne setImageWithURL:url];
                        });
                        
                    }
                    if([personInfoModel valueForKeyPath:@"EfRUrl"] )
                    {
                        NSString *urlStr =  [personInfoModel valueForKeyPath:@"EfRUrl"];
                        urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                        NSURL *url = [[NSURL alloc]initWithString:urlStr];
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [cell.imgViewTwo setImageWithURL:url];
                        });
                        
                    }
                    cell.twoOne.text = personInfoModel.DiagReport_cn;
                    cell.twoTwo.text = personInfoModel.DiagReport_value;
                    return cell;


                }
            }
        }

    }
    
    return nil;
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section == 2)
    {
        return 219.f;
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
    self.eyeGenerlMuKeyArr = [[NSMutableArray alloc]initWithCapacity:0];
   
    [self.eyeGenerlMuKeyArr addObject:@{@"TTTTT":@"检测指标"}];
    [self.eyeGenerlMuKeyArr addObject:@{@"Vision_cn":@"日常生活视力"}];
    [self.eyeGenerlMuKeyArr addObject:@{@"PeryGium_cn":@"是否有翼状胬肉"}];
    [self.eyeGenerlMuKeyArr addObject:@{@"Nasal_cn":@"鼻侧分级"}];
    [self.eyeGenerlMuKeyArr addObject:@{@"Nasalact_cn":@"鼻侧分期"}];
    [self.eyeGenerlMuKeyArr addObject:@{@"Temporal_cn":@"颞侧分级"}];
    [self.eyeGenerlMuKeyArr addObject:@{@"Temporalact_cn":@"颞侧分期"}];
}

-(void)loadBloodKey
{
    self.eyeQuGuangMuKeyArr = [[NSMutableArray alloc]initWithCapacity:0];
    [self.eyeQuGuangMuKeyArr addObject:@{@"TTTTT":@"检测指标"}];
    [self.eyeQuGuangMuKeyArr addObject:@{@"S_cn":@"球镜度数"}];
    [self.eyeQuGuangMuKeyArr addObject:@{@"C_cn":@"柱镜度数"}];
    [self.eyeQuGuangMuKeyArr addObject:@{@"A_cn":@"散光轴角"}];
    [self.eyeQuGuangMuKeyArr addObject:@{@"R1mm_cn":@"角膜前表面水平方向曲率半径"}];
    
    [self.eyeQuGuangMuKeyArr addObject:@{@"R1d_cn":@"角膜前表面水平方向屈光度"}];
    [self.eyeQuGuangMuKeyArr addObject:@{@"R1deg_cn":@"角膜前表面水平方向散光轴角"}];
    [self.eyeQuGuangMuKeyArr addObject:@{@"R2mm_cn":@"角膜前表面垂直方向曲率半径"}];
    [self.eyeQuGuangMuKeyArr addObject:@{@"R2d_cn":@"角膜前表面垂直方向屈光度"}];

    
    [self.eyeQuGuangMuKeyArr addObject:@{@"R2deg_cn":@"角膜前表面垂直方向散光轴角"}];
    [self.eyeQuGuangMuKeyArr addObject:@{@"Cyld_cn":@"角膜前表面水平方向屈光度与垂直方向屈光度之差"}];
    [self.eyeQuGuangMuKeyArr addObject:@{@"Cyldeg_cn":@"角膜前表面水平方向角度"}];
    [self.eyeQuGuangMuKeyArr addObject:@{@"Se_cn":@"等效球镜"}];
    
    [self.eyeQuGuangMuKeyArr addObject:@{@"Dia_cn":@"单眼总结"}];
    [self.eyeQuGuangMuKeyArr addObject:@{@"Ani_cn":@"散光情况"}];
    [self.eyeQuGuangMuKeyArr addObject:@{@"Qgdia_cn":@"屈光参差情况"}];

    
    
    
    
}

-(void)loadHeadArr
{
    self.headMuArr = [[NSMutableArray alloc]initWithCapacity:0];
    [self.headMuArr addObject:@"眼科一般检查"];
    [self.headMuArr addObject:@"眼科屈光检查"];
    [self.headMuArr addObject:@"眼科眼底检查"];
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
    self.navView.lbl_login_middle.text = @"眼科检查";
    
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
