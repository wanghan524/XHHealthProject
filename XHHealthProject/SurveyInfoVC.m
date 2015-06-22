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

@interface SurveyInfoVC ()<UITableViewDataSource,UITableViewDelegate>{
    BOOL firstSecondFlag;
    BOOL secondSectionFlag;
    BOOL thirdSectionFlag;
    BOOL fourthSectionFlag;
}


@property(nonatomic,strong)XHNavigationView *navView;
@property(nonatomic,strong)UITableView *infoTableView;

@property (nonatomic, strong) NSMutableArray *sectionTitleArray;
@property (nonatomic, strong) NSMutableArray *firstSectionArray;
@property (nonatomic, strong) NSMutableArray *secondSectionArray;
@property (nonatomic, strong) NSMutableArray *thirdSectionArray;
@property (nonatomic, strong) NSMutableArray *fourthSectionArray;

@end

@implementation SurveyInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    
    
    
    NSArray *secondOrderArray = @[@{@"Bmi":@"BMI(kg/m²)"},@{@"Shight":@"坐高(cm)"},@{@"Height":@"身高(cm)"},@{@"Weight":@"体重(kg)"},@{@"Neck":@"颈围平均值(cm)"},@{@"Waist":@"33.47"},@{@"Hip":@"臀围平均值(cm)"},@{@"":@""}];
    
    NSArray *thirdOrderArray = @[@{@"Hbp":@"是否患高血压"},@{@"Dia":@"糖尿病"},@{@"Otherdis":@"患有其他疾病"},@{@"Vaccination":@"乙肝疫苗接种史"},@{@"VaccinationDate":@"乙肝疫苗接种时间"},@{@"Fhbp":@"家族中是否患高血压"},@{@"Fdia":@"家族中患糖尿病"},@{@"Ft_cn":@"家族中患肿瘤"},@{@"Fdis":@"家族患其他疾病"},@{@"Hi":@"参加医疗保险情况"}];
    NSArray *fourthOrderArray = @[@{@"Diet":@"饮食习惯"},@{@"Smoke":@"您吸烟吗"},@{@"StartSmokeAge":@"开始吸烟年龄岁"},@{@"StopSmokeNow":@"现在是否已戒烟"},@{@"StopSmokeAge":@"开始吸烟年龄(岁)"},@{@"all":@"常吸的烟草种类和吸量"},@{@"Smoke1Amount":@"香烟的数量支/天"},@{@"Smoke2Amount":@"烟叶的数量两/月"},@{@"Smoke3Amount":@"其他的数量支/天"},@{@"Drink":@"饮酒"},@{@"StartDrage":@"开始饮酒年龄(岁)"},@{@"StopDrinkNow":@"现在是否已戒酒?"},@{@"StopDrAge":@"戒酒年龄(岁)"},@{@"all":@"饮酒种类和数量"},@{@"Wine":@"白酒"},@{@"Beer":@"啤酒"},@{@"Fruit":@"葡萄酒或果酒"},@{@"OtherDrink":@"其他"},@{@"ActiveTies":@"体力劳动"},@{@"Exercise":@"身体锻炼"}];
    
    
    self.firstSectionArray = [NSMutableArray arrayWithArray:firstOrderArray];
    
    self.secondSectionArray = [NSMutableArray arrayWithArray:secondOrderArray];
    
    
    self.thirdSectionArray = [NSMutableArray arrayWithArray:thirdOrderArray];
    
    self.fourthSectionArray = [NSMutableArray arrayWithArray:fourthOrderArray];
    
    
    self.sectionTitleArray = [NSMutableArray arrayWithObjects:@"基本信息",@"体格检查",@"疾病状况数据",@"生活方式", nil];
    
    [self bulidHomePageNav];
    [self bulidTable];
    // Do any additional setup after loading the view.
}

-(void)bulidTable
{
    self.infoTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64) style:UITableViewStylePlain];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return self.firstSectionArray.count;
    }
    
    if (section == 1) {
        return self.secondSectionArray.count;
    }
    
    if (section == 2) {
        return self.thirdSectionArray.count;
    }
    
    if (section == 3) {
        return self.fourthSectionArray.count;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"identifier";
    
    
    if (indexPath.section == 0) {
        
        NSDictionary *infoDic = [self.firstSectionArray objectAtIndex:indexPath.row];
        
        NSString *keyString = [[infoDic allKeys] firstObject];
        
        if ([keyString isEqualToString:@"Race"]) {
            SecondCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (cell == nil) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"SecondCell" owner:self options:nil] lastObject];
            }
            cell.left_middleLabel.text = [infoDic objectForKey:keyString];
            cell.middle_upLabel.text = @"本人民族";
            cell.middle_middleLabel.text = @"父亲民族";
            cell.middle_downLabel.text = @"母亲民族";
            cell.right_upLabel.text = @"--";
            cell.right_middleLabel.text = @"--";
            cell.right_downLabel.text = @"--";
            return cell;
        }
        
        else if ([keyString isEqualToString:@"Birplace"]){
            FourthInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (cell == nil) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"FourthInfoCell" owner:self options:nil] lastObject];
            }
            cell.left_middleLabel.text = [infoDic objectForKey:keyString];
            cell.middle_upLabel.text = @"出生地";
            cell.middle_downLabel.text = @"出生地址";
            cell.right_upLabel.text = @"--";
            cell.right_downLabel.text = @"--";
            return cell;
        }
        
        else if ([keyString isEqualToString:@"NowPlace"]){
            SecondCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (cell == nil) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"SecondCell" owner:self options:nil] lastObject];
            }
            cell.left_middleLabel.text = [infoDic objectForKey:keyString];
            cell.middle_upLabel.text = @"现住地";
            cell.middle_middleLabel.text = @"移居时间";
            cell.middle_downLabel.text = @"移居时间";
            cell.right_upLabel.text = @"--";
            cell.right_middleLabel.text = @"--";
            cell.right_downLabel.text = @"--";
            return cell;
        }
        else if ([keyString isEqualToString:@"Call"]){
            FourthInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (cell == nil) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"FourthInfoCell" owner:self options:nil] lastObject];
            }
            cell.left_middleLabel.text = [infoDic objectForKey:keyString];
            cell.middle_upLabel.text = @"联系电话";
            cell.middle_downLabel.text = @"手机";
            cell.right_upLabel.text = @"--";
            cell.right_downLabel.text = @"--";
            return cell;
        }
        
        else if ([keyString isEqualToString:@"Elevelm"]){
            FourthInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (cell == nil) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"FourthInfoCell" owner:self options:nil] lastObject];
            }
            cell.left_middleLabel.text = [infoDic objectForKey:keyString];
            cell.middle_upLabel.text = @"个人月收";
            cell.middle_downLabel.text = @"个人年收";
            cell.right_upLabel.text = @"--";
            cell.right_downLabel.text = @"--";
            return cell;
        }
        else{
            FirstCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (cell == nil) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"FirstCell" owner:self options:nil] lastObject];
            }
            cell.left_middleLabel.text = [infoDic objectForKey:keyString];
            cell.right_middleLabel.text = @"--";
            return cell;
        }
    
        
    }
    
    else if (indexPath.section == 1){
        return nil;
    }
    
    else if (indexPath.section == 2){
        return nil;
    }
    else{
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
        if (indexPath.row == 0) {
            return 44;
        }
        else if (indexPath.row == 1){
            return 300;
        }
        else if (indexPath.row == 2){
            return 44;
        }
        else{
            return 150;
        }
    }
    
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
