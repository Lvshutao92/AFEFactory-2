//
//  SYDJ_search_ViewController.m
//  Factory
//
//  Created by ilovedxracer on 2017/11/22.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "SYDJ_search_ViewController.h"
#import "SYDJ_search_list_ViewController.h"
#import "XZ_SYDJ_search_list_ViewController.h"
@interface SYDJ_search_ViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NSString *status;
}
@property(nonatomic, strong)UITableView *tableview1;
@property(nonatomic, strong)NSMutableArray *dataArray;
@property(nonatomic, strong)NSMutableArray *dataArrayid;
@end

@implementation SYDJ_search_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"检索";
    LRViewBorderRadius(self.btn, 5, 0, [UIColor whiteColor]);
    self.text1.delegate = self;
    self.text2.delegate = self;
    self.text3.delegate = self;
    self.text4.delegate = self;
    self.text5.delegate = self;
    
    self.tableview1 = [[UITableView alloc]initWithFrame:CGRectMake(120, 315, SCREEN_WIDTH-130, 180)];
    [self.tableview1.layer setBorderColor:[UIColor colorWithWhite:.5 alpha:.5].CGColor];
    [self.tableview1.layer setBorderWidth:1];
    self.tableview1.delegate = self;
    self.tableview1.dataSource = self;
    self.tableview1.hidden = YES;
    [self.tableview1 registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableview1];
    [self.view bringSubviewToFront:self.tableview1];
    
    self.dataArray = [@[@"待生产",@"生产中",@"已完成",@"已入库"]mutableCopy];
    self.dataArrayid = [@[@"create",@"producting",@"producted",@"finished"]mutableCopy];
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     self.tableview1.hidden = YES;
     self.text5.text = self.dataArray[indexPath.row];
     status = self.dataArrayid[indexPath.row];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.text1 resignFirstResponder];
    [self.text2 resignFirstResponder];
    [self.text4 resignFirstResponder];
    [self.text2 resignFirstResponder];
}




- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if ([textField isEqual:self.text5]) {
        [self.text1 resignFirstResponder];
        [self.text2 resignFirstResponder];
        [self.text4 resignFirstResponder];
        if (self.tableview1.hidden == YES) {
            self.tableview1.hidden = NO;
        }else{
            self.tableview1.hidden = YES;
        }
        return NO;
    }
    if ([textField isEqual:self.text3]) {
        [self.text1 resignFirstResponder];
        [self.text2 resignFirstResponder];
        [self.text4 resignFirstResponder];
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






- (NSMutableArray *)dataArrayid {
    if (_dataArrayid == nil) {
        self.dataArrayid = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArrayid;
}
- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        self.dataArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray;
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
    if (self.text4.text.length == 0) {
        self.text4.text = @"";
    }
    if (status.length == 0) {
        status = @"";
    }
    
    if ([self.str isEqualToString:@"xzsydj"]) {
        XZ_SYDJ_search_list_ViewController *list = [[XZ_SYDJ_search_list_ViewController alloc]init];
        list.text1 = self.text1.text;
        list.text2 = self.text2.text;
        list.text3 = self.text3.text;
        list.text4 = self.text4.text;
        list.text5 = status;
        [self.navigationController pushViewController:list animated:YES];
    }else{
        SYDJ_search_list_ViewController *list = [[SYDJ_search_list_ViewController alloc]init];
        list.text1 = self.text1.text;
        list.text2 = self.text2.text;
        list.text3 = self.text3.text;
        list.text4 = self.text4.text;
        list.text5 = status;
        [self.navigationController pushViewController:list animated:YES];
    }
    
    
    
    
    
}

@end
