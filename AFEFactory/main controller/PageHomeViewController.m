//
//  PageHomeViewController.m
//  Factory
//
//  Created by ilovedxracer on 2017/11/20.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "PageHomeViewController.h"
#import "PaiDanViewController.h"
#import "UserTableViewController.h"

#import "CK_paidan_ViewController.h"
#import "SHCK_ViewController.h"
#import "XHCK_ViewController.h"
#import "PLCK_ViewController.h"
#import "CGGL_ViewController.h"

#import "WPGL_TableViewController.h"
#import "CZG_renshi_ViewController.h"

#import "SCBZ_PLDD_ViewController.h"

#import "SCBZ_plck_ViewController.h"

#import "SCBZ_gnch_ViewController.h"
#import "SCBZ_gwch_ViewController.h"


#import "YuanGong_ViewController.h"
#import "RuZhi_ViewController.h"
#import "LiZhi_ViewController.h"

#import "ZhiLiu_ViewController.h"

#import "GCCPCGLY_PaiDan_ViewController.h"
#import "PaiDan_A_ViewController.h"
#import "PaiDan_B_ViewController.h"
#import "GCCPCGLY_PiLiang_TableViewController.h"

#import "MoneyViewController.h"
#import "SheBeiTableViewController.h"

#import "Gongziguanli_TableViewController.h"

#import "GzTableViewController.h"

#import "AFEFactory-Swift.h"
@interface PageHomeViewController ()<UINavigationControllerDelegate>
{
    float height;
    UILabel *lab;
    NSString *totalMoney;
}
@property(nonatomic, strong)UIScrollView *scrollview;
@property(nonatomic, strong)NSMutableArray *imgArray;


@property(nonatomic, strong)UIImageView *bgimg;

@property(nonatomic, strong)UIImageView *userImageView;
@property(nonatomic, strong)NSMutableArray *dataSourceArray;
@end

