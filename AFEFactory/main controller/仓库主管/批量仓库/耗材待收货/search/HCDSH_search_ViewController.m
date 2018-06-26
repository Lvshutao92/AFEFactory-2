//
//  HCDSH_search_ViewController.m
//  Factory
//
//  Created by ilovedxracer on 2017/11/24.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "HCDSH_search_ViewController.h"
#import "PaiDanModel.h"
#import "HCDSH_search_list_ViewController.h"
#import "BJDSH_search_list_ViewController.h"
#import "BJYJD_search_list_ViewController.h"
#import "XHDSH_search_list_ViewController.h"
#import "SHDSH_search_list_ViewController.h"
#import "SHYJD_search_list_ViewController.h"
@interface HCDSH_search_ViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong)UITableView *tableview1;
@property(nonatomic, strong)NSMutableArray *dataArray;

@end

@implementation HCDSH_search_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"检索";
    LRViewBorderRadius(self.btn, 5, 0, [UIColor whiteColor]);
    self.text1.delegate = self;
    self.text2.delegate = self;
    self.text3.delegate = self;
    self.text4.delegate = self;
    self.text5.delegate = self;
    self.text6.delegate = self;
    
    self.tableview1 = [[UITableView alloc]initWithFrame:CGRectMake(149, 365, SCREEN_WIDTH-159, 250)];
    [self.tableview1.layer setBorderColor:[UIColor colorWithWhite:.5 alpha:.5].CGColor];
    [self.tableview1.layer setBorderWidth:1];
    self.tableview1.delegate = self;
    self.tableview1.dataSource = self;
    self.tableview1.hidden = YES;
    [self.tableview1 registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableview1];
    [self.view bringSubviewToFront:self.tableview1];
    
    [self lodd];
}

    




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.tableview1.hidden = YES;
    self.text6.text = self.dataArray[indexPath.row];
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


- (void)lodd{
    AFHTTPSessionManager *session = [Manager returnsession];
    NSDictionary *dic = [[NSDictionary alloc]init];
    __weak typeof (self) weakSelf = self;
    dic = @{@"businessId":[Manager redingwenjianming:@"bianhao.text"],
            @"departmentId":[Manager redingwenjianming:@"departmentId.text"],
            };
    [session POST:KURLNSString(@"servlet/stock/stockinorder") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
//        NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"dealerList"];
//        NSLog(@"%@",dic);
        [weakSelf.dataArray removeAllObjects];
//        for (NSDictionary *dict in arr) {
//            PaiDanModel *model = [PaiDanModel mj_objectWithKeyValues:dict];
            weakSelf.dataArray = [[dic objectForKey:@"rows"]objectForKey:@"supplierList"];
//        }
        
        [weakSelf.tableview1 reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}



- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
     self.tableview1.hidden = YES;
     [self.text1 resignFirstResponder];
     [self.text2 resignFirstResponder];
     [self.text3 resignFirstResponder];
}




- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if ([textField isEqual:self.text6]) {
        [self.text1 resignFirstResponder];
        [self.text2 resignFirstResponder];
        [self.text3 resignFirstResponder];
        if (self.tableview1.hidden == YES) {
            self.tableview1.hidden = NO;
        }else{
            self.tableview1.hidden = YES;
        }
        return NO;
    }
    if ([textField isEqual:self.text4]) {
        [self.text2 resignFirstResponder];
        self.tableview1.hidden = YES;
        KSDatePicker* picker = [[KSDatePicker alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 40, 300)];
        picker.appearance.radius = 5;
        picker.appearance.resultCallBack = ^void(KSDatePicker* datePicker,NSDate* currentDate,KSDatePickerButtonType buttonType){
            if (buttonType == KSDatePickerButtonCommit) {
                NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"yyyy-MM-dd"];
                NSString *str = [formatter stringFromDate:currentDate];
                self.text4.text = str;
            }
        };
        [picker show];
        return NO;
    }
    if ([textField isEqual:self.text5]) {
        [self.text2 resignFirstResponder];
        self.tableview1.hidden = YES;
        KSDatePicker* picker = [[KSDatePicker alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 40, 300)];
        picker.appearance.radius = 5;
        picker.appearance.resultCallBack = ^void(KSDatePicker* datePicker,NSDate* currentDate,KSDatePickerButtonType buttonType){
            if (buttonType == KSDatePickerButtonCommit) {
                NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"yyyy-MM-dd"];
                NSString *str = [formatter stringFromDate:currentDate];
                self.text5.text = str;
            }
        };
        [picker show];
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








