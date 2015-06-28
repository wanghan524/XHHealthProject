//
//  PersonInfoViewController.m
//  XHHealthProject
//
//  Created by BlueApp on 15-6-28.
//  Copyright (c) 2015年 AlexYang. All rights reserved.
//

#import "PersonInfoViewController.h"

#import "XHNavigationView.h"
#import "WSRequestManager.h"
#import "MBProgressHUD.h"


#import "HeaderImageCell.h"
#import "PersonOtherInfoCell.h"

#import "PersonInfoSingleTon.h"


@interface PersonInfoViewController ()<UITableViewDelegate,UITableViewDataSource>{
    PersonInfoSingleTon *personSingleTon;
}

@property(nonatomic,strong)XHNavigationView *navView;
@property(nonatomic,strong)UITableView *infoTableView;
@property(nonatomic,strong)UIView *bgView;

@end

@implementation PersonInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    personSingleTon = [PersonInfoSingleTon personInfoShareInstance];
    
    [self bulidHomePageNav];
    [self bulidTable];
    // Do any additional setup after loading the view.
}


-(void)bulidHomePageNav
{
    self.navView = [[XHNavigationView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth,64)];
    [self.navView layoutXHNavWithType:Type_LoginNav];
    self.navView.backgroundColor = NAVColor;
    [self.navView.btn_login setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    //self.navView.lbl_login.text = @"登录";
    self.navView.lbl_login_middle.text = @"个人信息";
    [self.navView.btn_login addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.navView];
}


-(void)bulidTable
{
    self.infoTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64) style:UITableViewStyleGrouped];
    self.infoTableView.delegate = self;
    self.infoTableView.dataSource = self;
    self.infoTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.infoTableView];
    
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    else if (section == 1){
        return 3;
    }
    else if (section == 2){
        return 3;
    }
    else{
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 80;
    }
    else{
        return 44;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    /*
     
     @property (nonatomic, strong) NSString *addressString;
     @property (nonatomic, strong) NSString *emailString;
     @property (nonatomic, strong) NSString *exMessageString;
     @property (nonatomic, strong) NSString *phoneString;
     @property (nonatomic, strong) NSString *sexString;
     @property (nonatomic, strong) NSString *successString;
     @property (nonatomic, strong) NSString *userImageString;
     @property (nonatomic, strong) NSString *userNameString;
     @property (nonatomic, strong) NSString *idNumberString;
     
     
     */
    
    NSArray *infoArray = @[@[@{@"头像":@"userImageString"}],@[@{@"姓名":@"userNameString"},@{@"身份证号码":@"idNumberString"},@{@"性别":@"sexString"}],@[@{@"手机":@"phoneString"},@{@"邮箱":@"emailString"},@{@"地址":@"addressString"}],@[@{@"修改密码":@""}]];
    
    NSArray *nowArray = [infoArray objectAtIndex:indexPath.section];
    if (indexPath.section == 0) {
        
        static NSString *identifier = @"headerImageCell";
        
        NSDictionary *infoDic = [nowArray objectAtIndex:indexPath.row];
        HeaderImageCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"HeaderImageCell" owner:self options:nil] lastObject];
        }
        cell.headerNameLabel.text = [[infoDic allKeys] objectAtIndex:indexPath.row];
        return cell;
    }
    else{
        static NSString *identifier = @"personOtherInfo";
        
        NSDictionary *infoDic = [nowArray objectAtIndex:indexPath.row];
        
        PersonOtherInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"PersonOtherInfoCell" owner:self options:nil] lastObject];
        }
        cell.left_middleLabel.text = [[infoDic allKeys] objectAtIndex:indexPath.row];
        cell.right_middleLabel.text = [personSingleTon valueForKey:[infoDic objectForKey:[[infoDic allKeys] objectAtIndex:indexPath.row]]];
        return cell;
    }
}

- (void)backButtonClick{
    
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
