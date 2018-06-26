//
//  BJRKD_search_ViewController.m
//  Factory
//
//  Created by ilovedxracer on 2017/11/28.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "BJRKD_search_ViewController.h"
#import "BJRKD_search_list_ViewController.h"
#import "XHRKD_search_list_ViewController.h"
#import "SHRKD_search_list_ViewController.h"
@interface BJRKD_search_ViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NSString *strid1;
    NSString *strid3;
    NSString *strid4;
}
@property(nonatomic, strong)UITableView *tableview1;
@property(nonatomic, strong)NSMutableArray *dataArray1;
@property(nonatomic, strong)NSMutableArray *dataArray1id;

@property(nonatomic, strong)UITableView *tableview2;
@property(nonatomic, strong)NSMutableArray *dataArray2;

@property(nonatomic, strong)UITableView *tableview3;
@property(nonatomic, strong)NSMutableArray *dataArray3;
@property(nonatomic, strong)NSMutableArray *dataArray3id;

@property(nonatomic, strong)UITableView *tableview4;
@property(nonatomic, strong)NSMutableArray *dataArray4;
@property(nonatomic, strong)NSMutableArray *dataArray4id;
@end

@implementation BJRKD_search_ViewController

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
    self.text7.delegate = self;
    self.text8.delegate = self;
    self.text9.delegate = self;
    
    if ([self.str isEqualToString:@"xhrkd"]) {
        self.lllheight.constant = 0;
        self.llltop.constant = 0;
        self.text8height.constant = 0;
        self.text8top.constant = 0;
        self.text8.placeholder = @"";
    }else if ([self.str isEqualToString:@"SHRKD"]) {
        self.lllheight.constant = 0;
        self.llltop.constant = 0;
        self.text8height.constant = 0;
        self.text8top.constant = 0;
        self.text8.placeholder = @"";
    }else{
        self.lllheight.constant = 30;
        self.llltop.constant = 20;
        self.text8height.constant = 40;
        self.text8top.constant = 10;
        self.text8.placeholder = @"请选择";
    }
    
    
    
    
    
    
    
    
    self.dataArray1   = [@[@"待收货",@"待入库",@"已入库",@"已取消",@"已退货"]mutableCopy];
    self.dataArray1id = [@[@"created",@"working",@"finished",@"canceled",@"returned"]mutableCopy];
    
    self.dataArray3   = [@[@"耗材采购单",@"批量部件采购单"]mutableCopy];
    self.dataArray3id = [@[@"Y",@"N"]mutableCopy];
    
    self.dataArray4   = [@[@"已开票",@"未开票"]mutableCopy];
    self.dataArray4id = [@[@"invoiced",@"unInvoiced"]mutableCopy];
    
    self.tableview1 = [[UITableView alloc]initWithFrame:CGRectMake(150, 265, SCREEN_WIDTH-160, 200)];
    [self.tableview1.layer setBorderColor:[UIColor colorWithWhite:.5 alpha:.5].CGColor];
    [self.tableview1.layer setBorderWidth:1];
    self.tableview1.delegate = self;
    self.tableview1.dataSource = self;
    self.tableview1.hidden = YES;
    [self.tableview1 registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell1"];
    [self.view addSubview:self.tableview1];
    [self.view bringSubviewToFront:self.tableview1];
    
    self.tableview2 = [[UITableView alloc]initWithFrame:CGRectMake(150, 415, SCREEN_WIDTH-160, 200)];
    [self.tableview2.layer setBorderColor:[UIColor colorWithWhite:.5 alpha:.5].CGColor];
    [self.tableview2.layer setBorderWidth:1];
    self.tableview2.delegate = self;
    self.tableview2.dataSource = self;
    self.tableview2.hidden = YES;
    [self.tableview2 registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell2"];
    [self.view addSubview:self.tableview2];
    [self.view bringSubviewToFront:self.tableview2];
    
    self.tableview3 = [[UITableView alloc]initWithFrame:CGRectMake(150, 465, SCREEN_WIDTH-160, 100)];
    [self.tableview3.layer setBorderColor:[UIColor colorWithWhite:.5 alpha:.5].CGColor];
    [self.tableview3.layer setBorderWidth:1];
    self.tableview3.delegate = self;
    self.tableview3.dataSource = self;
    self.tableview3.hidden = YES;
    [self.tableview3 registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell3"];
    [self.view addSubview:self.tableview3];
    [self.view bringSubviewToFront:self.tableview3];
    
    
    self.tableview4 = [[UITableView alloc]initWithFrame:CGRectMake(150, 375, SCREEN_WIDTH-160, 100)];
    [self.tableview4.layer setBorderColor:[UIColor colorWithWhite:.5 alpha:.5].CGColor];
    [self.tableview4.layer setBorderWidth:1];
    self.tableview4.delegate = self;
    self.tableview4.dataSource = self;
    self.tableview4.hidden = YES;
    [self.tableview4 registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell4"];
    [self.view addSubview:self.tableview4];
    [self.view bringSubviewToFront:self.tableview4];
    [self lodd];
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
//                NSLog(@"%@",dic);
        [weakSelf.dataArray2 removeAllObjects];
        //        for (NSDictionary *dict in arr) {
        //            PaiDanModel *model = [PaiDanModel mj_objectWithKeyValues:dict];
        weakSelf.dataArray2 = [[dic objectForKey:@"rows"]objectForKey:@"supplierList"];
        //        }
        
        [weakSelf.tableview2 reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:self.tableview1]) {
        self.tableview1.hidden = YES;
        self.text4.text = self.dataArray1[indexPath.row];
        strid1 = self.dataArray1id[indexPath.row];
    }else if ([tableView isEqual:self.tableview2]) {
        self.tableview2.hidden = YES;
        self.text7.text = self.dataArray2[indexPath.row];
    }else if ([tableView isEqual:self.tableview3]) {
        self.tableview3.hidden = YES;
        self.text8.text = self.dataArray3[indexPath.row];
        strid3 = self.dataArray3id[indexPath.row];
    }else if ([tableView isEqual:self.tableview4]) {
        self.tableview4.hidden = YES;
        self.text9.text = self.dataArray4[indexPath.row];
        strid4 = self.dataArray4id[indexPath.row];
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([tableView isEqual:self.tableview1]) {
        return self.dataArray1.count;
    }else if ([tableView isEqual:self.tableview2]) {
        return self.dataArray2.count;
    }else if ([tableView isEqual:self.tableview3]) {
        return self.dataArray3.count;
    }
    return self.dataArray4.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:self.tableview1]) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text = self.dataArray1[indexPath.row];
        return cell;
    }
   else if ([tableView isEqual:self.tableview2]) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text = self.dataArray2[indexPath.row];
        return cell;
   }else if ([tableView isEqual:self.tableview3]){
       UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell3" forIndexPath:indexPath];
       cell.selectionStyle = UITableViewCellSelectionStyleNone;
       cell.textLabel.text = self.dataArray3[indexPath.row];
       return cell;
   }
        
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell4" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = self.dataArray4[indexPath.row];
    return cell;
}





- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if ([textField isEqual:self.text4]) {
        [self.text1 resignFirstResponder];
        [self.text2 resignFirstResponder];
        [self.text3 resignFirstResponder];
         self.tableview2.hidden = YES;
         self.tableview3.hidden = YES;
        self.tableview4.hidden = YES;
        if (self.tableview1.hidden == YES) {
            self.tableview1.hidden = NO;
        }else{
            self.tableview1.hidden = YES;
        }
        return NO;
    }
    if ([textField isEqual:self.text5]) {
        self.tableview1.hidden = YES;
        self.tableview2.hidden = YES;
        self.tableview3.hidden = YES;
        self.tableview4.hidden = YES;
        [self.text1 resignFirstResponder];
        [self.text2 resignFirstResponder];
        [self.text3 resignFirstResponder];
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
    if ([textField isEqual:self.text6]) {
        self.tableview1.hidden = YES;
        self.tableview2.hidden = YES;
        self.tableview3.hidden = YES;
        self.tableview4.hidden = YES;
        [self.text1 resignFirstResponder];
        [self.text2 resignFirstResponder];
        [self.text3 resignFirstResponder];
        KSDatePicker* picker = [[KSDatePicker alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 40, 300)];
        picker.appearance.radius = 5;
        picker.appearance.resultCallBack = ^void(KSDatePicker* datePicker,NSDate* currentDate,KSDatePickerButtonType buttonType){
            if (buttonType == KSDatePickerButtonCommit) {
                NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"yyyy-MM-dd"];
                NSString *str = [formatter stringFromDate:currentDate];
                self.text6.text = str;
            }
        };
        [picker show];
        return NO;
    }
    if ([textField isEqual:self.text7]) {
        [self.text1 resignFirstResponder];
        [self.text2 resignFirstResponder];
        [self.text3 resignFirstResponder];
        self.tableview1.hidden = YES;
        self.tableview3.hidden = YES;
        self.tableview4.hidden = YES;
        if (self.tableview2.hidden == YES) {
            self.tableview2.hidden = NO;
        }else{
            self.tableview2.hidden = YES;
        }
        return NO;
    }
    if ([textField isEqual:self.text8]) {
        [self.text1 resignFirstResponder];
        [self.text2 resignFirstResponder];
        [self.text3 resignFirstResponder];
         self.tableview1.hidden = YES;
         self.tableview2.hidden = YES;
        self.tableview4.hidden = YES;
        if (self.tableview3.hidden == YES) {
            self.tableview3.hidden = NO;
        }else{
            self.tableview3.hidden = YES;
        }
        return NO;
    }
    if ([textField isEqual:self.text9]) {
        [self.text1 resignFirstResponder];
        [self.text2 resignFirstResponder];
        [self.text3 resignFirstResponder];
        self.tableview1.hidden = YES;
        self.tableview2.hidden = YES;
        self.tableview3.hidden = YES;
        if (self.tableview4.hidden == YES) {
            self.tableview4.hidden = NO;
        }else{
            self.tableview4.hidden = YES;
        }
        return NO;
    }
    
    
    
    self.tableview1.hidden = YES;
    self.tableview2.hidden = YES;
    self.tableview3.hidden = YES;
    self.tableview4.hidden = YES;
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.tableview1.hidden = YES;
    self.tableview2.hidden = YES;
    self.tableview3.hidden = YES;
    self.tableview4.hidden = YES;
    
    [self.text1 resignFirstResponder];
    [self.text2 resignFirstResponder];
    [self.text3 resignFirstResponder];
}




