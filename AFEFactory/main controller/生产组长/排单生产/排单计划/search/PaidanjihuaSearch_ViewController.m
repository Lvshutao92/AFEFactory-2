//
//  PaidanjihuaSearch_ViewController.m
//  Factory
//
//  Created by ilovedxracer on 2017/11/22.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "PaidanjihuaSearch_ViewController.h"
#import "PaiDanModel.h"
#import "PDJH_search_list_ViewController.h"
@interface PaidanjihuaSearch_ViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong)UITableView *tableview1;
@property(nonatomic, strong)NSMutableArray *dataArray;
@end

@implementation PaidanjihuaSearch_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"检索";
    LRViewBorderRadius(self.btn, 5, 0, [UIColor whiteColor]);
    self.text1.delegate = self;
    self.text2.delegate = self;
    self.text3.delegate = self;
    
    self.tableview1 = [[UITableView alloc]initWithFrame:CGRectMake(110, 115, SCREEN_WIDTH-120, 250)];
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
- (IBAction)clickButtonSearch:(id)sender {
    if (self.text1.text.length == 0) {
        self.text1.text = @"";
    }
    if (self.text2.text.length == 0) {
        self.text2.text = @"";
    }
    if (self.text3.text.length == 0) {
        self.text3.text = @"";
    }
    PDJH_search_list_ViewController *list = [[PDJH_search_list_ViewController alloc]init];
    list.text1 = self.text1.text;
    list.text2 = self.text2.text;
    list.text3 = self.text3.text;
    [self.navigationController pushViewController:list animated:YES];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.tableview1.hidden = YES;
    PaiDanModel *model = self.dataArray[indexPath.row];
    self.text1.text = model.dealerName;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    PaiDanModel *model = self.dataArray[indexPath.row];
    cell.textLabel.text = model.dealerName;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


- (void)lodd{
    AFHTTPSessionManager *session = [Manager returnsession];
    NSDictionary *dic = [[NSDictionary alloc]init];
    __weak typeof (self) weakSelf = self;
    dic = @{@"businessId":[Manager redingwenjianming:@"bianhao.text"],
            };
    [session POST:KURLNSString(@"servlet/production/productionplan") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"dealerList"];
        //NSLog(@"%@",dic);
        [weakSelf.dataArray removeAllObjects];
        for (NSDictionary *dict in arr) {
            PaiDanModel *model = [PaiDanModel mj_objectWithKeyValues:dict];
            [weakSelf.dataArray addObject:model];
        }
        
        [weakSelf.tableview1 reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}



- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    self.tableview1.hidden = YES;
    [self.text2 resignFirstResponder];
}




- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if ([textField isEqual:self.text1]) {
        [self.text2 resignFirstResponder];
        if (self.tableview1.hidden == YES) {
            self.tableview1.hidden = NO;
        }else{
            self.tableview1.hidden = YES;
        }
        return NO;
    }
    if ([textField isEqual:self.text3]) {
        [self.text2 resignFirstResponder];
        self.tableview1.hidden = YES;
        KSDatePicker* picker = [[KSDatePicker alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 40, 300)];
        picker.appearance.radius = 5;
        picker.appearance.resultCallBack = ^void(KSDatePicker* datePicker,NSDate* currentDate,KSDatePickerButtonType buttonType){
            if (buttonType == KSDatePickerButtonCommit) {
                NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"yyyy-MM-dd"];
                NSString *str = [formatter stringFromDate:currentDate];
                self.text3.text = str;
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
@end
