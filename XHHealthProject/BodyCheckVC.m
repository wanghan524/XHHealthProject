//
//  BodyCheckVC.m
//  XHHealthProject
//
//  Created by 菁优数学 on 15/6/22.
//  Copyright (c) 2015年 AlexYang. All rights reserved.
//

#import "BodyCheckVC.h"
#import "XHNavigationView.h"
#import "ThirdInfoCell.h"
#import "WSRequestManager.h"
#import "XHHealthRequest.h"
#import "FitNessModel.h"

@interface BodyCheckVC ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)XHNavigationView *navView;
@property(nonatomic,strong)UITableView *infoTableView;

@property(nonatomic,strong)NSMutableArray *orderMuArr;
@property(nonatomic,strong)FitNessModel *model;

@end

@implementation BodyCheckVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self bulidHomePageNav];
    [self bulidOrderMuArr];
    [self bulidTable];
    [self startRequest];
}



-(void)startRequest
{
    [WSRequestManager XHGetRequestParameters:@{@"_IDNumber":CARD} withMethodName:FITNESS SuccessRequest:^(id data) {
        NSArray *resultArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        
        if([resultArray count] > 0)
        {
            NSDictionary *resultDic = resultArray[0];
            self.model = [[FitNessModel alloc]init];
            [self.model setValuesForKeysWithDictionary:resultDic];
            [self.infoTableView reloadData];
        }
        
    } FailRequest:^(id data, NSError *error) {
        
    }];
    

}

-(void)bulidOrderMuArr
{
    self.orderMuArr = [[NSMutableArray alloc]initWithCapacity:0];
    [self.orderMuArr addObject:@{@"Jump_cn":@"纵跳最大值(cm)"}];
    [self.orderMuArr addObject:@{@"Grip_cn":@"握力最大值(kg)"}];
    [self.orderMuArr addObject:@{@"Bending_cn":@"坐位体前屈最大值(cm)"}];
    
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
    return 40.f;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.orderMuArr.count;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"FitNessView"];
    if(!headView)
    {
        headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 30)];
    }
    if(section == 0)
    {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 30)];
        label.text = @"体质检查";
        label.font = [UIFont systemFontOfSize:14];
        [headView addSubview:label];
    }
    return headView;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30.f;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *iden = @"ThirdInfoCell";
    ThirdInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:iden];
    if(nil == cell)
    {
        cell = (ThirdInfoCell*)[[[NSBundle mainBundle]loadNibNamed:@"ThirdInfoCell" owner:self options:nil]lastObject];
    }
    if(self.model == nil)
    {
       NSDictionary *tmpDic = self.orderMuArr[[indexPath row]];
        cell.thirdFierstLabel.text = [tmpDic  objectForKey:[[tmpDic allKeys]firstObject]];
        cell.thirdSecondLabel.text = @"--";
        cell.thirdThirdLabel.text = @"--";
    }
    else
    {
        NSDictionary *tmpDic = self.orderMuArr[[indexPath row]];
        NSString *key = [[tmpDic allKeys]firstObject];
        
        if([key isEqualToString:@"Jump_cn"])
        {
            cell.thirdFierstLabel.text = self.model.Jump_cn;
            cell.thirdSecondLabel.text = self.model.Jump_value;
            cell.thirdThirdLabel.text = self.model.Jump_refinterVal;
        }else
            if([key isEqualToString:@"Grip_cn"])
            {
                cell.thirdFierstLabel.text = self.model.Grip_cn;
                cell.thirdSecondLabel.text = self.model.Grip_value;
                cell.thirdThirdLabel.text = self.model.Grip_refinterVal;
            }
        else
            if([key isEqualToString:@"Bending_cn"])
            {
                cell.thirdFierstLabel.text = self.model.Bending_cn;
                cell.thirdSecondLabel.text = self.model.Bending_value;
                cell.thirdThirdLabel.text = self.model.Bending_refinterVal;
            }
        
    }
    return cell;
    
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


@end