@implementation PageHomeViewController
- (void)loddeList{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"bianhao.text"],
            @"id":[Manager redingwenjianming:@"id.text"],
            @"page":@"1",
            };
    [session POST:KURLNSString(@"servlet/organization/departmentperson/myindex") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        NSMutableArray *dataArray = [NSMutableArray arrayWithCapacity:1];
        NSMutableArray *arr = [dic objectForKey:@"rows"];
        for (NSDictionary *dict in arr) {
            PaiDanModel *model = [PaiDanModel mj_objectWithKeyValues:dict];
            [dataArray addObject:model];
        }
        PaiDanModel *model = dataArray.firstObject;
        [weakSelf.userImageView sd_setImageWithURL:[NSURL URLWithString:NSString(model.file)]placeholderImage:[UIImage imageNamed:@"user"]];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置导航控制器的代理为self
    self.navigationController.delegate = self;
    self.view.backgroundColor = [UIColor whiteColor];
    //-------------------------------------
    self.bgimg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 250)];
    self.bgimg.image = [UIImage imageNamed:@"sybg"];
    self.bgimg.userInteractionEnabled = YES;
    [self.view addSubview:self.bgimg];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(SCREEN_WIDTH-40, 25, 30, 30);
    [btn setImage:[UIImage imageNamed:@"sz"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickEdit) forControlEvents:UIControlEventTouchUpInside];
    [self.bgimg addSubview:btn];
    
    
    self.userImageView = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-45, 55, 100, 100)];
    self.userImageView.layer.cornerRadius = 50;
    self.userImageView.layer.masksToBounds = YES;
    self.userImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickImageview:)];
    [self.userImageView addGestureRecognizer:tap];

    [self.bgimg addSubview:self.userImageView];
    
    
    lab = [[UILabel alloc]initWithFrame:CGRectMake(20, 155, SCREEN_WIDTH-40, 60)];
    lab.numberOfLines = 0;
    lab.textAlignment = NSTextAlignmentCenter;
    lab.textColor = [UIColor whiteColor];
    lab.font=[UIFont systemFontOfSize:18];
    lab.text = [NSString stringWithFormat:@"%@\n%@",[Manager redingwenjianming:@"name.text"],[Manager redingwenjianming:@"phone.text"]];
    [self.bgimg addSubview:lab];
    
    //-----------------------------
    self.scrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0,250, SCREEN_WIDTH, SCREEN_HEIGHT-250)];
    self.scrollview.userInteractionEnabled = YES;
    [self.view addSubview:self.scrollview];
    
    self.dataSourceArray = [Manager sharedManager].Array1;
    self.imgArray = [Manager sharedManager].Array2;
    [self setbutton];
    
    [self loddeList];
}
- (void)setbutton {
    int b = 0;
    int hangshu;
    if (self.dataSourceArray.count % 3 == 0 ) {
        hangshu = (int )self.dataSourceArray.count / 3;
    } else {
        hangshu = (int )self.dataSourceArray.count / 3 + 1;
    }
    //j是小于你设置的列数
    for (int i = 0; i < hangshu; i++) {
        for (int j = 0; j < 3; j++) {
            CustomButton *btn = [CustomButton buttonWithType:UIButtonTypeCustom];
            if ( b  < self.dataSourceArray.count) {
                btn.frame = CGRectMake((0  + j * SCREEN_WIDTH/3), (i * 120*SCALE_HEIGHT) ,SCREEN_WIDTH/3, 120*SCALE_HEIGHT);
                btn.backgroundColor = [UIColor whiteColor];
                btn.tag = b;
                [btn setTitle:self.dataSourceArray[b] forState:UIControlStateNormal];
                [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                
                height = i * 120*SCALE_HEIGHT + 200*SCALE_HEIGHT;
                [self.scrollview setContentSize:CGSizeMake(SCREEN_WIDTH, height)];
                
                UIImage *image = [UIImage imageNamed:self.imgArray[b]];
                [btn setImage:image forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(yejian:) forControlEvents:UIControlEventTouchUpInside];
                [btn.layer setBorderColor:[UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1].CGColor];
                [btn.layer setBorderWidth:0.5f];
                [btn.layer setMasksToBounds:YES];
                [self.scrollview addSubview:btn];
                if (b > self.dataSourceArray.count)
                {
                    [btn removeFromSuperview];
                }
            }
            b++;
        }
    }
}

//仓库主管 8
//生产组长 6
//生产部长 7
//操作工   104
//工厂成品仓管理员 54
- (void)yejian:(UIButton *)sender{
    
    if ([sender.titleLabel.text isEqualToString:@"排单生产"]) {
        
        
        if ([[Manager redingwenjianming:@"roleid.text"] isEqualToString:@"8"]||
            [[Manager redingwenjianming:@"roleid.text"] isEqualToString:@"9"]||
            [[Manager redingwenjianming:@"roleid.text"] isEqualToString:@"109"]||
            [[Manager redingwenjianming:@"roleid.text"] isEqualToString:@"104"]) {
            //仓库主管
            CK_paidan_ViewController *paidan = [[CK_paidan_ViewController alloc]init];
            paidan.navigationItem.title = @"排单计划";
            [self.navigationController pushViewController:paidan animated:YES];
        }else if ([[Manager redingwenjianming:@"roleid.text"] isEqualToString:@"6"]){
            //生产组长
            PaiDanViewController *paidan = [[PaiDanViewController alloc]init];
            [Manager sharedManager].searchIndex = 0;
            [self.navigationController pushViewController:paidan animated:YES];
        }else if ([[Manager redingwenjianming:@"roleid.text"] isEqualToString:@"7"]){
            //生产部长
            SCBZ_PLDD_ViewController *paidan = [[SCBZ_PLDD_ViewController alloc]init];
            [Manager sharedManager].searchIndex = 0;
            [self.navigationController pushViewController:paidan animated:YES];
        }else if ([[Manager redingwenjianming:@"roleid.text"] isEqualToString:@"54"]){
            //工厂成品仓管理员
            GCCPCGLY_PaiDan_ViewController *vc = [[GCCPCGLY_PaiDan_ViewController alloc] initWithAddVCARY:@[[PaiDan_B_ViewController new],[PaiDan_A_ViewController new]] TitleS:@[@"批量订单",@"排单计划"]];
            vc.navigationItem.title = @"排单生产";
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    else if ([sender.titleLabel.text isEqualToString:@"采购管理"]){
        if ([[Manager redingwenjianming:@"roleid.text"] isEqualToString:@"9"] ||
            [[Manager redingwenjianming:@"roleid.text"] isEqualToString:@"7"]){
            CGGL_ViewController *paidan = [[CGGL_ViewController alloc]init];
            paidan.navigationItem.title = @"";
            [Manager sharedManager].index_caigou = 0;
            [self.navigationController pushViewController:paidan animated:YES];
        }
    }
    else if ([sender.titleLabel.text isEqualToString:@"设备管理"]){
            SheBeiTableViewController *paidan = [[SheBeiTableViewController alloc]init];
            paidan.navigationItem.title = @"设备管理";
            [self.navigationController pushViewController:paidan animated:YES];
    }
    else if ([sender.titleLabel.text isEqualToString:@"现货仓库"]){
        if ([[Manager redingwenjianming:@"roleid.text"] isEqualToString:@"8"]){
            XHCK_ViewController *paidan = [[XHCK_ViewController alloc]init];
            paidan.navigationItem.title = @"";
            [Manager sharedManager].index_xh = 0;
            [self.navigationController pushViewController:paidan animated:YES];
        }
    }
    else if ([sender.titleLabel.text isEqualToString:@"滞留仓库"]){
            ZhiLiu_ViewController *paidan = [[ZhiLiu_ViewController alloc]init];
            [self.navigationController pushViewController:paidan animated:YES];
    }
    else if ([sender.titleLabel.text isEqualToString:@"我的计件工资"]){
        MoneyViewController *paidan = [[MoneyViewController alloc]init];
        [self.navigationController pushViewController:paidan animated:YES];
    }
    else if ([sender.titleLabel.text isEqualToString:@"批量仓库"]){
        if ([[Manager redingwenjianming:@"roleid.text"] isEqualToString:@"7"]){
            SCBZ_plck_ViewController *paidan = [[SCBZ_plck_ViewController alloc]init];
            paidan.navigationItem.title = @"";
            [self.navigationController pushViewController:paidan animated:YES];
        }else  if ([[Manager redingwenjianming:@"roleid.text"] isEqualToString:@"8"] ||
                   [[Manager redingwenjianming:@"roleid.text"] isEqualToString:@"109"]){
            PLCK_ViewController *paidan = [[PLCK_ViewController alloc]init];
            paidan.navigationItem.title = @"";
            [self.navigationController pushViewController:paidan animated:YES];
        }else if ([[Manager redingwenjianming:@"roleid.text"] isEqualToString:@"54"]){
            GCCPCGLY_PiLiang_TableViewController *paidan = [[GCCPCGLY_PiLiang_TableViewController alloc]init];
            paidan.navigationItem.title = @"批量仓库";
            [self.navigationController pushViewController:paidan animated:YES];
        }
    }
    else if ([sender.titleLabel.text isEqualToString:@"售后仓库"]){
        if ([[Manager redingwenjianming:@"roleid.text"] isEqualToString:@"8"]){
            SHCK_ViewController *paidan = [[SHCK_ViewController alloc]init];
            paidan.navigationItem.title = @"";
            [Manager sharedManager].index_sh = 0;
            [self.navigationController pushViewController:paidan animated:YES];
        }
    }
    else if ([sender.titleLabel.text isEqualToString:@"国内出货"]){
        if ([[Manager redingwenjianming:@"roleid.text"] isEqualToString:@"7"]||
            [[Manager redingwenjianming:@"roleid.text"] isEqualToString:@"54"]){
            SCBZ_gnch_ViewController *wupin = [[SCBZ_gnch_ViewController alloc]init];
            wupin.navigationItem.title = @"";
            [Manager sharedManager].index_guonei = 0;
            [self.navigationController pushViewController:wupin animated:YES];
        }
    }
    else if ([sender.titleLabel.text isEqualToString:@"国外出货"]){
        if ([[Manager redingwenjianming:@"roleid.text"] isEqualToString:@"7"]||
            [[Manager redingwenjianming:@"roleid.text"] isEqualToString:@"54"]){
            SCBZ_gwch_ViewController *wupin = [[SCBZ_gwch_ViewController alloc]init];
            wupin.navigationItem.title = @"";
            [Manager sharedManager].index_guowai = 0;
            [self.navigationController pushViewController:wupin animated:YES];
        }
    }

    
    
    else if ([sender.titleLabel.text isEqualToString:@"我的工资"]){
        GzTableViewController *gongzi = [[GzTableViewController alloc]init];
        [self.navigationController pushViewController:gongzi animated:YES];
    }
    else if ([sender.titleLabel.text isEqualToString:@"人事管理"]){
        CZG_renshi_ViewController *vc = [[CZG_renshi_ViewController alloc] initWithAddVCARY:@[[YuanGong_ViewController new],[RuZhi_ViewController new],[LiZhi_ViewController new]] TitleS:@[@"员工列表",@"我要入职",@"我要离职"]];
        [Manager sharedManager].index_renshi = 1000;
        vc.navigationItem.title = @"人事管理";
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([sender.titleLabel.text isEqualToString:@"物品管理"]){
        WPGL_TableViewController *wupin = [[WPGL_TableViewController alloc]init];
        wupin.navigationItem.title = @"物品管理";
        [self.navigationController pushViewController:wupin animated:YES];
    }
    
    
}









#pragma mark - UINavigationControllerDelegate
// 将要显示控制器
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断要显示的控制器是否是自己
    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
    [self.navigationController setNavigationBarHidden:isShowHomePage animated:YES];
}

- (void)clickImageview:(UITapGestureRecognizer *)gesture{
    UserTableViewController *install = [[UserTableViewController alloc]init];
    [self.navigationController pushViewController:install animated:YES];
    self.tabBarController.tabBar.hidden = YES;
}
- (void)clickEdit{
    UserTableViewController *install = [[UserTableViewController alloc]init];
    [self.navigationController pushViewController:install animated:YES];
    self.tabBarController.tabBar.hidden = YES;
//    SwiftViewController *swift = [[SwiftViewController alloc]init];
//    [self.navigationController pushViewController:swift animated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = NO;
    //处于后台后登录角标归0
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}








- (NSMutableArray *)dataSourceArray {
    if (_dataSourceArray == nil) {
        self.dataSourceArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataSourceArray;
}
- (NSMutableArray *)imgArray {
    if (_imgArray == nil) {
        self.imgArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _imgArray;
}
@end
