//
//  CKZG_CGD_search_ViewController.m
//  AFEFactory
//
//  Created by ilovedxracer on 2017/12/7.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "CKZG_CGD_search_ViewController.h"
#import "CKZG_CGD_search_list_ViewController.h"
@interface CKZG_CGD_search_ViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NSString *strid2;
}
@property(nonatomic, strong)UITableView    *tableview1;
@property(nonatomic, strong)NSMutableArray *dataArray1;
@property(nonatomic, strong)NSMutableArray *dataArray1id;

@property(nonatomic, strong)UITableView    *tableview2;
@property(nonatomic, strong)NSMutableArray *dataArray2;
@property(nonatomic, strong)NSMutableArray *dataArray2id;
@end

@implementation CKZG_CGD_search_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.text1.delegate = self;
    self.text2.delegate = self;
    self.text3.delegate = self;
    self.text4.delegate = self;
    self.text5.delegate = self;
    self.text6.delegate = self;
    
    self.navigationItem.title = @"检索";
    LRViewBorderRadius(self.btn, 5, 0, [UIColor whiteColor]);
    
    
    self.dataArray2   = [@[@"待收货",@"待入库",@"已入库",@"已取消",@"已退货"]mutableCopy];
    self.dataArray2id = [@[@"created",@"working",@"finished",@"canceled",@"returned"]mutableCopy];
    
    
    self.tableview1 = [[UITableView alloc]initWithFrame:CGRectMake(125, 315, SCREEN_WIDTH-135, 200)];
    [self.tableview1.layer setBorderColor:[UIColor colorWithWhite:.5 alpha:.5].CGColor];
    [self.tableview1.layer setBorderWidth:1];
    self.tableview1.delegate = self;
    self.tableview1.dataSource = self;
    self.tableview1.hidden = YES;
    [self.tableview1 registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell1"];
    [self.view addSubview:self.tableview1];
    [self.view bringSubviewToFront:self.tableview1];
    
    self.tableview2 = [[UITableView alloc]initWithFrame:CGRectMake(125, 365, SCREEN_WIDTH-135, 200)];
    [self.tableview2.layer setBorderColor:[UIColor colorWithWhite:.5 alpha:.5].CGColor];
    [self.tableview2.layer setBorderWidth:1];
    self.tableview2.delegate = self;
    self.tableview2.dataSource = self;
    self.tableview2.hidden = YES;
    [self.tableview2 registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell2"];
    [self.view addSubview:self.tableview2];
    [self.view bringSubviewToFront:self.tableview2];
    
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
        //                NSLog(@"%@",dic);
        [weakSelf.dataArray1 removeAllObjects];
        weakSelf.dataArray1 = [[dic objectForKey:@"rows"]objectForKey:@"supplierList"];
        
        [weakSelf.tableview1 reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:self.tableview1]) {
        self.tableview1.hidden = YES;
        self.text5.text = self.dataArray1[indexPath.row];
    }else if ([tableView isEqual:self.tableview2]) {
        self.tableview2.hidden = YES;
        self.text6.text = self.dataArray2[indexPath.row];
        strid2 = self.dataArray2id[indexPath.row];
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([tableView isEqual:self.tableview1]) {
        return self.dataArray1.count;
    }
    return self.dataArray2.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:self.tableview1]) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text = self.dataArray1[indexPath.row];
        return cell;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = self.dataArray2[indexPath.row];
    return cell;
   
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
        self.text4.text = @"";
    }
    if (self.text5.text.length == 0) {
        self.text5.text = @"";
    }
    if (strid2.length == 0) {
        strid2 = @"";
    }
    
    
    CKZG_CGD_search_list_ViewController *list = [[CKZG_CGD_search_list_ViewController alloc]init];
    list.str1 = self.text1.text;
    list.str2 = self.text2.text;
    list.str3 = self.text3.text;
    list.str4 = self.text4.text;
    list.str5 = self.text5.text;
    list.str6 = strid2;
    
    list.purchaseOrderType = self.purchaseOrderType;
    
    list.navigationItem.title = @"检索信息";
    [self.navigationController pushViewController:list animated:YES];
    
}
















- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if ([textField isEqual:self.text5]) {
        [self.text1 resignFirstResponder];
        [self.text2 resignFirstResponder];
        [self.text3 resignFirstResponder];
        self.tableview2.hidden = YES;
        if (self.tableview1.hidden == YES) {
            self.tableview1.hidden = NO;
        }else{
            self.tableview1.hidden = YES;
        }
        return NO;
    }
    
    if ([textField isEqual:self.text6]) {
        [self.text1 resignFirstResponder];
        [self.text2 resignFirstResponder];
        [self.text3 resignFirstResponder];
        self.tableview1.hidden = YES;
        if (self.tableview2.hidden == YES) {
            self.tableview2.hidden = NO;
        }else{
            self.tableview2.hidden = YES;
        }
        return NO;
    }
    
    self.tableview1.hidden = YES;
    self.tableview2.hidden = YES;
    return YES;
}














- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.tableview1.hidden = YES;
    self.tableview2.hidden = YES;
    
    [self.text1 resignFirstResponder];
    [self.text2 resignFirstResponder];
    [self.text3 resignFirstResponder];
    [self.text4 resignFirstResponder];
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
- (NSMutableArray *)dataArray2id {
    if (_dataArray2id == nil) {
        self.dataArray2id = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray2id;
}

@end
