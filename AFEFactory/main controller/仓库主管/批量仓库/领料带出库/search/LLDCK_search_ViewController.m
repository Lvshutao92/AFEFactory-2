//
//  LLDCK_search_ViewController.m
//  Factory
//
//  Created by ilovedxracer on 2017/11/28.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "LLDCK_search_ViewController.h"
#import "LLDCK_search_list_ViewController.h"
#import "XZGL_search_list_ViewController.h"

#import "GN_SYDJ_searchList_ViewController.h"
#import "GN_YWC_searchList_ViewController.h"
@interface LLDCK_search_ViewController ()<UITextFieldDelegate>

@end

@implementation LLDCK_search_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"检索";
    LRViewBorderRadius(self.btn, 5, 0, [UIColor whiteColor]);
    self.text1.delegate = self;
    self.text2.delegate = self;
    self.text3.delegate = self;
    
    
    if ([self.str isEqualToString:@"xzgl"]) {
        self.lab1.text = @"工艺模板";
        self.lab2.text = @"配置名称";
        self.lab3.text = @"创建人";
        self.lab1width.constant = 75;
        self.lab2width.constant = 75;
        self.lab3width.constant = 75;
    }else if ([self.str isEqualToString:@"GN_sydj"] || [self.str isEqualToString:@"GN_ywc"]) {
        self.lab1.text = @"出货单号";
        self.lab2.text = @"申请出货日期";
        self.lab3.text = @"实际出货日期";
        self.lab1width.constant = 100;
        self.lab2width.constant = 100;
        self.lab3width.constant = 100;
    }
    
    
    
    
    else{
        self.lab1.text = @"领料单号";
        self.lab2.text = @"订单编号";
        self.lab3.text = @"生产单号";
        self.lab1width.constant = 75;
        self.lab2width.constant = 75;
        self.lab3width.constant = 75;
    }
    
    
    // Do any additional setup after loading the view from its nib.
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.text1 resignFirstResponder];
    [self.text2 resignFirstResponder];
    [self.text3 resignFirstResponder];
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
- (IBAction)clickbtn:(id)sender {
    if (self.text1.text.length == 0) {
        self.text1.text = @"";
    }
    if (self.text2.text.length == 0) {
        self.text2.text = @"";
    }
    if (self.text3.text.length == 0) {
        self.text3.text = @"";
    }
    if ([self.str isEqualToString:@"xzgl"]) {
        XZGL_search_list_ViewController *list = [[XZGL_search_list_ViewController alloc]init];
        list.str1 = self.text1.text;
        list.str2 = self.text2.text;
        list.str3 = self.text3.text;
        list.navigationItem.title = @"检索信息";
        [self.navigationController pushViewController:list animated:YES];
    }
    
    
    
    else if ([self.str isEqualToString:@"GN_sydj"]) {
        GN_SYDJ_searchList_ViewController *list = [[GN_SYDJ_searchList_ViewController alloc]init];
        list.str1 = self.text1.text;
        list.str2 = self.text2.text;
        list.str3 = self.text3.text;
        list.navigationItem.title = @"检索信息";
        [self.navigationController pushViewController:list animated:YES];
    }
    else if ([self.str isEqualToString:@"GN_ywc"]) {
        GN_YWC_searchList_ViewController *list = [[GN_YWC_searchList_ViewController alloc]init];
        list.str1 = self.text1.text;
        list.str2 = self.text2.text;
        list.str3 = self.text3.text;
        list.navigationItem.title = @"检索信息";
        [self.navigationController pushViewController:list animated:YES];
    }
    
  
    
    else{
        LLDCK_search_list_ViewController *list = [[LLDCK_search_list_ViewController alloc]init];
        list.str1 = self.text1.text;
        list.str2 = self.text2.text;
        list.str3 = self.text3.text;
        list.navigationItem.title = @"检索信息";
        [self.navigationController pushViewController:list animated:YES];
    }
    
}

@end