- (IBAction)clickbuttonsearch:(id)sender {
    if (self.text1.text.length == 0) {
        self.text1.text = @"";
    }
    if (self.text2.text.length == 0) {
        self.text2.text = @"";
    }
    if (self.text3.text.length == 0) {
        self.text3.text = @"";
    }
    if (self.text4.text.length == 0) {
        self.text4.text = @"";
    }
    if (self.text5.text.length == 0) {
        self.text5.text = @"";
    }
    if (self.text6.text.length == 0) {
        self.text6.text = @"";
    }
    if ([self.str isEqualToString:@"HCDSH"]) {
        HCDSH_search_list_ViewController *list = [[HCDSH_search_list_ViewController alloc]init];
        list.str1 = self.text1.text;
        list.str2 = self.text2.text;
        list.str3 = self.text3.text;
        list.str4 = self.text4.text;
        list.str5 = self.text5.text;
        list.str6 = self.text6.text;
        list.navigationItem.title = @"检索信息";
        [self.navigationController pushViewController:list animated:YES];
    }else if ([self.str isEqualToString:@"BJDSH"]) {
        BJDSH_search_list_ViewController *list = [[BJDSH_search_list_ViewController alloc]init];
        list.str1 = self.text1.text;
        list.str2 = self.text2.text;
        list.str3 = self.text3.text;
        list.str4 = self.text4.text;
        list.str5 = self.text5.text;
        list.str6 = self.text6.text;
        list.navigationItem.title = @"检索信息";
        [self.navigationController pushViewController:list animated:YES];
    }else if ([self.str isEqualToString:@"BJYJD"]) {
        BJYJD_search_list_ViewController *list = [[BJYJD_search_list_ViewController alloc]init];
        list.str1 = self.text1.text;
        list.str2 = self.text2.text;
        list.str3 = self.text3.text;
        list.str4 = self.text4.text;
        list.str5 = self.text5.text;
        list.str6 = self.text6.text;
        list.navigationItem.title = @"检索信息";
        [self.navigationController pushViewController:list animated:YES];
    }else if ([self.str isEqualToString:@"xhdsh"]){
        XHDSH_search_list_ViewController *list = [[XHDSH_search_list_ViewController alloc]init];
        list.str1 = self.text1.text;
        list.str2 = self.text2.text;
        list.str3 = self.text3.text;
        list.str4 = self.text4.text;
        list.str5 = self.text5.text;
        list.str6 = self.text6.text;
        list.navigationItem.title = @"检索信息";
        [self.navigationController pushViewController:list animated:YES];
    }else if ([self.str isEqualToString:@"SHDSH"]){
        SHDSH_search_list_ViewController *list = [[SHDSH_search_list_ViewController alloc]init];
        list.str1 = self.text1.text;
        list.str2 = self.text2.text;
        list.str3 = self.text3.text;
        list.str4 = self.text4.text;
        list.str5 = self.text5.text;
        list.str6 = self.text6.text;
        list.navigationItem.title = @"检索信息";
        [self.navigationController pushViewController:list animated:YES];
    }else if ([self.str isEqualToString:@"SHYJD"]){
        SHYJD_search_list_ViewController *list = [[SHYJD_search_list_ViewController alloc]init];
        list.str1 = self.text1.text;
        list.str2 = self.text2.text;
        list.str3 = self.text3.text;
        list.str4 = self.text4.text;
        list.str5 = self.text5.text;
        list.str6 = self.text6.text;
        list.navigationItem.title = @"检索信息";
        [self.navigationController pushViewController:list animated:YES];
    }
    
}

@end
