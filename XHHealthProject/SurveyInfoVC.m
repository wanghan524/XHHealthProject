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

@interface SurveyInfoVC ()<UITableViewDataSource,UITableViewDelegate>


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
    
    self.firstSectionArray = [[NSMutableArray alloc] initWithObjects:@"姓名",@"性别",@"民族",@"出生日期(阳历)",@"实足年龄(岁)",@"出生地",@"现住地",@"联系电话",@"身份证号码",@"文化程度",@"个人收人状况",@"婚姻状况",@"职业",@"家庭年收入",@"--",@"初潮年龄(岁)",@"月经规律",@"绝经年龄(岁)", nil];
    
    self.secondSectionArray = [[NSMutableArray alloc] initWithObjects:@"BMI(Kg/m²)",@" ",@"",@"",@"",@"",@"", nil];
    
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
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"identifier";
    
    
    if (indexPath.section == 0) {
        
    }
    
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
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
