//
//  LoginViewController.m
//  Factory
//
//  Created by ilovedxracer on 2017/11/17.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()<UITextFieldDelegate>
{
    NSString *appstore_verson;
    NSString *appstore_newverson;
}
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.img.contentMode = UIViewContentModeScaleAspectFit;
    self.text1.keyboardType = UIKeyboardTypeNumberPad;
    self.text2.keyboardType = UIKeyboardTypeDefault;
    self.text3.keyboardType = UIKeyboardTypeASCIICapable;
    self.text1.delegate = self;
    self.text2.delegate = self;
    self.text3.delegate = self;
    self.text1.borderStyle = UITextBorderStyleNone;
    self.text2.borderStyle = UITextBorderStyleNone;
    self.text3.borderStyle = UITextBorderStyleNone;
    
    LRViewBorderRadius(self.img, 15, 1, [UIColor colorWithWhite:.85 alpha:.4]);
    self.text1.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.text2.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.text3.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.text3.secureTextEntry = YES;
    LRViewBorderRadius(self.btn, 5, 0, RGBACOLOR(32, 157, 149, 1.0));
    self.text1.text  = [Manager redingwenjianming:@"bianhao.text"];
    self.text2.text  = [Manager redingwenjianming:@"user.text"];
    self.text3.text  = [Manager redingwenjianming:@"password.text"];
    
    
    [self lodverson];
    
    [self vie1];
    [self vie2];
    [self vie3];
}
- (void)vie1{
    _text1.leftViewMode = UITextFieldViewModeAlways;
    UIImageView *loginImgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login1"]];
    loginImgV.frame = CGRectMake(10, 10, 20, 20);
    loginImgV.contentMode = UIViewContentModeScaleAspectFit;
    UIView *lv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [lv addSubview:loginImgV];
    _text1.leftView = lv;
}
- (void)vie2{
    _text2.leftViewMode = UITextFieldViewModeAlways;
    UIImageView *loginImgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login2"]];
    loginImgV.frame = CGRectMake(10, 10, 20, 20);
    loginImgV.contentMode = UIViewContentModeScaleAspectFit;
    UIView *lv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [lv addSubview:loginImgV];
    _text2.leftView = lv;
}
- (void)vie3{
    _text3.leftViewMode = UITextFieldViewModeAlways;
    UIImageView *loginImgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login3"]];
    loginImgV.frame = CGRectMake(10, 10, 20, 20);
    loginImgV.contentMode = UIViewContentModeScaleAspectFit;
    UIView *lv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [lv addSubview:loginImgV];
    _text3.leftView = lv;
}





- (void)lodverson{
    NSString *dom= [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)firstObject];
    NSString *tex= [dom stringByAppendingPathComponent:@"newversion.text"];
    //取出存入的上次版本号版本号
    appstore_verson = [NSString stringWithContentsOfFile:tex encoding:NSUTF8StringEncoding error:nil];
    
    __weak typeof(self) weakSelf = self;
    AFHTTPSessionManager *session = [Manager returnsession];
    [session POST:@"https://itunes.apple.com/lookup?id=1319801089" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        NSMutableArray *arr = [dic objectForKey:@"results"];
        NSDictionary *dict = [arr lastObject];
        //app store版本号
        appstore_newverson = dict[@"version"];
        
        //写入版本号
        NSString *doucments = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)firstObject];
        NSString *text= [doucments stringByAppendingPathComponent:@"newversion.text"];
        [appstore_newverson writeToFile:text atomically:YES encoding:NSUTF8StringEncoding error:nil];
        
        //NSLog(@"appstore版本：%@----存入的版本号：%@",appstore_newverson,appstore_verson);
        
        if (![appstore_verson isEqualToString:appstore_newverson] && appstore_verson != nil){
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"检测到有新的版本需要更新" message:@"温馨提示" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"稍后再说" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            }];
            UIAlertAction *sure = [UIAlertAction actionWithTitle:@"立即前往" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://itunes.apple.com/cn/app/jie-zou-da-shi/id1319801089?mt=8"]];
            }];
            [alert addAction:cancel];
            [alert addAction:sure];
            [weakSelf presentViewController:alert animated:YES completion:nil];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}


