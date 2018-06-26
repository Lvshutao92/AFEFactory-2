//
//  UserTableViewController.m
//  DXRacerSupplierAFE
//
//  Created by ilovedxracer on 2017/12/26.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "UserTableViewController.h"
#import "WaiTableViewCell.h"
@interface UserTableViewController ()<UITextFieldDelegate>
@property(nonatomic,strong)NSMutableArray *arr;
@property(nonatomic,strong)NSMutableArray *imgarr;

@property(nonatomic,strong)NSMutableArray *arr1;
@property(nonatomic,strong)NSMutableArray *imgarr1;
@end

@implementation UserTableViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"账号管理";
    
    
    self.arr = [@[@"修改密码"]mutableCopy];
    self.imgarr = [@[@"修改密码"]mutableCopy];
    
    self.arr1 = [@[@"退出登录"]mutableCopy];
    self.imgarr1 = [@[@"退出登录"]mutableCopy];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"WaiTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    UIView *vie = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    self.tableView.tableFooterView = vie;
    self.tableView.backgroundColor = RGBACOLOR(235, 239, 241, 1);
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    view.frame = CGRectMake(0, 0, SCREEN_WIDTH, 15);
    view.backgroundColor = RGBACOLOR(235, 239, 241, 1);
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15;
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.arr.count;
    }
    return self.arr1.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WaiTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.img.contentMode = UIViewContentModeScaleAspectFit;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    
    if (indexPath.section == 0) {
        cell.lab.text = self.arr[indexPath.row];
        cell.img.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",self.imgarr[indexPath.row]]];
        return cell;
    }
    
    cell.lab.text = self.arr1[indexPath.row];
    cell.img.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",self.imgarr1[indexPath.row]]];
    return cell;
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WaiTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell.lab.text isEqualToString:@"修改密码"]) {
        
        YBAlertView *alertView = [[YBAlertView alloc] initWithFrame:CGRectMake(50, 150, kScreenW-100, 220)];
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, alertView.width, 30)];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.text = @"修改密码";
        titleLabel.font = [UIFont systemFontOfSize:20];
        [alertView addSubview:titleLabel];
        
        UITextField *passwordTF = [[UITextField alloc] initWithFrame:CGRectMake(16, CGRectGetMaxY(titleLabel.frame) + 20, alertView.width-32, 40)];
        passwordTF.tag = 100;
        passwordTF.borderStyle = UITextBorderStyleRoundedRect;
        passwordTF.layer.borderWidth = 1;
        passwordTF.placeholder = @"新密码";
        
        passwordTF.delegate = self;
        [passwordTF resignFirstResponder];
        
        
        passwordTF.layer.borderColor = [UIColor colorWithWhite:.8 alpha:.5].CGColor;
        passwordTF.layer.cornerRadius = 5;
        [alertView addSubview:passwordTF];
        
        
        UITextField *passwordTF1 = [[UITextField alloc] initWithFrame:CGRectMake(16, CGRectGetMaxY(titleLabel.frame) + 70, alertView.width-32, 40)];
        passwordTF1.tag = 101;
        passwordTF1.borderStyle = UITextBorderStyleRoundedRect;
        passwordTF1.layer.borderWidth = 1;
        passwordTF1.placeholder = @"重复密码";
        passwordTF1.delegate = self;
        passwordTF1.layer.borderColor = [UIColor colorWithWhite:.8 alpha:.5].CGColor;
        passwordTF1.layer.cornerRadius = 5;
        [alertView addSubview:passwordTF1];
        
        
        
        UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        cancelBtn.frame = CGRectMake(16, CGRectGetMaxY(passwordTF.frame) + 70, passwordTF.width/2, 40);
        [cancelBtn addTarget:self action:@selector(cancelClick:) forControlEvents:UIControlEventTouchUpInside];
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        cancelBtn.titleLabel.font = [UIFont systemFontOfSize:18];
        [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [alertView addSubview:cancelBtn];
        
        UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        confirmBtn.frame = CGRectMake(CGRectGetMaxX(cancelBtn.frame), CGRectGetMaxY(passwordTF.frame) + 70, passwordTF.width/2, 40);
        [confirmBtn addTarget:self action:@selector(confirmClick:) forControlEvents:UIControlEventTouchUpInside];
        [confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
        confirmBtn.titleLabel.font = [UIFont systemFontOfSize:18];
        [confirmBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [alertView addSubview:confirmBtn];
        
        [alertView show];
    }
    if ([cell.lab.text isEqualToString:@"退出登录"]) {
        LoginViewController *login = [[LoginViewController alloc]init];
        login.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:login animated:YES completion:nil];
    }
}







- (void)cancelClick:(UIButton *)btn
{
    [btn.superview performSelector:@selector(close)];
}
-  (void)confirmClick:(UIButton *)btn
{
    [btn.superview performSelector:@selector(close)];
    UITextField *tf1 = [btn.superview viewWithTag:100];
    UITextField *tf2 = [btn.superview viewWithTag:101];
    
    
    if ([tf1.text isEqualToString:tf2.text]) {
        [self lodChangePassword:tf1.text];
    }else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"输入密码不相同，请重新输入" message:@"温馨提示" preferredStyle:1];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
}


- (void)lodChangePassword:(NSString *)str{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"bianhao.text"],
            @"userId":[Manager redingwenjianming:@"userid.text"],
            @"newPassword":str,
            };
    //    NSLog(@"----%@",dic);
    [session POST:KURLNSString(@"user/restMyPwd") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        //NSLog(@"----%@",dic);
        if ([[dic objectForKey:@"result_code"]isEqualToString:@"success"]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"修改成功，下次登录时生效" message:@"温馨提示" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [Manager writewenjianming:@"password.text" content:str];
            }];
            [alert addAction:cancel];
            [weakSelf presentViewController:alert animated:YES completion:nil];
        }else{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"修改失败" message:@"温馨提示" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:cancel];
            [weakSelf presentViewController:alert animated:YES completion:nil];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}















- (void)viewWillDisappear:(BOOL)animated {
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewWillAppear:(BOOL)animated {
    self.tabBarController.tabBar.hidden = YES;
}
- (NSMutableArray *)arr{
    if (_arr == nil) {
        self.arr = [NSMutableArray arrayWithCapacity:1];
    }
    return _arr;
}
- (NSMutableArray *)imgarr{
    if (_imgarr == nil) {
        self.imgarr = [NSMutableArray arrayWithCapacity:1];
    }
    return _imgarr;
}

- (NSMutableArray *)arr1{
    if (_arr1 == nil) {
        self.arr1 = [NSMutableArray arrayWithCapacity:1];
    }
    return _arr1;
}
- (NSMutableArray *)imgarr1{
    if (_imgarr1 == nil) {
        self.imgarr1 = [NSMutableArray arrayWithCapacity:1];
    }
    return _imgarr1;
}

@end
