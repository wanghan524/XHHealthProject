//
//  HomePageVC.m
//  XHHealthProject
//
//  Created by 菁优数学 on 15/6/14.
//  Copyright (c) 2015年 AlexYang. All rights reserved.
//

#import "HomePageVC.h"
#import "XHNavigationView.h"
#import "LoginVC.h"
#import "PersonInfoVC.h"
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
#import "SelfCheckVC.h"
@interface HomePageVC ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong)XHNavigationView *navView;
@property(nonatomic,strong)UIImageView *middleImgView;
@property(nonatomic,strong)UIButton *selfCheckBtn;
@property(nonatomic,strong)UITextField *cardTextField;
@property(nonatomic,strong)UIButton *searchBtn;
@property(nonatomic,strong)UILabel *bottomLab;

@property(nonatomic,strong)NSMutableArray *btnNameArray;
@property(nonatomic,strong)NSMutableArray *imgNameArray;
@property(nonatomic,strong)UICollectionView *collection;


@end

@implementation HomePageVC
{
    CGFloat perWidth;
    CGFloat perHeight;
    CGFloat perWidthT;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBgColor];
    

    
    [self bulidHomePageNav];
    [self buildMiddleImg];
    [self buildCheckView];
    [self setBtnNameBtn];
    [self buildsearchView];
    [self calculationPerWidthOrHeight];
    [self buildCollection];
//    [self buildNineBtn];
    [self buildBottom];
}


-(void)buildCollection
{
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.itemSize = CGSizeMake(perWidthT, perWidthT);
    flowLayout.minimumLineSpacing = 1.f;
    flowLayout.minimumInteritemSpacing = 0.f;
    
    self.collection = [[UICollectionView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(self.middleImgView.frame)+20, ScreenWidth, ScreenHeight - (CGRectGetMaxY(self.middleImgView.frame) + 50)) collectionViewLayout:flowLayout];
    self.collection.backgroundColor = [UIColor lightGrayColor];
    self.collection.dataSource = self;
    self.collection.delegate = self;
    [self.view addSubview:self.collection];
    
    [self.collection registerNib:[UINib nibWithNibName:@"ButtonCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"ButtonCollectionCell"];
    
    
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ButtonCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ButtonCollectionCell" forIndexPath:indexPath];
    if(!cell)
    {
        cell = [[ButtonCollectionCell alloc]init];
    }
    cell.backgroundColor = [UIColor whiteColor];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *imgName;
    if([user valueForKey:@"UserName"] != nil){
        if(indexPath.row == 7)
        {
            imgName = [NSString stringWithFormat:@"%d.gif",indexPath.row+1];
        }
        else
        {imgName = [NSString stringWithFormat:@"%d.png",indexPath.row+1];}
    }else
    {
        if(indexPath.row == 7)
        {
            imgName = [NSString stringWithFormat:@"%d.gif",indexPath.row + 1];
        }else{
            imgName = [NSString stringWithFormat:@"%d_no.png",indexPath.row+1];}
    }
    
    cell.buttonImg.image = [UIImage imageNamed:imgName];
    cell.buttonLab.text = self.btnNameArray[indexPath.row];
    return cell;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(perWidthT, perWidthT);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(1, 0, 1, 0);
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 9;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    

    
    
    switch (indexPath.item) {
        case 0:
        {
            SurveyInfoVC *infoVC = [[SurveyInfoVC alloc] init];
            [self.navigationController pushViewController:infoVC animated:YES];
        }
            break;
        case 1:
        {
            
            BodyCheckVC *check = [[BodyCheckVC alloc]init];
            [self.navigationController pushViewController:check animated:YES];
            break;
        }
        case 2:
        {
            BodyCompositionVC *composition = [[BodyCompositionVC alloc]init];
            [self.navigationController pushViewController:composition animated:YES];
            break;
        }
        case 3:
        {
            PressAndEcg *composition = [[PressAndEcg alloc]init];
            [self.navigationController pushViewController:composition animated:YES];
            
            break;
        }
        case 4:
        {
            GardiacAndPulmonary *composition = [[GardiacAndPulmonary alloc]init];
            [self.navigationController pushViewController:composition animated:YES];
            
            break;
        }
        case 5:
        {
            BMDViewController *composition = [[BMDViewController alloc]init];
            [self.navigationController pushViewController:composition animated:YES];
            
            break;
        }
        case 6:
        {
            EyeFundusExamVC *exam = [[EyeFundusExamVC alloc]init];
            [self.navigationController pushViewController:exam animated:YES];
            break;
        }
        case 7:
        {
            RoutineBloodAndBloodViewController *composition = [[RoutineBloodAndBloodViewController alloc]init];
            [self.navigationController pushViewController:composition animated:YES];
            
            break;
        }
        case 8:
        {
            BiochemistryAndImmunityVC *biochemistryVC = [[BiochemistryAndImmunityVC alloc]init];
            [self.navigationController pushViewController:biochemistryVC animated:YES];
            break;
        }
            
        default:
            break;
    }

}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    if([user valueForKey:@"UserName"] != nil){
        return YES;
    }else{
        return NO;
    }
}



-(void)setBtnNameBtn
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


-(void)buildBottom
{
    self.bottomLab = [[UILabel alloc]initWithFrame:CGRectMake(0, ScreenHeight - 30, ScreenWidth-10, 30)];
    self.bottomLab.backgroundColor = [UIColor clearColor];
    self.bottomLab.text = @"备注:身份证信息不对?请致电69156476";
    self.bottomLab.textAlignment = NSTextAlignmentRight;
    self.bottomLab.font = [UIFont systemFontOfSize:13];
    
    [self.view addSubview:self.bottomLab];
}



-(void)calculationPerWidthOrHeight
{
    perWidth = (ScreenWidth - 2)/3;
    perHeight = (ScreenHeight - CGRectGetMaxY(self.middleImgView.frame) - 60-2)/3;

}








-(void)setBgColor
{
    perWidthT = (ScreenWidth-2)/3.f;
    [self.view setBackgroundColor:COLOR(245, 245, 245, 1)];
}

-(void)buildsearchView
{
    self.cardTextField = [[UITextField alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(self.selfCheckBtn.frame)+15, ScreenWidth - 120, 40)];
    self.cardTextField.backgroundColor = [UIColor whiteColor];
    self.cardTextField.placeholder = @"  请输入身份证号码";
    self.cardTextField.keyboardType = UIKeyboardTypeNamePhonePad;
    self.cardTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.cardTextField.textColor = [UIColor lightGrayColor];
    [self.view addSubview:self.cardTextField];
    
    
    self.searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.searchBtn setFrame:CGRectMake(CGRectGetMaxX(self.cardTextField.frame)-5, CGRectGetMinY(self.cardTextField.frame),ScreenWidth-CGRectGetMaxX(self.cardTextField.frame)-20, 40)];
    self.searchBtn.backgroundColor = NAVColor;
    [self.searchBtn setTitle:@"查询" forState:UIControlStateNormal];
    [self.view addSubview:self.searchBtn];
}

