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

#import "AppDelegate.h"
#import "HomePageVC.h"

@interface BodyCheckVC ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)XHNavigationView *navView;
@property(nonatomic,strong)UITableView *infoTableView;

@property(nonatomic,strong)NSMutableArray *orderMuArr;
@property(nonatomic,strong)FitNessModel *model;

@end

@implementation BodyCheckVC
{
    BOOL firstSecondFlag;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self bulidHomePageNav];
    [self bulidOrderMuArr];
    [self bulidTable];
    [self startRequest];
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


-(void)startRequest
{
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    NSString *numberString = [user stringForKey:@"IdNumber"];
    [WSRequestManager XHGetRequestParameters:@{@"_IDNumber":numberString} withMethodName:FITNESS SuccessRequest:^(id data) {
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
    [self.orderMuArr addObject:@{@"TitleTTT":@"检测指标"}];
    [self.orderMuArr addObject:@{@"Jump_cn":@"纵跳最大值(cm)"}];
    [self.orderMuArr addObject:@{@"Grip_cn":@"握力最大值(kg)"}];
    [self.orderMuArr addObject:@{@"Bending_cn":@"坐位体前屈最大值(cm)"}];
    
}

-(void)bulidTable
{
    self.infoTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 70, ScreenWidth, ScreenHeight - 64) style:UITableViewStylePlain];
    self.infoTableView.delegate = self;
    self.infoTableView.dataSource = self;
    self.infoTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.infoTableView];
    
    firstSecondFlag = YES;
    
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 36)];
    imageView.image = [UIImage imageNamed:@"tizhi"];
    self.infoTableView.tableHeaderView = imageView;

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
    if (section == 0) {
        
        return self.orderMuArr.count;
       
        
    }
    return 0;

}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headViewT = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 56)];
    headViewT.backgroundColor = [UIColor whiteColor];
    
    
    
    UIImageView *pointImgView  = [[UIImageView alloc]initWithFrame:CGRectMake(10, (56-18)/2, 18, 18)];
    pointImgView.image = [UIImage imageNamed:@"point"];
    [headViewT addSubview:pointImgView];
    
    UILabel *nameLab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(pointImgView.frame)+5, (56-18)/2, 180, 18)];
    nameLab.text = @"体质检查";
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


- (void)clickButtonClick:(UIButton *)bpt{
    
    if (bpt.tag == 10) {
        firstSecondFlag = !firstSecondFlag;
        
        
        
    }
    [self.infoTableView reloadData];
    //[self requestDataWithIndex:bpt.tag];
    NSLog(@"tag : %ld",bpt.tag);
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 56.f;
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
        if(indexPath.row == 0)
        {
            cell.thirdFierstLabel.text = @"检测指标";
            cell.thirdSecondLabel.text = @"检测值";
            cell.thirdThirdLabel.text = @"参考值范围";
            cell.backgroundColor = [UIColor colorWithHexString:@"EAEAEA"];
            return cell;
        }
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
    [self.navView layoutXHNavWithType:Type_RightBtn];
    self.navView.backgroundColor = NAVColor;
    [self.navView.btn_login setImage:[UIImage imageNamed:@"head"] forState:UIControlStateNormal];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    if ([user valueForKey:@"UserName"] != nil) {
        self.navView.lbl_login.text = [user valueForKey:@"UserName"];
    }else{
        self.navView.lbl_login.text = @"登录";
    }
    self.navView.lbl_login_middle.text = @"体制检查";
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

@end
