//
//  HCCKD_search_ViewController.m
//  Factory
//
//  Created by ilovedxracer on 2017/11/27.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "HCCKD_search_ViewController.h"
#import "HCCKD_search_list_ViewController.h"
@interface HCCKD_search_ViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NSString *status;
}
@property(nonatomic, strong)UITableView *tableview1;
@property(nonatomic, strong)NSMutableArray *dataArray;
@property(nonatomic, strong)NSMutableArray *dataArrayid;
@end

@implementation HCCKD_search_ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"检索";
    LRViewBorderRadius(self.btn, 5, 0, [UIColor whiteColor]);
    self.text1.delegate = self;
    self.text2.delegate = self;
   
    self.dataArray   = [@[@"已创建",@"已出库",@"已作废"]mutableCopy];
    self.dataArrayid = [@[@"created",@"finished",@"cancelled"]mutableCopy];
    
    self.tableview1 = [[UITableView alloc]initWithFrame:CGRectMake(130, 165, SCREEN_WIDTH-140, 150)];
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
    self.text2.text = self.dataArray[indexPath.row];
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
    if ([textField isEqual:self.text2]) {
        [self.text1 resignFirstResponder];
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
    if (status.length == 0) {
        status = @"";
    }
    HCCKD_search_list_ViewController *list = [[HCCKD_search_list_ViewController alloc]init];
    list.str1 = self.text1.text;
    list.str2 = status;
    list.navigationItem.title = @"检索信息";
    [self.navigationController pushViewController:list animated:YES];
}




@end
