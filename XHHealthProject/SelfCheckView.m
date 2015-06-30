//
//  SelfCheckView.m
//  XHHealthProject
//
//  Created by 菁优数学 on 15/7/1.
//  Copyright (c) 2015年 AlexYang. All rights reserved.
//

#import "SelfCheckView.h"

@interface SelfCheckView ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,assign)CGRect originFrame;

@property(nonatomic,strong)UITableView *middleTable;

@property(nonatomic,strong)NSArray *array;

@end


@implementation SelfCheckView

-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        
    }
    return self;
}
-(void)makeMidTableView:(CGRect)rect withArray:(NSArray *)dataArr
{
    self.originFrame = rect;
    self.array = dataArr;
    [self makeAllMaskView];

}

-(void)tap:(UITapGestureRecognizer*)tap
{
    [self removeFromSuperview];
}

-(void)makeAllMaskView
{
    
    self.maskView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    self.maskView.backgroundColor = [UIColor grayColor];
    self.maskView.alpha  = 0.7;
    [self addSubview:self.maskView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    tap.numberOfTapsRequired = 1;
    [self addGestureRecognizer:tap];
    
    self.middleTable = [[UITableView alloc]initWithFrame:self.originFrame style:UITableViewStylePlain];
    self.middleTable.delegate = self;
    self.middleTable.dataSource = self;
    [self addSubview:self.middleTable];
    self.middleTable.center = self.maskView.center;

    
    
    
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.array.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *iden = @"iden";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:iden];
    if(!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iden];
    }
    if([self.array count] > 0)
    {
        NSDictionary *dic = self.array[0];
        NSArray *arr = [dic objectForKey:@"Items"];
        NSDictionary *tmpDic = arr[0];
        cell.textLabel.text = [tmpDic objectForKey:@"Item_cn"];
        
    }
    
    return cell;
}


@end