- (NSMutableArray *)dataArray1id {
    if (_dataArray1id == nil) {
        self.dataArray1id = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray1id;
}
- (NSMutableArray *)dataArray1 {
    if (_dataArray1 == nil) {
        self.dataArray1 = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray1;
}
- (NSMutableArray *)dataArray2 {
    if (_dataArray2 == nil) {
        self.dataArray2 = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray2;
}
- (NSMutableArray *)dataArray3 {
    if (_dataArray3 == nil) {
        self.dataArray3 = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray3;
}
- (NSMutableArray *)dataArray4id {
    if (_dataArray4id == nil) {
        self.dataArray4id = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray4id;
}
- (NSMutableArray *)dataArray4 {
    if (_dataArray4 == nil) {
        self.dataArray4 = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray4;
}







- (IBAction)clicksearch:(id)sender {
    
    
    
    
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
        strid1 = @"";
    }
    if (self.text5.text.length == 0) {
        self.text5.text = @"";
    }
    if (self.text6.text.length == 0) {
        self.text6.text = @"";
    }
    if (self.text7.text.length == 0) {
        self.text7.text = @"";
    }
    if (self.text8.text.length == 0) {
        strid3 = @"";
    }
    if (self.text9.text.length == 0) {
        strid4 = @"";
    }
    
    if ([self.str isEqualToString:@"xhrkd"]){
        XHRKD_search_list_ViewController *list = [[XHRKD_search_list_ViewController alloc]init];
        list.str1 = self.text1.text;
        list.str2 = self.text2.text;
        list.str3 = self.text3.text;
        list.str4 = strid1;
        list.str5 = self.text5.text;
        list.str6 = self.text6.text;
        list.str7 = self.text7.text;
        
        list.str8 = strid4;
        list.navigationItem.title = @"检索信息";
        [self.navigationController pushViewController:list animated:YES];
    }else if ([self.str isEqualToString:@"SHRKD"]){
        SHRKD_search_list_ViewController *list = [[SHRKD_search_list_ViewController alloc]init];
        list.str1 = self.text1.text;
        list.str2 = self.text2.text;
        list.str3 = self.text3.text;
        list.str4 = strid1;
        list.str5 = self.text5.text;
        list.str6 = self.text6.text;
        list.str7 = self.text7.text;
        
        list.str8 = strid4;
        list.navigationItem.title = @"检索信息";
        [self.navigationController pushViewController:list animated:YES];
    }else{
        BJRKD_search_list_ViewController *list = [[BJRKD_search_list_ViewController alloc]init];
        list.str1 = self.text1.text;
        list.str2 = self.text2.text;
        list.str3 = self.text3.text;
        list.str4 = strid1;
        list.str5 = self.text5.text;
        list.str6 = self.text6.text;
        list.str7 = self.text7.text;
        list.str8 = strid3;
        list.str9 = strid4;
        list.navigationItem.title = @"检索信息";
        [self.navigationController pushViewController:list animated:YES];
        
        
        
        
        
    }
    
    
    
    
    
}

@end