-(void)buildCheckView
{
    self.selfCheckBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.selfCheckBtn.backgroundColor = [UIColor clearColor];
    [self.selfCheckBtn setFrame:CGRectMake(ScreenWidth - 140, 64, 60, 80)];
    [self.selfCheckBtn setImage:[UIImage imageNamed:@"self"] forState:UIControlStateNormal];
    [self.selfCheckBtn addTarget:self action:@selector(selfCheckBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.selfCheckBtn];
    
}

-(void)selfCheckBtnClick:(UIButton *)btn
{
    SelfCheckVC *vc = [[SelfCheckVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}



-(void)buildMiddleImg
{
    self.middleImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, 150)];
    self.middleImgView.image = [UIImage imageNamed:@"searchbg.jpg"];
    self.middleImgView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.middleImgView];
}


-(void)bulidHomePageNav
{
    
    self.navView = [[XHNavigationView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth,64)];
    [self.navView layoutXHNavWithType:Type_LoginNav];
    self.navView.backgroundColor = NAVColor;
    [self.navView.btn_login setImage:[UIImage imageNamed:@"head"] forState:UIControlStateNormal];
   
    
    self.navView.lbl_login_middle.text = @"协和健康管理";
    [self.navView.btn_login addTarget:self action:@selector(loginBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.navView];
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
    [self.collection reloadData];

    
}

-(void)loginBtn:(UIButton *)sender
{
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    if ([user valueForKey:@"UserName"] == nil) {
        LoginVC *vc = [[LoginVC alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}  

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}


@end
