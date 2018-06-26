//
//  XHKCL_search_ViewController.m
//  Factory
//
//  Created by ilovedxracer on 2017/12/1.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "XHKCL_search_ViewController.h"
#import "XHKCL_search_list_ViewController.h"
#import "CGGL_search_list_ViewController.h"
@interface XHKCL_search_ViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NSString *status;
}
@property(nonatomic, strong)UITableView *tableview1;
@property(nonatomic, strong)NSMutableArray *dataArray;
@property(nonatomic, strong)NSMutableArray *dataArrayid;

@end

@implementation XHKCL_search_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"检索";
    LRViewBorderRadius(self.btn, 5, 0, [UIColor whiteColor]);
    
    self.text1.delegate = self;
    self.text2.delegate = self;
    self.text3.delegate = self;
    
    
    if ([self.str isEqualToString:@"caigou"]) {
        self.dataArray   = [@[@"已创建",@"未完成",@"已完成"]mutableCopy];
        self.dataArrayid = [@[@"created",@"unfinished",@"finished"]mutableCopy];
        
        self.lab1width.constant = 110;
        self.lab2width.constant = 110;
        self.lab3width.constant = 110;
        
        self.lab1.text = @"采购计划编号";
        self.lab2.text = @"批量订单编号";
        self.lab3.text = @"采购计划状态";
    }else{
        self.dataArray   = [@[@"已创建",@"已上架",@"未上架",@"部分上架",@"已停用"]mutableCopy];
        self.dataArrayid = [@[@"create",@"publish",@"unpublish",@"partpublish",@"disabled"]mutableCopy];
        
        self.lab1width.constant = 70;
        self.lab2width.constant = 70;
        self.lab3width.constant = 70;
        
        self.lab1.text = @"商品编号";
        self.lab2.text = @"商品名称";
        self.lab3.text = @"商品状态";
    }
    
    
    
    
    
    
    self.tableview1 = [[UITableView alloc]init];
    
    if ([self.str isEqualToString:@"caigou"]){
        self.tableview1.frame = CGRectMake(130, 215, SCREEN_WIDTH-140, 150);
    }else{
        self.tableview1.frame = CGRectMake(90, 215, SCREEN_WIDTH-100, 200);
    }
    
    
    [self.tableview1.layer setBorderColor:[UIColor colorWithWhite:.5 alpha:.5].CGColor];
    [self.tableview1.layer setBorderWidth:1];
    self.tableview1.delegate = self;
    self.tableview1.dataSource = self;
    self.tableview1.hidden = YES;
    [self.tableview1 registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableview1];
    [self.view bringSubviewToFront:self.tableview1];
    
}






- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.tableview1.hidden = YES;
    self.text3.text = self.dataArray[indexPath.row];
    status = self.dataArrayid[indexPath.row];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = self.dataArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}




- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    self.tableview1.hidden = YES;
    [self.text1 resignFirstResponder];
    [self.text2 resignFirstResponder];
}




- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if ([textField isEqual:self.text3]) {
        [self.text1 resignFirstResponder];
        [self.text2 resignFirstResponder];
        if (self.tableview1.hidden == YES) {
            self.tableview1.hidden = NO;
        }else{
            self.tableview1.hidden = YES;
        }
        return NO;
    }
    self.tableview1.hidden = YES;
    return YES;
}







- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        self.dataArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray;
}
- (NSMutableArray *)dataArrayid {
    if (_dataArrayid == nil) {
        self.dataArrayid = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArrayid;
}

- (IBAction)clickbtn:(id)sender {
    
    
    if (self.text1.text.length == 0) {
        self.text1.text = @"";
    }
    if (self.text2.text.length == 0) {
        self.text2.text = @"";
    }
    if (status.length == 0) {
        status = @"";
    }
    
    
    if ([self.str isEqualToString:@"caigou"]) {
        CGGL_search_list_ViewController *list = [[CGGL_search_list_ViewController alloc]init];
        list.str1 = self.text1.text;
        list.str2 = self.text2.text;
        list.str3 = status;
        list.navigationItem.title = @"检索信息";
        [self.navigationController pushViewController:list animated:YES];
    }else{
        XHKCL_search_list_ViewController *list = [[XHKCL_search_list_ViewController alloc]init];
        list.str1 = self.text1.text;
        list.str2 = self.text2.text;
        list.str3 = status;
        list.navigationItem.title = @"检索信息";
        [self.navigationController pushViewController:list animated:YES];
    }
        
    
    
    
}

@end
