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
{
    BOOL firstSecondFlag;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self bulidHomePageNav];
    [self bulidTopLabel];
    [self bulidImgView];
    [self startRequest];

}



-(UIImage*)selectedWithSection:(NSUInteger)section
{
    UIImage *img = nil;
    switch (section) {
        case 0:
        {
            if(firstSecondFlag)
            {
                img = [UIImage imageNamed:@"top"];
            }
            else
            {
                img = [UIImage imageNamed:@"bottom"];
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
        UIImageView *imgT = (UIImageView *)[self.view viewWithTag:100];
        imgT.image = [self selectedWithSection:0];
    }

    
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
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 44+NAVIGATIONHEIGHT, ScreenWidth, 36)];
    imageView.image = [UIImage imageNamed:@"shenti"];
    [self.view addSubview:imageView];

    
    
    
    
    UIView *headViewT = [[UIView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(imageView.frame), ScreenWidth, 56)];
    headViewT.backgroundColor = [UIColor whiteColor];
    
    firstSecondFlag = YES;
    
    UIImageView *pointImgView  = [[UIImageView alloc]initWithFrame:CGRectMake(10, (56-18)/2, 18, 18)];
    pointImgView.image = [UIImage imageNamed:@"point"];
    [headViewT addSubview:pointImgView];
    
    UILabel *nameLab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(pointImgView.frame)+5, (56-18)/2, 180, 18)];
    nameLab.text = @"身体成分";
    nameLab.backgroundColor = [UIColor clearColor];
    nameLab.textAlignment = NSTextAlignmentLeft;
    [headViewT addSubview:nameLab];
    
    UIImageView *line = [[UIImageView alloc]initWithFrame:CGRectMake(0, 46, ScreenWidth, 10)];
    line.image = [UIImage imageNamed:@"line.gif"];
    [headViewT addSubview:line];
    
    UIImageView *indicatorImgView = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth - 16 - 20, (56-36)/2, 16, 36)];
    
    
    indicatorImgView.image = [self selectedWithSection:0];
    indicatorImgView.tag = 100;
    [headViewT addSubview:indicatorImgView];
    
    
    UIButton *clickButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    clickButton.frame = CGRectMake(0, 0, ScreenWidth, 36);
    clickButton.tag = 10;
    clickButton.backgroundColor = [UIColor clearColor];
    
    [clickButton addTarget:self action:@selector(clickButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [headViewT addSubview:clickButton];
    [self.view addSubview:headViewT];
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
