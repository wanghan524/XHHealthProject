//
//  LeftMenuVC.m
//  XHHealthProject
//
//  Created by 菁优数学 on 15/6/14.
//  Copyright (c) 2015年 AlexYang. All rights reserved.
//

#import "LeftMenuVC.h"
#import "MenuCell.h"
#import "HeadView.h"
#import "AppDelegate.h"
#import "PersonInfoViewController.h"

#import "BodyCheckVC.h"
#import "BodyCompositionVC.h"
#import "SurveyInfoVC.h"
#import "PressAndEcg.h"
#import "GardiacAndPulmonary.h"
#import "BMDViewController.h"
#import "RoutineBloodAndBloodViewController.h"
#import "BiochemistryAndImmunityVC.h"
#import "EyeFundusExamVC.h"
#import "ButtonCollectionCell.h"


#import "LoginVC.h"
@interface LeftMenuVC ()<UITableViewDataSource,UITableViewDelegate,headerImageClickDelegate>
@property(nonatomic,strong)UITableView *menuTableView;
@property(nonatomic,strong)NSMutableArray *btnNameArray;
@property(nonatomic,strong)HeadView *head;


@end

@implementation LeftMenuVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadImgStr];
    [self buildHeadView];
    [self buildMenuTable];
    
   
}
-(void)headButtonClick:(UIButton *)btn
{
    
}
-(void)buildHeadView
{
    self.head  = [[HeadView alloc]initWithFrame:CGRectMake(0, 20, 200, 135   )];
    self.head.delegate = self;
    self.head.headImgView.image = [UIImage imageNamed:@"nologin"];
    
    
    
    //self.head.name.text = @"请登录";
    self.head.indicatorImgView.image = [UIImage imageNamed:@"more"];
    CGRect orgin = self.head.name.frame;
    self.head.name.frame = CGRectMake(orgin.origin.x, orgin.origin.y+10, orgin.size.width, orgin.size.height);
    [self.head.button addTarget:self action:@selector(headButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.head];
    
}

- (void)viewWillAppear:(BOOL)animated{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    if ([user valueForKey:@"UserName"] != nil) {
        self.head.name.text = [user valueForKey:@"UserName"];
        
        NSURL *docsUrl = [[[NSFileManager defaultManager]URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask]lastObject];
        NSString *resultStr = [[docsUrl path]stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",@"headImage"]];
        UIImage *imgs = [UIImage imageWithContentsOfFile:resultStr];
        if (imgs != nil) {
            self.head.headImgView.image = imgs;
        }else{
            self.head.headImgView.image = [UIImage imageNamed:@"nologin"];
        }

        self.head.headImgView.layer.cornerRadius = 35.f;
        self.head.headImgView.layer.masksToBounds  = YES;
    }else{
        self.head.name.text = @"请登录";
    }
}


- (void)headerImageViewClick{
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    if ([user valueForKey:@"IdNumber"] != nil) {
        PersonInfoViewController *composition = [[PersonInfoViewController alloc]init];
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:composition];
        AppDelegate *delegate = [UIApplication sharedApplication].delegate;
        [delegate.draw closeDrawerAnimated:NO completion:nil];
        delegate.draw.centerViewController = nav;
    }
    
    else{
        LoginVC *vc = [[LoginVC alloc]init];
        vc.flagString = @"left";
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        AppDelegate *delegate = [UIApplication sharedApplication].delegate;
        [delegate.draw closeDrawerAnimated:NO completion:nil];
        delegate.draw.centerViewController = nav;
        
    }
    
    
    //[self presentViewController:composition animated:YES completion:nil];
}

#pragma mark tableviewDelegate


//-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section
//{
//    return 80.f;
//}
//-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    static NSString *head = @"HEADS";
//    UITableViewHeaderFooterView *headView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:head];
//    if(headView == nil)
//    {
//        headView = [[UITableViewHeaderFooterView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 80)];
//    }
//    headView.textLabel.text = @"请登录 》";
//    
//    
//    return headView;
//}
//

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.btnNameArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *iden = @"MENU";
    MenuCell *cell = [tableView dequeueReusableCellWithIdentifier:iden];
    if(nil == cell)
    {
        cell = [[MenuCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iden];
    }
    
    if([self.btnNameArray count] > 0)
    {
        cell.lab.text = self.btnNameArray[indexPath.row];

        NSString *str = [NSString stringWithFormat:@"menu_unclick_%ld",indexPath.row+1];
        cell.img.image = [UIImage imageNamed:str];
    }

    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
        {
            
            SurveyInfoVC *composition = [[SurveyInfoVC alloc]init];
            composition.flagString = @"now";
            UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:composition];
            AppDelegate *delegate = [UIApplication sharedApplication].delegate;
            [delegate.draw closeDrawerAnimated:YES completion:nil];
            delegate.draw.centerViewController = nav;
            
//            SurveyInfoVC *infoVC = [[SurveyInfoVC alloc] init];
//            [self.navigationController pushViewController:infoVC animated:YES];
        }
            break;
        case 1:
        {
            BodyCheckVC *composition = [[BodyCheckVC alloc]init];
            composition.flagString = @"now";
            UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:composition];
            AppDelegate *delegate = [UIApplication sharedApplication].delegate;
            [delegate.draw closeDrawerAnimated:YES completion:nil];
            delegate.draw.centerViewController = nav;
            
//            BodyCheckVC *check = [[BodyCheckVC alloc]init];
//            [self.navigationController pushViewController:check animated:YES];
            break;
        }
        case 2:
        {
            
            BodyCompositionVC *composition = [[BodyCompositionVC alloc]init];
            composition.flagString = @"now";
            UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:composition];
            AppDelegate *delegate = [UIApplication sharedApplication].delegate;
            [delegate.draw closeDrawerAnimated:YES completion:nil];
            delegate.draw.centerViewController = nav;
