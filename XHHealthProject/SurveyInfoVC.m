//
//  SurveyInfoVC.m
//  XHHealthProject
//
//  Created by BlueApp on 15-6-22.
//  Copyright (c) 2015年 AlexYang. All rights reserved.
//

#import "SurveyInfoVC.h"
#import "FirstCell.h"
#import "SecondCell.h"
#import "ThirdInfoCell.h"
#import "FourthInfoCell.h"

#import "XHNavigationView.h"
#import "WSRequestManager.h"
#import "MBProgressHUD.h" 

#import "LifeStyleModel.h"
#import "DiseaseStatusModel.h"
#import "BodyCheckModel.h"
#import "PersonInfoModel.h"

@interface SurveyInfoVC ()<UITableViewDataSource,UITableViewDelegate,MBProgressHUDDelegate>{
    BOOL firstSecondFlag;
    BOOL secondSectionFlag;
    BOOL thirdSectionFlag;
    BOOL fourthSectionFlag;
}


@property(nonatomic,strong)XHNavigationView *navView;
@property(nonatomic,strong)UITableView *infoTableView;
@property(nonatomic,strong)UIView *bgView;

@property (nonatomic, strong) NSMutableArray *sectionTitleArray;
@property (nonatomic, strong) NSMutableArray *firstSectionArray;
@property (nonatomic, strong) NSMutableArray *secondSectionArray;
@property (nonatomic, strong) NSMutableArray *thirdSectionArray;
@property (nonatomic, strong) NSMutableArray *fourthSectionArray;

@property (nonatomic, strong) NSMutableArray *personDataArray;
@property (nonatomic, strong) NSMutableArray *bodyDataArray;
@property (nonatomic, strong) NSMutableArray *liftDataArray;
@property (nonatomic, strong) NSMutableArray *diseaseDataArray;

@property(nonatomic,strong)MBProgressHUD *hud;

@end

