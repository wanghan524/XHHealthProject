//
//  BodyCompositionVC.m
//  XHHealthProject
//
//  Created by 菁优数学 on 15/6/22.
//  Copyright (c) 2015年 AlexYang. All rights reserved.
//

#import "BodyCompositionVC.h"
#import "XHNavigationView.h"
#import "ThirdInfoCell.h"
#import "WSRequestManager.h"
#import "XHHealthRequest.h"
#import "FitNessModel.h"
#import "UIImageView+WebCache.h"


@interface BodyCompositionVC ()
@property(nonatomic,strong)XHNavigationView *navView;
@property(nonatomic,strong)UIImageView *imgView;

@end




@implementation BodyCompositionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self bulidHomePageNav];
    [self bulidTopLabel];
    [self bulidImgView];
    [self startRequest];

}


-(void)startRequest
{
    [WSRequestManager XHGetRequestParameters:@{@"_IDNumber":CARD} withMethodName:BODYCOM SuccessRequest:^(id data) {
        NSArray *resultArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        
        if([resultArray count] > 0)
        {
            NSDictionary *resultDic = resultArray[0];
            NSArray *keyArr = [resultDic allKeys];
            if([keyArr containsObject:@"BodyComUrl"])
            {
                if([resultDic objectForKey:@"BodyComUrl"])
                {
                    if(self.imgView)
                    {
                        NSString *urlStr =  [resultDic objectForKey:@"BodyComUrl"];
                        urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                        NSURL *url = [[NSURL alloc]initWithString:urlStr];
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [self.imgView setImageWithURL:url];
                        });
                    }
                    
                }
            }
        }
        
    } FailRequest:^(id data, NSError *error) {
        
    }];
    
    
}

-(void)bulidTopLabel
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, CGRectGetMaxY(self.navView.frame), ScreenWidth, 30) ;
    [btn setTitle:@"身体成分" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    btn.backgroundColor = [UIColor whiteColor];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
   
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    btn.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    
    [self.view addSubview:btn];
}



-(void)bulidImgView
{
    self.imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0,((ScreenHeight-94)/2 - (ScreenHeight - 94)*0.8/2.0) + 94, ScreenWidth, (ScreenHeight - 94)*0.8)];
//    self.imgView.center = self.view.center;
    [self.view addSubview:self.imgView];

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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}
@end