- (IBAction)clickButtonLogin:(id)sender {
    [self.text1 resignFirstResponder];
    [self.text2 resignFirstResponder];
    [self.text3 resignFirstResponder];
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                //NSLog(@"未知网络");
                [self lodlogin];
                break;
            case AFNetworkReachabilityStatusNotReachable:
                //NSLog(@"没有网络(断网)");
                [self noNetWorking];
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                //NSLog(@"手机自带网络");
                [self lodlogin];
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                //NSLog(@"WIFI");
                [self lodlogin];
                break;
        }
    }];
    [manager startMonitoring];
}

- (void)noNetWorking{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"无网络连接，请检查网络！" message:@"温馨提示" preferredStyle:1];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
}
- (void)lodlogin{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.label.text = NSLocalizedString(@"加载中....", @"HUD loading title");
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    if (self.text1.text != nil && self.text2.text && self.text3.text) {
        dic = @{@"businessId":self.text1.text,
                @"username":self.text2.text,
                @"password":self.text3.text,
                @"ipAddress":[[Manager sharedManager] getIPAddress:YES],
                };
        
        [session POST:KURLNSString(@"user/login") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary *dic = [Manager returndictiondata:responseObject];
//            NSLog(@"++%@",dic);
            if ([[dic objectForKey:@"result_code"]isEqualToString:@"success"]){
                
                [Manager writewenjianming:@"userid.text" content:[NSString stringWithFormat:@"%@",[[[dic objectForKey:@"rows"]objectForKey:@"systemUser"] objectForKey:@"id"]]];
                
                [Manager writewenjianming:@"user_cert_id.text" content:[NSString stringWithFormat:@"%@",[[[dic objectForKey:@"rows"]objectForKey:@"systemUser"] objectForKey:@"personId"]]];
               
                //person id
                [Manager writewenjianming:@"realName.text" content:[NSString stringWithFormat:@"%@ %@",[[[dic objectForKey:@"rows"]objectForKey:@"departmentPerson"] objectForKey:@"personCode"],[[[dic objectForKey:@"rows"]objectForKey:@"departmentPerson"] objectForKey:@"realName"]]];
                
                
                [Manager writewenjianming:@"id.text" content:[NSString stringWithFormat:@"%@",[[[dic objectForKey:@"rows"]objectForKey:@"departmentPerson"] objectForKey:@"id"]]];
                
                
                [Manager writewenjianming:@"departmentId.text" content:[NSString stringWithFormat:@"%@",[[[dic objectForKey:@"rows"]objectForKey:@"departmentPerson"] objectForKey:@"departmentId"]]];
                //
                
                [Manager writewenjianming:@"personCode.text" content:[NSString stringWithFormat:@"%@",[[[dic objectForKey:@"rows"]objectForKey:@"departmentPerson"] objectForKey:@"personCode"]]];
                
                
                [Manager writewenjianming:@"realName.text" content:[NSString stringWithFormat:@"%@",[[[dic objectForKey:@"rows"]objectForKey:@"departmentPerson"] objectForKey:@"realName"]]];
                
                
                
                
                
                
                
                
                //存取person
                [Manager sharedManager].diction = [[dic objectForKey:@"rows"]objectForKey:@"departmentPerson"];
                
                
                [Manager writewenjianming:@"name.text" content:[[[dic objectForKey:@"rows"]objectForKey:@"systemUser"] objectForKey:@"username"]];
                [Manager writewenjianming:@"phone.text" content:[[[dic objectForKey:@"rows"] objectForKey:@"systemUser"] objectForKey:@"telephone"]];

                NSDictionary *dictrole = [[dic objectForKey:@"rows"] objectForKey:@"systemUserRole"];
                [Manager writewenjianming:@"roleid.text" content:[NSString stringWithFormat:@"%@",[dictrole objectForKey:@"roleId"]]];
                
                [Manager writewenjianming:@"bianhao.text" content:weakSelf.text1.text];
                [Manager writewenjianming:@"user.text" content:weakSelf.text2.text];
                [Manager writewenjianming:@"password.text" content:weakSelf.text3.text];
                
                [weakSelf lod:[dictrole objectForKey:@"roleId"]];
                
            }else{
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"登录失败，请检查用户名和密码是否正确" message:@"温馨提示" preferredStyle:1];
                UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                }];
                [alert addAction:cancel];
                [self presentViewController:alert animated:YES completion:nil];
            }
            [hud hideAnimated:YES];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"登录失败，请检查用户名和密码是否正确" message:@"温馨提示" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:cancel];
            [self presentViewController:alert animated:YES completion:nil];
            [hud hideAnimated:YES];
        }];
    }
}

