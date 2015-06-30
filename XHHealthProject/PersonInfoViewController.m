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
#import "IBActionSheet.h"


@interface PersonInfoViewController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
    PersonInfoSingleTon *personSingleTon;
    UIImage *_headImageView;
}

@property(nonatomic,strong)XHNavigationView *navView;
@property(nonatomic,strong)UITableView *infoTableView;
@property(nonatomic,strong)UIView *bgView;
//@property(nonatomic,strong)IBActionSheet *ibSheet;

@end

@implementation PersonInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    personSingleTon = [PersonInfoSingleTon personInfoShareInstance];
    
    
    /*
     读取沙盒中的图片 用dataWithContentsOfURL 或者imageWithContentsOfFile 结果为nil，
     必须使用 nsfileManager 方法去实现
     */
    NSURL *docsUrl = [[[NSFileManager defaultManager]URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask]lastObject];
    NSString *resultStr = [[docsUrl path]stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",@"headImage"]];
    UIImage *imgs = [UIImage imageWithContentsOfFile:resultStr];
    if (imgs != nil) {
        _headImageView = imgs;
    }else{
        _headImageView = nil;
    }

    
    [self bulidHomePageNav];
    [self bulidTable];
    // Do any additional setup after loading the view.
}
#if __IPHONE_OS_VERSION_MAX_ALLOWED < __IPHONE_8_0

- (void)showAlertWithMessage:(NSString *)message{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alert show];
}
#else
-(void)showAlertWithMessage:(NSString *)message
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        
    }];
    [alertController addAction:okAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
    
}

#endif
- (void)loadSourceWithType:(UIImagePickerControllerSourceType)sourceType{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = sourceType;
    //设置代理
    picker.delegate = self;
    picker.allowsEditing = YES;
    [self presentViewController:picker animated:YES completion:nil];
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
    self.infoTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64) style:UITableViewStylePlain];
    self.infoTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.infoTableView.delegate = self;
    self.infoTableView.dataSource = self;
    //self.infoTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.infoTableView];
    self.infoTableView.tableFooterView = [[UIView alloc] init];
    
    UIButton *bottomButton = [UIButton buttonWithType:UIButtonTypeCustom];
    bottomButton.frame = CGRectMake(0, self.view.frame.size.height - 40, self.view.frame.size.width, 40);
    [bottomButton setTitle:@"注销登录" forState:UIControlStateNormal];
    [bottomButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    bottomButton.backgroundColor = [UIColor colorWithRed:211/255.0 green:211/255.0 blue:211/255.0 alpha:1];
    
    bottomButton.titleLabel.font = [UIFont systemFontOfSize:15];
    //bottomButton.backgroundColor = [UIColor grayColor];
    [bottomButton addTarget:self action:@selector(bottomButtonClick) forControlEvents:UIControlEventTouchUpInside];
    //self.infoTableView.tableFooterView = bottomButton;
    [self.view addSubview:bottomButton];
    
    
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
    if(indexPath.section == 0)
    {
        [self creatBottomView];
    }
}


//创建底部视图，供选择照片途径使用
- (void)creatBottomView{
    
    /**
     * 修改自定义图像 2015-1-22 周四 16:41 赵英超
     */
    
    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"从相册选择", nil];
    [sheet showInView:self.view];
    
    
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==0) {
        //先判断资源是否可用
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            [self loadSourceWithType:UIImagePickerControllerSourceTypeCamera];
        }else{
            [self showAlertWithMessage:@"相机不可用"];
        }
    }else if (buttonIndex==1){
        //先判断资源是否可用
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            [self loadSourceWithType:UIImagePickerControllerSourceTypePhotoLibrary];
        }else{
            [self showAlertWithMessage:@"无法调用相册库"];
        }
    }
}

-(void)willPresentActionSheet:(UIActionSheet *)actionSheet
{
    for(id actionId in actionSheet.subviews)
    {
        if([actionId isMemberOfClass:[UIButton class]])
        {
            [((UIButton *)actionId) setTitleColor:[UIColor colorWithHexString:@"#7eb26c"] forState:UIControlStateNormal];
        }
    }
    
}




//-(void)creatBottomView
//{
//    
//    self.ibSheet = [[IBActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"从相册选择", nil];
//    [self.ibSheet setButtonTextColor:[UIColor colorWithHexString:@"#7eb26c"]];
//    AppDelegate *app = [UIApplication sharedApplication].delegate;
//    [self.ibSheet showInView:app.window];
//}



//-(void)actionSheet:(IBActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    switch (buttonIndex)
//    {
//        case 0:
//        {
//            if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
//            {
//                [self loadSourceWithType:UIImagePickerControllerSourceTypeCamera];
//            }else{
//                [self showAlertWithMessage:@"相机不可用"];
//            }
//            
//            break;
//        }
//        case 1:
//        {
//            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
//                [self loadSourceWithType:UIImagePickerControllerSourceTypePhotoLibrary];
//            }else{
//                [self showAlertWithMessage:@"无法调用相册库"];
//            }
//            
//            break;
//            
//        }
//        default:
//            break;
//    }
//    
//}




//点击cancel按钮时，触发此方法
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];}
//选中图片资源时(choose)，会触发此方法
//info 中带有选中资源的信息
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    //先判断资源是否为图片资源(可能是video)
    //获取选中资源的类型
    
        UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
        self.view.backgroundColor = [UIColor colorWithPatternImage:image];
        
        NSString *docDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
        
        NSString *path = [docDir stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",@"headImage"]];
        
        NSData *imageData = UIImagePNGRepresentation(image);
        [imageData writeToFile:path atomically:YES];
        _headImageView = image;
        

    [picker dismissViewControllerAnimated:YES completion:^{

        [self.infoTableView reloadData];
    }];
    
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
        return (self.view.frame.size.height - 64 - 40 - 80 - 40 - 30) / 7;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
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
        if(_headImageView != nil)
        {
            cell.headerImageView.image = _headImageView;
        }
        cell.headerImageView.layer.cornerRadius = 28.f;
        cell.headerImageView.layer.masksToBounds = YES;

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
