//
//  PersonInfoVC.m
//  XHHealthProject
//
//  Created by 菁优数学 on 15/6/15.
//  Copyright (c) 2015年 AlexYang. All rights reserved.
//

#import "PersonInfoVC.h"
#import "XHNavigationView.h"
#import "BaseInfoCell.h"
@interface PersonInfoVC ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)XHNavigationView *navView;
@property(nonatomic,strong)UITableView *infoTableView;
@end

@implementation PersonInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self bulidHomePageNav];
    [self bulidTable];
}

-(void)bulidTable
{
    self.infoTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64) style:UITableViewStylePlain];
    self.infoTableView.delegate = self;
    self.infoTableView.dataSource = self;
    self.infoTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.infoTableView];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 770.f;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *iden = @"BaseInfoCell";
    BaseInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:iden];
    if(nil == cell)
    {
        cell = (BaseInfoCell*)[[[NSBundle mainBundle]loadNibNamed:@"BaseInfoCell" owner:self options:nil]lastObject];
    }
    return cell;
    
}




-(void)bulidHomePageNav
{
    self.navView = [[XHNavigationView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth,64)];
    [self.navView layoutXHNavWithType:Type_LoginNav];
    self.navView.backgroundColor = NAVColor;
    [self.navView.btn_login setImage:[UIImage imageNamed:@"head"] forState:UIControlStateNormal];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    if ([user valueForKey:@"UserName"] != nil) {
        self.navView.lbl_login.text = [user valueForKey:@"UserName"];
    }else{
        self.navView.lbl_login.text = @"登录";
    }
    self.navView.lbl_login_middle.text = @"协和健康管理";
//    [self.navView.btn_login addTarget:self action:@selector(loginBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.navView];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
