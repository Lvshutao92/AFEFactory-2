//
//  YuanGong_search_ViewController.m
//  AFEFactory
//
//  Created by ilovedxracer on 2017/12/13.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "YuanGong_search_ViewController.h"
#import "PaiDanModel.h"
#import "YuanGongSearchListViewController.h"
@interface YuanGong_search_ViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NSString *strid1;
    NSString *strid2;
    NSString *strid3;
}
@property(nonatomic, strong)UITableView    *tableview1;
@property(nonatomic, strong)NSMutableArray *dataArray1;
@property(nonatomic, strong)NSMutableArray *dataArray1id;

@property(nonatomic, strong)UITableView    *tableview2;
@property(nonatomic, strong)NSMutableArray *dataArray2;
@property(nonatomic, strong)NSMutableArray *dataArray2id;


@property(nonatomic, strong)UITableView    *tableview3;
@property(nonatomic, strong)NSMutableArray *dataArray3;
@property(nonatomic, strong)NSMutableArray *dataArray3id;



@end

@implementation YuanGong_search_ViewController

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
    
    self.dataArray1   = [@[@"男",@"女"]mutableCopy];
    self.dataArray1id = [@[@"M",@"W"]mutableCopy];
    
    
    
    self.tableview1 = [[UITableView alloc]initWithFrame:CGRectMake(90, 215, SCREEN_WIDTH-100, 80)];
    [self.tableview1.layer setBorderColor:[UIColor colorWithWhite:.5 alpha:.5].CGColor];
    [self.tableview1.layer setBorderWidth:1];
    self.tableview1.delegate = self;
    self.tableview1.dataSource = self;
    self.tableview1.hidden = YES;
    [self.tableview1 registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell1"];
    [self.view addSubview:self.tableview1];
    [self.view bringSubviewToFront:self.tableview1];
    
    self.tableview2 = [[UITableView alloc]initWithFrame:CGRectMake(90, 415, SCREEN_WIDTH-100, 250)];
    [self.tableview2.layer setBorderColor:[UIColor colorWithWhite:.5 alpha:.5].CGColor];
    [self.tableview2.layer setBorderWidth:1];
    self.tableview2.delegate = self;
    self.tableview2.dataSource = self;
    self.tableview2.hidden = YES;
    [self.tableview2 registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell2"];
    [self.view addSubview:self.tableview2];
    [self.view bringSubviewToFront:self.tableview2];
    
    self.tableview3 = [[UITableView alloc]initWithFrame:CGRectMake(90, 465, SCREEN_WIDTH-100, 200)];
    [self.tableview3.layer setBorderColor:[UIColor colorWithWhite:.5 alpha:.5].CGColor];
    [self.tableview3.layer setBorderWidth:1];
    self.tableview3.delegate = self;
    self.tableview3.dataSource = self;
    self.tableview3.hidden = YES;
    [self.tableview3 registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell3"];
    [self.view addSubview:self.tableview3];
    [self.view bringSubviewToFront:self.tableview3];
    
    [self lodd];
}


- (void)lodd{
    AFHTTPSessionManager *session = [Manager returnsession];
    NSDictionary *dic = [[NSDictionary alloc]init];
    __weak typeof (self) weakSelf = self;
    dic = @{@"businessId":[Manager redingwenjianming:@"bianhao.text"],
            };
    [session POST:KURLNSString(@"servlet/organization/departmentperson/initpage") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        NSMutableArray *arr1 = [[dic objectForKey:@"rows"] objectForKey:@"departmentList"];
        NSMutableArray *arr2 = [[dic objectForKey:@"rows"] objectForKey:@"departmentPositionList"];
        //NSLog(@"%@",dic);
        [weakSelf.dataArray2 removeAllObjects];
        [weakSelf.dataArray3 removeAllObjects];
        
        
        for (NSDictionary *dict in arr1) {
            PaiDanModel *model = [PaiDanModel mj_objectWithKeyValues:dict];
            [weakSelf.dataArray2 addObject:model];
        }
        
        
        for (NSDictionary *dict in arr2) {
            PaiDanModel *model = [PaiDanModel mj_objectWithKeyValues:dict];
            [weakSelf.dataArray3 addObject:model];
        }
        
        
        [weakSelf.tableview3 reloadData];
        [weakSelf.tableview2 reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:self.tableview1]) {
        self.tableview1.hidden = YES;
        self.text3.text = self.dataArray1[indexPath.row];
        strid1 = self.dataArray1id[indexPath.row];
    }else if ([tableView isEqual:self.tableview2]) {
        self.tableview2.hidden = YES;
        PaiDanModel *model = [self.dataArray2 objectAtIndex:indexPath.row];
        self.text7.text = [NSString stringWithFormat:@"%@ %@",model.departmentCode,model.departmentName];
        strid2 = model.id;
    }else if ([tableView isEqual:self.tableview3]) {
        self.tableview3.hidden = YES;
        PaiDanModel *model = [self.dataArray3 objectAtIndex:indexPath.row];
        self.text8.text = model.positionName;
        strid3 = model.id;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([tableView isEqual:self.tableview1]) {
        return self.dataArray1.count;
    }else if ([tableView isEqual:self.tableview2]) {
        return self.dataArray2.count;
    }
    return self.dataArray3.count;
    
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
        
        PaiDanModel *model = [self.dataArray2 objectAtIndex:indexPath.row];
        
        cell.textLabel.text = [NSString stringWithFormat:@"%@ %@",model.departmentCode,model.departmentName];
        return cell;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell3" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    PaiDanModel *model = [self.dataArray3 objectAtIndex:indexPath.row];
    cell.textLabel.text = model.positionName;
    return cell;
}





- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if ([textField isEqual:self.text3]) {
        [self.text1 resignFirstResponder];
        [self.text2 resignFirstResponder];
        [self.text4 resignFirstResponder];
        [self.text5 resignFirstResponder];
        [self.text6 resignFirstResponder];
        self.tableview2.hidden = YES;
        self.tableview3.hidden = YES;
        if (self.tableview1.hidden == YES) {
            self.tableview1.hidden = NO;
        }else{
            self.tableview1.hidden = YES;
        }
        return NO;
    }
   
    if ([textField isEqual:self.text7]) {
        [self.text1 resignFirstResponder];
        [self.text2 resignFirstResponder];
        [self.text4 resignFirstResponder];
        [self.text5 resignFirstResponder];
        [self.text6 resignFirstResponder];
        self.tableview1.hidden = YES;
        self.tableview3.hidden = YES;
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
        [self.text4 resignFirstResponder];
        [self.text5 resignFirstResponder];
        [self.text6 resignFirstResponder];
        self.tableview1.hidden = YES;
        self.tableview2.hidden = YES;
        if (self.tableview3.hidden == YES) {
            self.tableview3.hidden = NO;
        }else{
            self.tableview3.hidden = YES;
        }
        return NO;
    }
    
    
    self.tableview1.hidden = YES;
    self.tableview2.hidden = YES;
    self.tableview3.hidden = YES;
    return YES;
}

















- (IBAction)clicksearch:(id)sender {
    
    if (self.text1.text.length == 0) {
        self.text1.text = @"";
    }
    if (self.text2.text.length == 0) {
        self.text2.text = @"";
    }
    if (self.text3.text.length == 0) {
        strid1 = @"";
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
        strid2 = @"";
    }
    if (self.text8.text.length == 0) {
        strid3 = @"";
    }
    
    
    YuanGongSearchListViewController *list = [[YuanGongSearchListViewController alloc]init];
    list.str1 = self.text1.text;
    list.str2 = self.text2.text;
    list.str3 = strid1;
    list.str4 = self.text4.text;
    list.str5 = self.text5.text;
    list.str6 = self.text6.text;
    list.str7 = strid2;
    list.str8 = strid3;
    list.navigationItem.title = @"检索信息";
    [self.navigationController pushViewController:list animated:YES];
    
    
}





- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.tableview1.hidden = YES;
    self.tableview2.hidden = YES;
    self.tableview3.hidden = YES;
    
    [self.text1 resignFirstResponder];
    [self.text2 resignFirstResponder];
    [self.text4 resignFirstResponder];
    [self.text5 resignFirstResponder];
    [self.text6 resignFirstResponder];
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


- (NSMutableArray *)dataArray3 {
    if (_dataArray3 == nil) {
        self.dataArray3 = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray3;
}
- (NSMutableArray *)dataArray3id {
    if (_dataArray3id == nil) {
        self.dataArray3id = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray3id;
}

@end