//            BodyCompositionVC *composition = [[BodyCompositionVC alloc]init];
//            [self.navigationController pushViewController:composition animated:YES];
            break;
        }
        case 3:
        {
            
            PressAndEcg *composition = [[PressAndEcg alloc]init];
            composition.flagString = @"now";
            UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:composition];
            AppDelegate *delegate = [UIApplication sharedApplication].delegate;
            [delegate.draw closeDrawerAnimated:YES completion:nil];
            delegate.draw.centerViewController = nav;
            
//            PressAndEcg *composition = [[PressAndEcg alloc]init];
//            [self.navigationController pushViewController:composition animated:YES];
            
            break;
        }
        case 4:
        {
            
            GardiacAndPulmonary *composition = [[GardiacAndPulmonary alloc]init];
            composition.flagString = @"now";
            UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:composition];
            AppDelegate *delegate = [UIApplication sharedApplication].delegate;
            [delegate.draw closeDrawerAnimated:YES completion:nil];
            delegate.draw.centerViewController = nav;
            
//            GardiacAndPulmonary *composition = [[GardiacAndPulmonary alloc]init];
//            [self.navigationController pushViewController:composition animated:YES];
            
            break;
        }
        case 5:
        {
            
            BMDViewController *composition = [[BMDViewController alloc]init];
            composition.flagString = @"now";
            UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:composition];
            AppDelegate *delegate = [UIApplication sharedApplication].delegate;
            [delegate.draw closeDrawerAnimated:YES completion:nil];
            delegate.draw.centerViewController = nav;
            
//            BMDViewController *composition = [[BMDViewController alloc]init];
//            [self.navigationController pushViewController:composition animated:YES];
            
            break;
        }
        case 6:
        {
            
            EyeFundusExamVC *composition = [[EyeFundusExamVC alloc]init];
            composition.flagString = @"now";
            UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:composition];
            AppDelegate *delegate = [UIApplication sharedApplication].delegate;
            [delegate.draw closeDrawerAnimated:YES completion:nil];
            delegate.draw.centerViewController = nav;
            
//            EyeFundusExamVC *exam = [[EyeFundusExamVC alloc]init];
//            [self.navigationController pushViewController:exam animated:YES];
            break;
        }
        case 7:
        {
            
            RoutineBloodAndBloodViewController *composition = [[RoutineBloodAndBloodViewController alloc]init];
            composition.flagString = @"now";
            UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:composition];
            AppDelegate *delegate = [UIApplication sharedApplication].delegate;
            [delegate.draw closeDrawerAnimated:YES completion:nil];
            delegate.draw.centerViewController = nav;
            
//            RoutineBloodAndBloodViewController *composition = [[RoutineBloodAndBloodViewController alloc]init];
//            [self.navigationController pushViewController:composition animated:YES];
            
            break;
        }
        case 8:
        {
            
            BiochemistryAndImmunityVC *composition = [[BiochemistryAndImmunityVC alloc]init];
            composition.flagString = @"now";
            UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:composition];
            AppDelegate *delegate = [UIApplication sharedApplication].delegate;
            [delegate.draw closeDrawerAnimated:YES completion:nil];
            delegate.draw.centerViewController = nav;
            
//            BiochemistryAndImmunityVC *biochemistryVC = [[BiochemistryAndImmunityVC alloc]init];
//            [self.navigationController pushViewController:biochemistryVC animated:YES];
            break;
        }
            
        default:
            break;
    }
}

#pragma mark tableviewDelegate




-(void)loadImgStr
{
    self.btnNameArray = [[NSMutableArray alloc]initWithCapacity:0];
    [self.btnNameArray addObject:@"问卷信息"];
    [self.btnNameArray addObject:@"体制检查"];
    [self.btnNameArray addObject:@"身体成分"];
    [self.btnNameArray addObject:@"血压和心电"];
    [self.btnNameArray addObject:@"心肺功能"];
    [self.btnNameArray addObject:@"骨密度"];
    [self.btnNameArray addObject:@"眼科检查"];
    [self.btnNameArray addObject:@"血常规/血型"];
    [self.btnNameArray addObject:@"血生化和免疫"];

}



-(void)buildMenuTable
{
    if(CD(7))
    {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    self.menuTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.head.frame)+5, ScreenWidth, ScreenHeight - 5 - CGRectGetMaxY(self.head.frame)) style:UITableViewStylePlain];
    self.menuTableView.delegate = self;
    self.menuTableView.dataSource = self;
    self.menuTableView.separatorInset = UIEdgeInsetsZero;
    self.menuTableView.tableFooterView = [[UIView alloc] init];



    [self.view addSubview:self.menuTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

@end