@implementation SurveyInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.personDataArray == nil) {
        self.personDataArray = [[NSMutableArray alloc] init];
    }
    
    if (self.bodyDataArray == nil) {
        self.bodyDataArray = [[NSMutableArray alloc] init];
    }
    
    if (self.liftDataArray == nil) {
        self.liftDataArray = [[NSMutableArray alloc] init];
    }
    
    if (self.diseaseDataArray == nil) {
        self.diseaseDataArray = [[NSMutableArray alloc] init];
    }
    
    if (self.sectionTitleArray == nil) {
        self.sectionTitleArray = [[NSMutableArray alloc] init];

    }
    
    if (self.firstSectionArray == nil) {
        self.firstSectionArray = [[NSMutableArray alloc] init];
    }
    
    if (self.secondSectionArray == nil) {
        self.secondSectionArray = [[NSMutableArray alloc] init];
    }
    if (self.thirdSectionArray == nil) {
        self.thirdSectionArray = [[NSMutableArray alloc] init];
    }
    if (self.fourthSectionArray == nil) {
        self.fourthSectionArray = [[NSMutableArray alloc] init];
    }
    
    
    NSArray *firstOrderArray = @[@{@"Name":@"姓名"},@{@"Sex":@"性别"},@{@"Race":@"民族"},@{@"Birthday":@"出生日期(阳历)"},@{@"Age":@"实足年龄(岁)"},@{@"Birplace":@"出生地"},@{@"NowPlace":@"现住地"},@{@"Call":@"联系电话"},@{@"IdNumber":@"身份证号码"},@{@"Edu":@"文化程度"},@{@"Elevelm":@"个人收人状况"},@{@"Marital":@"婚姻状况"},@{@"Occupation":@"职业"},@{@"Felevely":@"家庭年收入"},@{@"Fnumber":@"--"},@{@"Menophaniaage":@"初潮年龄(岁)"},@{@"Regular":@"月经规律"},@{@"Menopayage":@"绝经年龄(岁)"}];
    
    NSArray *secondOrderArray = @[@{@"Bmi":@"BMI(kg/m²)"},@{@"Shight":@"坐高(cm)"},@{@"Height":@"身高(cm)"},@{@"Weight":@"体重(kg)"},@{@"Neck":@"颈围平均值(cm)"},@{@"Waist":@"33.47"},@{@"Hip":@"臀围平均值(cm)"}];
    
    NSArray *thirdOrderArray = @[@{@"Hbp":@"是否患高血压"},@{@"Dia":@"糖尿病"},@{@"Otherdis":@"患有其他疾病"},@{@"Vaccination":@"乙肝疫苗接种史"},@{@"VaccinationDate":@"乙肝疫苗接种时间"},@{@"Fhbp":@"家族中是否患高血压"},@{@"Fdia":@"家族中患糖尿病"},@{@"Ft":@"家族中患肿瘤"},@{@"Fdis":@"家族患其他疾病"},@{@"Hi":@"参加医疗保险情况"}];
    
    NSArray *fourthOrderArray = @[@{@"Diet":@"饮食习惯"},@{@"Smoke":@"您吸烟吗"},@{@"StartSmokeAge":@"开始吸烟年龄岁"},@{@"StopSmokeNow":@"现在是否已戒烟"},@{@"StopSmokeAge":@"开始吸烟年龄(岁)"},@{@"all":@"常吸的烟草种类和吸量"},@{@"Smoke1Amount":@"香烟的数量支/天"},@{@"Smoke2Amount":@"烟叶的数量两/月"},@{@"Smoke3Amount":@"其他的数量支/天"},@{@"Drink":@"饮酒"},@{@"StartDrage":@"开始饮酒年龄(岁)"},@{@"StopDrinkNow":@"现在是否已戒酒?"},@{@"StopDrAge":@"戒酒年龄(岁)"},@{@"all":@"饮酒种类和数量"},@{@"Wine":@"白酒"},@{@"Beer":@"啤酒"},@{@"Fruit":@"葡萄酒或果酒"},@{@"OtherDrink":@"其他"},@{@"ActiveTies":@"体力劳动"},@{@"Exercise":@"身体锻炼"}];
    
    
    self.firstSectionArray = [NSMutableArray arrayWithArray:firstOrderArray];
    
    self.secondSectionArray = [NSMutableArray arrayWithArray:secondOrderArray];
    
    
    self.thirdSectionArray = [NSMutableArray arrayWithArray:thirdOrderArray];
    
    self.fourthSectionArray = [NSMutableArray arrayWithArray:fourthOrderArray];
    
    
    self.sectionTitleArray = [NSMutableArray arrayWithObjects:@"基本信息",@"体格检查",@"疾病状况数据",@"生活方式", nil];
    
    [self bulidHomePageNav];
    [self bulidTable];
    
    [self requestBodyData];
    [self requestDiseaseData];
    [self requestLiftStyleData];
    [self requestUserInfoData];
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


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.sectionTitleArray.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [self.sectionTitleArray objectAtIndex:section];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIButton *clickButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    clickButton.frame = CGRectMake(0, 0, ScreenWidth, 30);
    clickButton.tag = 10 + section;
    
    [clickButton setTitle:[self.sectionTitleArray objectAtIndex:section] forState:UIControlStateNormal];
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
    else if (bpt.tag == 11){
        secondSectionFlag = !secondSectionFlag;
    }
    else if (bpt.tag == 12){
        thirdSectionFlag = !thirdSectionFlag;
    }
    else{
        fourthSectionFlag = !fourthSectionFlag;
    }
    
    [self.infoTableView reloadData];
    //[self requestDataWithIndex:bpt.tag];
    NSLog(@"tag : %ld",bpt.tag);
    
}

- (void)requestUserInfoData{
    
//    NSString *medthodString;
//    
//    if (index == 10) {
//        medthodString = USERINFO;
//    }
//    else if (index == 11){
//        medthodString = PHYSICALEXAM;
//    }
//    else if (index == 12){
//        medthodString = DISEASESTATUS;
//    }
//    else{
//        medthodString = LIFRSTYLE;
//    }
    
    
    [WSRequestManager XHGetRequestParameters:@{@"_IDNumber":@"61010319600411241X"} withMethodName:USERINFO SuccessRequest:^(id data) {
        NSArray *resultArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        
        if([resultArray count] > 0)
        {
            NSDictionary *resultDic = resultArray[0];
            
                PersonInfoModel *personInfoModel = [[PersonInfoModel alloc] init];
                
                [personInfoModel setValuesForKeysWithDictionary:resultDic];
                
                [self.personDataArray addObject:personInfoModel];
                
                
            
            
            
            //[self showErrorHUDWithStr:resultDic[@"ExMessage"]];
            
            
            
            [self.infoTableView reloadData];
        }
        
    } FailRequest:^(id data, NSError *error) {
        
    }];
    
}


