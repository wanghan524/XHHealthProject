//
//  LeftMenuVC.m
//  XHHealthProject
//
//  Created by 菁优数学 on 15/6/14.
//  Copyright (c) 2015年 AlexYang. All rights reserved.
//

#import "LeftMenuVC.h"
#import "MenuCell.h"
@interface LeftMenuVC ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *menuTableView;
@property(nonatomic,strong)NSMutableArray *btnNameArray;


@end

@implementation LeftMenuVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadImgStr];
    [self buildMenuTable];
   
}


#pragma mark tableviewDelegate


-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section
{
    return 80.f;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    static NSString *head = @"HEADS";
    UITableViewHeaderFooterView *headView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:head];
    if(headView == nil)
    {
        headView = [[UITableViewHeaderFooterView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 80)];
    }
    headView.textLabel.text = @"请登录 》";
    
    
    return headView;
}


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

        NSString *str = [NSString stringWithFormat:@"menu_unclick_%d",indexPath.row+1];
        cell.img.image = [UIImage imageNamed:str];
    }

    return cell;
    
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
    
    self.menuTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStyleGrouped];
    self.menuTableView.delegate = self;
    self.menuTableView.dataSource = self;
    self.menuTableView.separatorInset = UIEdgeInsetsZero;


    [self.view addSubview:self.menuTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

@end