- (void)lod:(NSString *)str{
    AFHTTPSessionManager *session = [Manager returnsession];
    NSDictionary *dic = [NSDictionary dictionary];
    dic = @{@"pId":@"",
            @"roleId":str,
            };
//    NSLog(@"--------%@",dic);
    [session POST:KURLNSString(@"user/getAppResourceByRPId") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"resultList"];
        [[Manager sharedManager].Array1 removeAllObjects];
        [[Manager sharedManager].Array2 removeAllObjects];
        for (NSDictionary *dic in arr) {
            rolemodel *model = [rolemodel mj_objectWithKeyValues:dic];
//          NSLog(@"%@--------%@",model.NAME,model.id);
            if ([model.id isEqualToString:@"46"]) {
                [[Manager sharedManager].Array1 addObject:@"排单生产"];
                [[Manager sharedManager].Array2 addObject:@"排单"];
                [Manager sharedManager].PaiDanID = @"46";
            }
            else if ([model.id isEqualToString:@"43"]) {
                [[Manager sharedManager].Array1 addObject:@"现货仓库"];
                [[Manager sharedManager].Array2 addObject:@"售后仓库"];
                [Manager sharedManager].PaiDanID = @"43";
            }
            else if ([model.id isEqualToString:@"54"]) {
                [[Manager sharedManager].Array1 addObject:@"批量仓库"];
                [[Manager sharedManager].Array2 addObject:@"现货仓库"];
                [Manager sharedManager].PaiDanID = @"54";
            }
            else if ([model.id isEqualToString:@"259"]) {
                [[Manager sharedManager].Array1 addObject:@"售后仓库"];
                [[Manager sharedManager].Array2 addObject:@"批量仓库"];
                [Manager sharedManager].PaiDanID = @"259";
            }
            
            else if ([model.id isEqualToString:@"382"]) {
                [[Manager sharedManager].Array1 addObject:@"国内出货"];
                [[Manager sharedManager].Array2 addObject:@"国内"];
                [Manager sharedManager].PaiDanID = @"382";
            }
            else if ([model.id isEqualToString:@"517"]) {
                [[Manager sharedManager].Array1 addObject:@"国外出货"];
                [[Manager sharedManager].Array2 addObject:@"国外"];
                [Manager sharedManager].PaiDanID = @"517";
            }
            else if ([model.id isEqualToString:@"545"]) {
                [[Manager sharedManager].Array1 addObject:@"滞留仓库"];
                [[Manager sharedManager].Array2 addObject:@"售后仓库"];
                [Manager sharedManager].PaiDanID = @"545";
            }
            else if ([model.id isEqualToString:@"1252"]) {
                [[Manager sharedManager].Array1 addObject:@"我的计件工资"];
                [[Manager sharedManager].Array2 addObject:@"工资管理"];
                [Manager sharedManager].PaiDanID = @"1252";
            }
            
            
            else if ([model.id isEqualToString:@"633"]) {
                [[Manager sharedManager].Array1 addObject:@"设备管理"];
                [[Manager sharedManager].Array2 addObject:@"设备管理"];
                [Manager sharedManager].PaiDanID = @"633";
            }
            else if ([model.id isEqualToString:@"1346"]) {
                [[Manager sharedManager].Array1 addObject:@"我的工资"];
                [[Manager sharedManager].Array2 addObject:@"工资管理"];
                [Manager sharedManager].PaiDanID = @"1346";
            }
            
            
            //--------
            if ([[Manager redingwenjianming:@"roleid.text"] isEqualToString:@"7"]){
                if ([model.id isEqualToString:@"64"]) {
                    [[Manager sharedManager].Array1 addObject:@"采购管理"];
                    [[Manager sharedManager].Array2 addObject:@"采购管理"];
                    [Manager sharedManager].PaiDanID = @"64";
                }
            }
            //--------
                if ([model.id isEqualToString:@"71"]) {
                    [[Manager sharedManager].Array1 addObject:@"人事管理"];
                    [[Manager sharedManager].Array2 addObject:@"人事管理"];
                    [Manager sharedManager].PaiDanID = @"71";
                }
            //---------
                 if ([model.id isEqualToString:@"776"]) {
                    [[Manager sharedManager].Array1 addObject:@"物品管理"];
                    [[Manager sharedManager].Array2 addObject:@"物品管理"];
                    [Manager sharedManager].PaiDanID = @"776";
                }
           
            
        }
        //跳转进入
        NSDictionary *dict = [[NSDictionary alloc]init];
        NSNotification *notification =[NSNotification notificationWithName:@"hiddenlogin" object:nil userInfo:dict];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    
}
//仓库主管 8
//生产组长 6
//生产部长 7
//操作工   104
//工厂成品仓管理员 54