- (void)requestBodyData{
    [WSRequestManager XHGetRequestParameters:@{@"_IDNumber":CARD} withMethodName:PHYSICALEXAM SuccessRequest:^(id data) {
        NSArray *resultArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        
        if([resultArray count] > 0)
        {
            NSDictionary *resultDic = resultArray[0];
            
            BodyCheckModel *personInfoModel = [[BodyCheckModel alloc] init];
            
            [personInfoModel setValuesForKeysWithDictionary:resultDic];
            
            [self.bodyDataArray addObject:personInfoModel];
            
            
            
            
            
            //[self showErrorHUDWithStr:resultDic[@"ExMessage"]];
            
            
            
            [self.infoTableView reloadData];
        }
        
    } FailRequest:^(id data, NSError *error) {
        
    }];

}

- (void)requestLiftStyleData{
    [WSRequestManager XHGetRequestParameters:@{@"_IDNumber":@"61010319600411241X"} withMethodName:LIFRSTYLE SuccessRequest:^(id data) {
        NSArray *resultArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        
        if([resultArray count] > 0)
        {
            NSDictionary *resultDic = resultArray[0];
            
            LifeStyleModel *personInfoModel = [[LifeStyleModel alloc] init];
            
            [personInfoModel setValuesForKeysWithDictionary:resultDic];
            
            [self.liftDataArray addObject:personInfoModel];
            
            
            
            
            
            //[self showErrorHUDWithStr:resultDic[@"ExMessage"]];
            
            
            
            [self.infoTableView reloadData];
        }
        
    } FailRequest:^(id data, NSError *error) {
        
    }];
}

