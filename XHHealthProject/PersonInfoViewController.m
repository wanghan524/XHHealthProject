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

#import "EditPassVC.h"

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
    self.infoTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.infoTableView.delegate = self;
    self.infoTableView.dataSource = self;
    //self.infoTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.infoTableView];
    
    UIButton *bottomButton = [UIButton buttonWithType:UIButtonTypeCustom];
    bottomButton.frame = CGRectMake(0, self.view.frame.size.height - 40, self.view.frame.size.width, 40);
    [bottomButton setTitle:@"注销当前用户" forState:UIControlStateNormal];
    [bottomButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    bottomButton.titleLabel.font = [UIFont systemFontOfSize:15];
    bottomButton.backgroundColor = [UIColor grayColor];
    [bottomButton addTarget:self action:@selector(bottomButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.infoTableView.tableFooterView = bottomButton;
    
    
}

- (void)bottomButtonClick{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    [user removeObjectForKey:@"Address"];
    [user removeObjectForKey:@"Email"];
    [user removeObjectForKey:@"Phone"];
    [user removeObjectForKey:@"Sex"];
    [user removeObjectForKey:@"Success"];
    [user removeObjectForKey:@"UserImage"];
    [user removeObjectForKey:@"UserName"];
    [user removeObjectForKey:@"IdNumber"];
    
    [self.infoTableView reloadData];
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 3)
    {
        EditPassVC *vc = [[EditPassVC alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
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
    
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    /*
    [user setObject:[resultDic objectForKey:@"Address"] forKey:@"Address"];
    [user setObject:[resultDic objectForKey:@"Email"] forKey:@"Email"];
    [user setObject:[resultDic objectForKey:@"Phone"] forKey:@"Phone"];
    [user setObject:[resultDic objectForKey:@"Sex"] forKey:@"Sex"];
    
    [user setObject:[resultDic objectForKey:@"Success"] forKey:@"Success"];
    [user setObject:[resultDic objectForKey:@"UserImage"] forKey:@"UserImage"];
    [user setObject:[resultDic objectForKey:@"UserName"] forKey:@"UserName"];
    [user setObject:self.userTxt.text forKey:@"IdNumber"];
    */
    
    NSArray *infoArray = @[@[@{@"头像":@"UserImage"}],@[@{@"姓名":@"UserName"},@{@"身份证号码":@"IdNumber"},@{@"性别":@"Sex"}],@[@{@"手机":@"Phone"},@{@"邮箱":@"Email"},@{@"地址":@"Address"}],@[@{@"修改密码":@""}]];
    
    NSArray *nowArray = [infoArray objectAtIndex:indexPath.section];
    if (indexPath.section == 0) {
        
        static NSString *identifier = @"headerImageCell";
        
        NSDictionary *infoDic = [nowArray objectAtIndex:indexPath.row];
        HeaderImageCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"HeaderImageCell" owner:self options:nil] lastObject];
        }
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        cell.headerNameLabel.text = [[infoDic allKeys] objectAtIndex:indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else if (indexPath.section == 3){
        static NSString *identifier = @"infoCell";
        
        NSDictionary *infoDic = [nowArray objectAtIndex:indexPath.row];
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        
        cell.textLabel.text = [[infoDic allKeys] objectAtIndex:0];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    else{
        static NSString *identifier = @"personOtherInfo";
        
        NSDictionary *infoDic = [nowArray objectAtIndex:indexPath.row];
        
        PersonOtherInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"PersonOtherInfoCell" owner:self options:nil] lastObject];
        }
        cell.left_middleLabel.text = [[infoDic allKeys] objectAtIndex:0];
        
        if (![[infoDic objectForKey:[[infoDic allKeys] objectAtIndex:0]] isEqualToString:@""]) {
            //cell.right_middleLabel.text = [personSingleTon valueForKey:[infoDic objectForKey:[[infoDic allKeys] objectAtIndex:0]]];
            cell.right_middleLabel.text = [user valueForKey:[infoDic objectForKey:[[infoDic allKeys] objectAtIndex:0]]];
        }
        
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

- (void)backButtonClick{
    HomePageVC *homeVC = [[HomePageVC alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:homeVC];
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    [delegate.draw closeDrawerAnimated:YES completion:nil];
    delegate.draw.centerViewController = nav;
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