//rows =     {
//    departmentPerson =         {
//        businessId = 10003;
//        city = "<null>";
//        cityName = "<null>";
//        departmentId = 5;
//        file = "factory/10003/upload/22_20171023143602.jpg";
//        formalDate = "2015-11-12";
//        id = 89;
//        jxSalaryId = "<null>";
//        payStatus = Y;
//        personCode = 3SCB012;
//        phone = 13961681360;
//        positionId = 7;
//        province = "<null>";
//        provinceName = "<null>";
//        purchaseStockInCount = 0;
//        realName = "\U738b\U6d77";
//        salary = "<null>";
//        salaryId = "<null>";
//        sex = M;
//        status = Y;
//        workstatus = "<null>";
//    };
//    systemUser =         {
//        businessId = 10003;
//        departmentPersonCert =             {
//            businessId = 10003;
//            configCert =                 {
//                businessId = 10003;
//                field1 = "<null>";
//                field2 = "<null>";
//                field3 = "<null>";
//                field4 = "<null>";
//                field5 = "<null>";
//                fieldType = "\U8eab\U4efd\U8bc1\U590d\U5370\U4ef6";
//                id = 2;
//            };
//            field1 = "<null>";
//            field2 = "<null>";
//            field3 = "<null>";
//            field4 = "<null>";
//            field5 = "<null>";
//            fieldType = 2;
//            fieldUrl = "factory/10003/upload/22_20171014145603.jpg";
//            id = 368;
//            personId = 118;
//        };
//        departmentPersonFile = "<null>";
//        field1 = "<null>";
//        field2 = "<null>";
//        field3 = "<null>";
//        field4 = "<null>";
//        field5 = "<null>";
//        id = 89;
//        password = 111111;
//        personId = 368;
//        status = Y;
//        telephone = 18551049547;
//        username = "\U5415\U4e66\U6d9b";
//    };
//    systemUserRole =         {
//        id = 89;
//        roleId = 7;
//        userId = 89;
//    };
//};

@end
