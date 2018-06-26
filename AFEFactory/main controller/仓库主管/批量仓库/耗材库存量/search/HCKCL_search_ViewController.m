//
//  HCKCL_search_ViewController.m
//  Factory
//
//  Created by ilovedxracer on 2017/11/24.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "HCKCL_search_ViewController.h"
#import "HCKCL_search_list_ViewController.h"
#import "SHKCL_search_list_ViewController.h"


#import "GuoNei_ysq_search_list_controller.h"
#import "GuoNei_dch_search_list_controller.h"


@interface HCKCL_search_ViewController ()<UITextFieldDelegate>

@end

@implementation HCKCL_search_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"检索";
    self.text1.delegate = self;
    self.text2.delegate = self;
    LRViewBorderRadius(self.btn, 5, 0, [UIColor whiteColor]);
    
    if ([self.str isEqualToString:@"GN_ysq"]||[self.str isEqualToString:@"GN_dch"]) {
        self.lab1.text = @"出货单号";
        self.lab2.text = @"申请出货日期";
        self.lab1width.constant = 100;
        self.lab2width.constant = 100;
    }else{
        self.lab1.text = @"部件编号";
        self.lab2.text = @"部件名称";
        self.lab1width.constant = 75;
        self.lab2width.constant = 75;
    }
    
    
    
    
}


- (IBAction)clicksearch:(id)sender {
    if (self.text1.text.length == 0) {
        self.text1.text = @"";
    }
    if (self.text2.text.length == 0) {
        self.text2.text = @"";
    }
    
    
    if ([self.str isEqualToString:@"SHKCL"]) {
        SHKCL_search_list_ViewController *list = [[SHKCL_search_list_ViewController alloc]init];
        list.partNo = self.text1.text;
        list.partName = self.text2.text;
        list.navigationItem.title = @"检索信息";
        [self.navigationController pushViewController:list animated:YES];
    }
    
    else if ([self.str isEqualToString:@"GN_ysq"]){
        GuoNei_ysq_search_list_controller *list = [[GuoNei_ysq_search_list_controller alloc]init];
        list.shipmentNo       = self.text1.text;
        list.planShipmentDate = self.text2.text;
        list.navigationItem.title = @"检索信息";
        [self.navigationController pushViewController:list animated:YES];
    }
    
    else if ([self.str isEqualToString:@"GN_dch"]){
        GuoNei_dch_search_list_controller *list = [[GuoNei_dch_search_list_controller alloc]init];
        list.shipmentNo       = self.text1.text;
        list.planShipmentDate = self.text2.text;
        list.navigationItem.title = @"检索信息";
        [self.navigationController pushViewController:list animated:YES];
    }
    
    else{
        HCKCL_search_list_ViewController *list = [[HCKCL_search_list_ViewController alloc]init];
        list.partNo = self.text1.text;
        list.partName = self.text2.text;
        list.navigationItem.title = @"检索信息";
        [self.navigationController pushViewController:list animated:YES];
        
    }
    
}

@end