- (void)requestDiseaseData{
    [WSRequestManager XHGetRequestParameters:@{@"_IDNumber":@"61010319600411241X"} withMethodName:DISEASESTATUS SuccessRequest:^(id data) {
        NSArray *resultArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        
        if([resultArray count] > 0)
        {
            NSDictionary *resultDic = resultArray[0];
            
            DiseaseStatusModel *personInfoModel = [[DiseaseStatusModel alloc] init];
            
            [personInfoModel setValuesForKeysWithDictionary:resultDic];
            
            [self.diseaseDataArray addObject:personInfoModel];
            
            
            
            
            
            //[self showErrorHUDWithStr:resultDic[@"ExMessage"]];
            
            
            
            [self.infoTableView reloadData];
        }
        
    } FailRequest:^(id data, NSError *error) {
        
    }];
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        if (firstSecondFlag) {
            return self.firstSectionArray.count;
        }else{
            return 0;
        }
        
    }
    
    if (section == 1) {
        
        if (secondSectionFlag) {
            return self.secondSectionArray.count;
        }else{
            return 0;
        }
        
    }
    
    if (section == 2) {
        
        if (thirdSectionFlag) {
            return self.thirdSectionArray.count;
        }else{
            return 0;
        }
        
    }
    
    if (section == 3) {
        
        if (fourthSectionFlag) {
            return self.fourthSectionArray.count;
        }else{
            return 0;
        }
        
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"identifier";
    
    
    if (indexPath.section == 0) {
        
        
        PersonInfoModel *personInfoModel = [self.personDataArray objectAtIndex:0];
        
        
        
        
        NSDictionary *infoDic = [self.firstSectionArray objectAtIndex:indexPath.row];
        
        NSString *keyString = [[infoDic allKeys] firstObject];
        
        if ([keyString isEqualToString:@"Race"]) {
            
            static NSString *secondIdentifier = @"secondIdentifier";
            SecondCell *cell = [tableView dequeueReusableCellWithIdentifier:secondIdentifier];
            if (cell == nil) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"SecondCell" owner:self options:nil] lastObject];
            }
        
            NSString *raceValue = [NSString stringWithFormat:@"%@_value",keyString];

            //DLog(@"%@,%@",[personInfoModel valueForKey:raceValue],[personInfoModel valueForKeyPath:raceValue]);
            
            cell.left_middleLabel.text = [infoDic objectForKey:keyString];
            cell.middle_upLabel.text = [personInfoModel valueForKeyPath:[NSString stringWithFormat:@"%@_cn",keyString]];
            cell.middle_middleLabel.text = [personInfoModel valueForKeyPath:[NSString stringWithFormat:@"%@f_cn",keyString]];
            cell.middle_downLabel.text = [personInfoModel valueForKeyPath:[NSString stringWithFormat:@"%@m_cn",keyString]];
            cell.right_upLabel.text = [personInfoModel valueForKeyPath:[NSString stringWithFormat:@"%@_value",keyString]];
            cell.right_middleLabel.text = [personInfoModel valueForKeyPath:[NSString stringWithFormat:@"%@f_value",keyString]];
            cell.right_downLabel.text = [personInfoModel valueForKeyPath:[NSString stringWithFormat:@"%@m_value",keyString]];
            return cell;
        }
        
        else if ([keyString isEqualToString:@"Birplace"]){
            
            static NSString *fourthIdentifier = @"fourthIdentifier";
            FourthInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:fourthIdentifier];
            if (cell == nil) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"FourthInfoCell" owner:self options:nil] lastObject];
            }
            cell.left_middleLabel.text = [infoDic objectForKey:keyString];
            cell.middle_upLabel.text = [personInfoModel valueForKeyPath:[NSString stringWithFormat:@"Birplace_cn"]];
            cell.middle_downLabel.text = [personInfoModel valueForKeyPath:[NSString stringWithFormat:@"Biraddress_cn"]];
            cell.right_upLabel.text = [personInfoModel valueForKeyPath:[NSString stringWithFormat:@"Birplace_value"]];;
            cell.right_downLabel.text = [personInfoModel valueForKeyPath:[NSString stringWithFormat:@"Biraddress_value"]];
            return cell;
        }
        
        else if ([keyString isEqualToString:@"NowPlace"]){
            
            static NSString *secondIdentifier = @"secondIdentifier";

            SecondCell *cell = [tableView dequeueReusableCellWithIdentifier:secondIdentifier];
            if (cell == nil) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"SecondCell" owner:self options:nil] lastObject];
            }
            cell.left_middleLabel.text = [infoDic objectForKey:keyString];
            cell.middle_upLabel.text = [personInfoModel valueForKeyPath:[NSString stringWithFormat:@"NowPlace_cn"]];
            cell.middle_middleLabel.text = [personInfoModel valueForKeyPath:[NSString stringWithFormat:@"NowAddress_cn"]];
            cell.middle_downLabel.text = [personInfoModel valueForKeyPath:[NSString stringWithFormat:@"MoveTime_cn"]];
            cell.right_upLabel.text = [personInfoModel valueForKeyPath:[NSString stringWithFormat:@"NowPlace_value"]];;
            cell.right_middleLabel.text = [personInfoModel valueForKeyPath:[NSString stringWithFormat:@"NowAddress_value"]];
            cell.right_downLabel.text = [personInfoModel valueForKeyPath:[NSString stringWithFormat:@"MoveTime_value"]];
            return cell;
        }
        else if ([keyString isEqualToString:@"Call"]){
            static NSString *fourthIdentifier = @"fourthIdentifier";
            
            FourthInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:fourthIdentifier];
            if (cell == nil) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"FourthInfoCell" owner:self options:nil] lastObject];
            }
            cell.left_middleLabel.text = [infoDic objectForKey:keyString];
            cell.middle_upLabel.text = [personInfoModel valueForKeyPath:[NSString stringWithFormat:@"Call_cn"]];
            cell.middle_downLabel.text = [personInfoModel valueForKeyPath:[NSString stringWithFormat:@"CellPhone_cn"]];
            cell.right_upLabel.text = [personInfoModel valueForKeyPath:[NSString stringWithFormat:@"Call_value"]];
            cell.right_downLabel.text = [personInfoModel valueForKeyPath:[NSString stringWithFormat:@"CellPhone_value"]];
            return cell;
        }
        
        else if ([keyString isEqualToString:@"Elevelm"]){
            
            static NSString *fourthIdentifier = @"fourthIdentifier";
            
            FourthInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:fourthIdentifier];
            if (cell == nil) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"FourthInfoCell" owner:self options:nil] lastObject];
            }
            cell.left_middleLabel.text = [infoDic objectForKey:keyString];
            cell.middle_upLabel.text = [personInfoModel valueForKeyPath:[NSString stringWithFormat:@"Elevelm_cn"]];
            cell.middle_downLabel.text = [personInfoModel valueForKeyPath:[NSString stringWithFormat:@"Elevely_cn"]];
            cell.right_upLabel.text = [personInfoModel valueForKeyPath:[NSString stringWithFormat:@"Elevelm_value"]];
            cell.right_downLabel.text = [personInfoModel valueForKeyPath:[NSString stringWithFormat:@"Elevely_value"]];
            return cell;
        }
        else{
            
            
            
            
            
            static NSString *nowIdentifier = @"firstCell";
            
            
            
            FirstCell *cell = [tableView dequeueReusableCellWithIdentifier:nowIdentifier];
            if (cell == nil) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"FirstCell" owner:self options:nil] lastObject];
            }
            cell.left_middleLabel.text = [infoDic objectForKey:keyString];
            cell.right_middleLabel.text = [personInfoModel valueForKeyPath:[NSString stringWithFormat:@"%@_value",keyString]];
            return cell;
        }
    
        
    }
    
    
    
    else if (indexPath.section == 1){
        
        BodyCheckModel *bodyCheckModel = [self.bodyDataArray objectAtIndex:0];
        
        static NSString *thirdIdentifier = @"ThirdInfoCell";
        
        NSDictionary *infoDic = [self.secondSectionArray objectAtIndex:indexPath.row];
        
        NSString *keyString = [[infoDic allKeys] firstObject];
        
        ThirdInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:thirdIdentifier];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"ThirdInfoCell" owner:self options:nil] lastObject];
        }
        
        cell.thirdFierstLabel.text = [infoDic objectForKey:keyString];
        cell.thirdSecondLabel.text = [bodyCheckModel valueForKeyPath:[NSString stringWithFormat:@"%@_value",keyString]];
        cell.thirdThirdLabel.text = [bodyCheckModel valueForKeyPath:[NSString stringWithFormat:@"%@_refinterVal",keyString]];
        
        return cell;
        
        
        
    }
    
    
    
    else if (indexPath.section == 2){
        
        DiseaseStatusModel *diseaseStatusModel = [self.diseaseDataArray objectAtIndex:0];
        
        static NSString *nowIdentifier = @"firstCell";
        
        NSDictionary *infoDic = [self.thirdSectionArray objectAtIndex:indexPath.row];
        
        NSString *keyString = [[infoDic allKeys] firstObject];
        
        FirstCell *cell = [tableView dequeueReusableCellWithIdentifier:nowIdentifier];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"FirstCell" owner:self options:nil] lastObject];
        }
        cell.left_middleLabel.text = [infoDic objectForKey:keyString];
        cell.right_middleLabel.text = [diseaseStatusModel valueForKeyPath:[NSString stringWithFormat:@"%@_value",keyString]];
        return cell;
        
    }
    
    
    
    
    
    
    else{
        
        LifeStyleModel *lifeStyleModel = [self.liftDataArray objectAtIndex:0];
        NSDictionary *infoDic = [self.fourthSectionArray objectAtIndex:indexPath.row];
        
        NSString *keyString = [[infoDic allKeys] firstObject];
        
        if ([keyString isEqualToString:@"all"]) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
                cell.textLabel.text = [infoDic objectForKey:keyString];
                cell.textLabel.textAlignment = NSTextAlignmentCenter;
            }
            return cell;
        }
        
        else{
            
            static NSString *nowIdentifier = @"firstCell";
            
            FirstCell *cell = [tableView dequeueReusableCellWithIdentifier:nowIdentifier];
            if (cell == nil) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"FirstCell" owner:self options:nil] lastObject];
            }
            cell.left_middleLabel.text = [infoDic objectForKey:keyString];
            cell.right_middleLabel.text = [lifeStyleModel valueForKeyPath:[NSString stringWithFormat:@"%@_value",keyString]];
            return cell;
        }
        
        
#if 0
        if (indexPath.row == 0) {
            FirstCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (cell == nil) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"FirstCell" owner:self options:nil] lastObject];
            }
            return cell;
        }
        else if (indexPath.row == 1){
            SecondCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (cell == nil) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"SecondCell" owner:self options:nil] lastObject];
            }
            return cell;
        }
        else if (indexPath.row == 2){
            ThirdInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (cell == nil) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"ThirdInfoCell" owner:self options:nil] lastObject];
            }
            return cell;
        }
        else{
            FourthInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (cell == nil) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"FourthInfoCell" owner:self options:nil] lastObject];
            }
            return cell;
        }
#endif

    }
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        NSDictionary *infoDic = [self.firstSectionArray objectAtIndex:indexPath.row];
        
        NSString *keyString = [[infoDic allKeys] firstObject];
        
        if ([keyString isEqualToString:@"Race"]) {
        
            return 110;
        }
        
        else if ([keyString isEqualToString:@"Birplace"]){
            
            return 80;
        }
        
        else if ([keyString isEqualToString:@"NowPlace"]){
            
            return 110;
        }
        else if ([keyString isEqualToString:@"Call"]){
            
            return 80;
        }
        
        else if ([keyString isEqualToString:@"Elevelm"]){
            
            return 80;
        }
        else{
            
            return 44;
        }
        
        
    }else{
        return 44;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
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
