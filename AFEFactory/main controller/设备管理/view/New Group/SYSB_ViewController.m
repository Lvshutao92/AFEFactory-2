//
//  SYSB_ViewController.m
//  AFEFactory
//
//  Created by ilovedxracer on 2018/1/12.
//  Copyright © 2018年 ilovedxracer. All rights reserved.
//

#import "SYSB_ViewController.h"
#import "WDSB_Cell.h"
#import "PaiDanModel.h"
#import "WebViewController.h"
#import "SYSB_add_edit_ViewController.h"
#import "SYSB_edit_ViewController.h"

#import "Details_01_ViewController.h"
#import "Details_1_1_ViewController.h"
#import "Details_1_2_ViewController.h"
@interface SYSB_ViewController ()<UISearchBarDelegate,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate,UIActionSheetDelegate>
{
    CGFloat height;
    NSInteger page;
    NSInteger totalnum;
    NSString *idstr;
    
    NSString *idstring;
    
    UIView *window;
    UITextField *text1;
    UITextField *text2;
    UITextField *text3;
    UITextField *text4;
    UITextField *text5;
    UITextField *text6;
    UITextField *text7;
    UITextField *text8;
    UILabel *titleLabel;
    NSString *statu1;
    NSString *statu2;
    NSString *statu3;
    NSString *statu4;
    
    
    UIView *bgwindowview;
    UILabel *toplab;
    
    
    
    
    NSString *urlstr;
    
}
@property(nonatomic,strong)UIScrollView *bgview;

@property(nonatomic,strong)NSMutableArray *dataArray;
@property(strong,nonatomic)UITableView    *tableview;


@property(strong,nonatomic)UITableView    *tableview1;
@property(nonatomic,strong)NSMutableArray *dataArray1;



@property(nonatomic,strong)NSMutableArray *arr1;
@property(nonatomic,strong)NSMutableArray *arr2;
@property(nonatomic,strong)NSMutableArray *arr3;
@property(nonatomic,strong)NSMutableArray *arr4;
@end

@implementation SYSB_ViewController

- (void)lod{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"bianhao.text"],
            @"type":@"all",
            };
    [session POST:KURLNSString(@"servlet/equipment/equipment") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
//        NSLog(@"%@",dic);
        [weakSelf.arr1 removeAllObjects];
        if (![[dic objectForKey:@"equipmentCategoryList"] isEqual:[NSNull null]]) {
            NSMutableArray *arr = [dic objectForKey:@"equipmentCategoryList"];
            for (NSDictionary *dic in arr) {
                PaiDanModel *model = [PaiDanModel mj_objectWithKeyValues:dic];
                [weakSelf.arr1 addObject:model];
            }
        }
        
        [weakSelf.arr2 removeAllObjects];
        if (![[dic objectForKey:@"equipmentSupplierList"] isEqual:[NSNull null]]) {
            NSMutableArray *arr = [dic objectForKey:@"equipmentSupplierList"];
            for (NSDictionary *dic in arr) {
                PaiDanModel *model = [PaiDanModel mj_objectWithKeyValues:dic];
                [weakSelf.arr2 addObject:model];
            }
        }
        
        [weakSelf.arr3 removeAllObjects];
        if (![[dic objectForKey:@"departmentPersonList"] isEqual:[NSNull null]]) {
            NSMutableArray *arr = [dic objectForKey:@"departmentPersonList"];
            for (NSDictionary *dic in arr) {
                PaiDanModel *model = [PaiDanModel mj_objectWithKeyValues:dic];
                [weakSelf.arr3 addObject:model];
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}


- (void)clicksearch{
    [text1 resignFirstResponder];
    [text2 resignFirstResponder];
    [text6 resignFirstResponder];
    text1.text = @"";
    text2.text = @"";
    
    text3.text = @"";
    statu1= @"";
    
    text4.text = @"";
    statu2= @"";
    
    text5.text = @"";
    statu3= @"";
    
    text6.text = @"";
    
    text7.text = @"";
    statu4= @"";
    
    text8.text = @"";
    if (window.hidden == YES) {
        window.hidden = NO;
    }else{
        window.hidden = YES;
    }
    
}
- (void)sure{
    [text1 resignFirstResponder];
    [text2 resignFirstResponder];
    [text6 resignFirstResponder];
    if (text1.text.length == 0) {
        text1.text = @"";
    }
    if (text2.text.length == 0) {
        text2.text = @"";
    }
    if (text3.text.length == 0) {
        text3.text = @"";
        statu1= @"";
    }
    if (text4.text.length == 0) {
        text4.text = @"";
        statu2= @"";
    }
    if (text5.text.length == 0) {
        text5.text = @"";
        statu3= @"";
    }
    if (text6.text.length == 0) {
        text6.text = @"";
    }
    if (text7.text.length == 0) {
        text7.text = @"";
        statu4= @"";
    }
    if (text8.text.length == 0) {
        text8.text = @"";
    }
    
    [self setUpReflash];
    window.hidden = YES;
}
- (void)handleClick:(UIButton *)btn{
    [text1 resignFirstResponder];
    [text2 resignFirstResponder];
    [text6 resignFirstResponder];
    if (text1.text.length == 0) {
        text1.text = @"";
    }
    if (text2.text.length == 0) {
        text2.text = @"";
    }
    if (text3.text.length == 0) {
        text3.text = @"";
        statu1= @"";
    }
    if (text4.text.length == 0) {
        text4.text = @"";
        statu2= @"";
    }
    if (text5.text.length == 0) {
        text5.text = @"";
        statu3= @"";
    }
    if (text6.text.length == 0) {
        text6.text = @"";
    }
    if (text7.text.length == 0) {
        text7.text = @"";
        statu4= @"";
    }
    if (text8.text.length == 0) {
        text8.text = @"";
    }
    [self setUpReflash];
    window.hidden = YES;
}



- (void)cancle{
    [text1 resignFirstResponder];
    [text2 resignFirstResponder];
    [text6 resignFirstResponder];
    if (text1.text.length == 0) {
        text1.text = @"";
    }
    if (text2.text.length == 0) {
        text2.text = @"";
    }
    if (text3.text.length == 0) {
        text3.text = @"";
        statu1= @"";
    }
    if (text4.text.length == 0) {
        text4.text = @"";
        statu2= @"";
    }
    if (text5.text.length == 0) {
        text5.text = @"";
        statu3= @"";
    }
    if (text6.text.length == 0) {
        text6.text = @"";
    }
    if (text7.text.length == 0) {
        text7.text = @"";
        statu4= @"";
    }
    if (text8.text.length == 0) {
        text8.text = @"";
    }
    window.hidden = YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if ([textField isEqual:text3]) {
        [text1 resignFirstResponder];
        [text2 resignFirstResponder];
        [text6 resignFirstResponder];
        
        toplab.text = @"设备类别";
        bgwindowview.hidden = NO;
        self.dataArray1 = self.arr1;
        [self.tableview1 reloadData];
        return NO;
    }
    if ([textField isEqual:text4]) {
        [text1 resignFirstResponder];
        [text2 resignFirstResponder];
        [text6 resignFirstResponder];
        
        toplab.text = @"设备状态";
        bgwindowview.hidden = NO;
        self.dataArray1 = self.arr4;
        [self.tableview1 reloadData];
        return NO;
    }
    if ([textField isEqual:text5]) {
        [text1 resignFirstResponder];
        [text2 resignFirstResponder];
        [text6 resignFirstResponder];
        toplab.text = @"设备管理员";
        bgwindowview.hidden = NO;
        self.dataArray1 = self.arr3;
        [self.tableview1 reloadData];
        return NO;
    }
    if ([textField isEqual:text7]) {
        [text1 resignFirstResponder];
        [text2 resignFirstResponder];
        [text6 resignFirstResponder];
        toplab.text = @"设备维修商";
        bgwindowview.hidden = NO;
        self.dataArray1 = self.arr2;
        [self.tableview1 reloadData];
        return NO;
    }
    
    if ([textField isEqual:text8]) {
        [text1 resignFirstResponder];
        [text2 resignFirstResponder];
        [text6 resignFirstResponder];
        KSDatePicker *picker = [[KSDatePicker alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 40, 300)];
        picker.appearance.radius = 5;
        picker.appearance.resultCallBack = ^void(KSDatePicker* datePicker,NSDate* currentDate,KSDatePickerButtonType buttonType){
            if (buttonType == KSDatePickerButtonCommit) {
                NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"yyyy-MM-dd"];
                NSString *str = [formatter stringFromDate:currentDate];
                text8.text = str;
            }
        };
        [window bringSubviewToFront:picker];
        [picker show];
        return NO;
    }
    return YES;
}


















- (void)setupSearchView{
    CGFloat height;
    if ([[[Manager sharedManager] iphoneType] isEqualToString:@"iPhone X"]) {
        height = 88;
    }else{
        height = 64;
    }
    
    window = [[UIView alloc] initWithFrame:CGRectMake(0, height, SCREEN_WIDTH, SCREEN_HEIGHT)];
    window.backgroundColor = [UIColor colorWithWhite:.85 alpha:.5];
    //    window.windowLevel = UIWindowLevelNormal;
    window.alpha = 1.f;
    window.hidden = YES;
    
    
    self.bgview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 0)];
    self.bgview.backgroundColor = [UIColor whiteColor];
    self.bgview.userInteractionEnabled = YES;
    
    UILabel *lab1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 150, 40)];
    lab1.text = @"设备编号";
    [self.bgview addSubview:lab1];
    text1 = [[UITextField alloc] initWithFrame:CGRectMake(10,50, SCREEN_WIDTH-20, 40)];
    text1.delegate = self;
    text1.placeholder = @"请输入设备编号";
    text1.borderStyle = UITextBorderStyleRoundedRect;
    [self.bgview addSubview: text1];
    
    
    
    UILabel *lab2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 100, 100, 40)];
    lab2.text = @"设备名称";
    [self.bgview addSubview:lab2];
    text2 = [[UITextField alloc] initWithFrame:CGRectMake(10, 145, SCREEN_WIDTH-20, 40)];
    text2.delegate = self;
    text2.borderStyle = UITextBorderStyleRoundedRect;
    text2.placeholder = @"请输入设备名称";
    [self.bgview addSubview: text2];
    
    
    UILabel *lab3 = [[UILabel alloc]initWithFrame:CGRectMake(10, 195, SCREEN_WIDTH-20, 40)];
    lab3.text = @"设备类别";
    [self.bgview addSubview:lab3];
    text3 = [[UITextField alloc] initWithFrame:CGRectMake(10, 240, SCREEN_WIDTH-20, 40)];
    text3.delegate = self;
    text3.borderStyle = UITextBorderStyleRoundedRect;
    text3.backgroundColor = [UIColor colorWithWhite:.85 alpha:.3];
    text3.placeholder = @"请选择";
    [self.bgview addSubview: text3];
    
    
    UILabel *lab4 = [[UILabel alloc]initWithFrame:CGRectMake(10, 290, SCREEN_WIDTH-20, 40)];
    lab4.text = @"设备状态";
    [self.bgview addSubview:lab4];
    text4 = [[UITextField alloc] initWithFrame:CGRectMake(10, 335, SCREEN_WIDTH-20, 40)];
    text4.delegate = self;
    text4.borderStyle = UITextBorderStyleRoundedRect;
    text4.placeholder = @"请选择";
    text4.backgroundColor = [UIColor colorWithWhite:.85 alpha:.3];
    [self.bgview addSubview: text4];
    
    
    UILabel *lab5 = [[UILabel alloc]initWithFrame:CGRectMake(10, 385, SCREEN_WIDTH-20, 40)];
    lab5.text = @"设备管理员";
    [self.bgview addSubview:lab5];
    text5 = [[UITextField alloc] initWithFrame:CGRectMake(10, 430, SCREEN_WIDTH-20, 40)];
    text5.delegate = self;
    text5.borderStyle = UITextBorderStyleRoundedRect;
    text5.placeholder = @"请选择";
    text5.backgroundColor = [UIColor colorWithWhite:.85 alpha:.3];
    [self.bgview addSubview: text5];
    
    
    UILabel *lab6 = [[UILabel alloc]initWithFrame:CGRectMake(10,480, SCREEN_WIDTH-20, 40)];
    lab6.text = @"设备使用人";
    [self.bgview addSubview:lab6];
    text6 = [[UITextField alloc] initWithFrame:CGRectMake(10, 525, SCREEN_WIDTH-20, 40)];
    text6.delegate = self;
    text6.borderStyle = UITextBorderStyleRoundedRect;
    text6.placeholder = @"请输入设备使用人";
    [self.bgview addSubview: text6];
    
    
    UILabel *lab7 = [[UILabel alloc]initWithFrame:CGRectMake(10, 575, SCREEN_WIDTH-20, 40)];
    lab7.text = @"设备维修商";
    [self.bgview addSubview:lab7];
    text7 = [[UITextField alloc] initWithFrame:CGRectMake(10, 620, SCREEN_WIDTH-20, 40)];
    text7.delegate = self;
    text7.backgroundColor = [UIColor colorWithWhite:.85 alpha:.3];
    text7.borderStyle = UITextBorderStyleRoundedRect;
    text7.placeholder = @"请选择";
    [self.bgview addSubview: text7];
    
    
    UILabel *lab8 = [[UILabel alloc]initWithFrame:CGRectMake(10, 670, SCREEN_WIDTH-20, 40)];
    lab8.text = @"开始使用时间";
    [self.bgview addSubview:lab8];
    text8 = [[UITextField alloc] initWithFrame:CGRectMake(10, 715, SCREEN_WIDTH-20, 40)];
    text8.delegate = self;
    text8.borderStyle = UITextBorderStyleRoundedRect;
    text8.placeholder = @"请选择";
    text8.backgroundColor = [UIColor colorWithWhite:.85 alpha:.3];
    [self.bgview addSubview: text8];
    
    
    
    self.bgview.frame = CGRectMake(0, 0, self.view.frame.size.width, SCREEN_HEIGHT-199);
    self.bgview.contentSize = CGSizeMake(0, 900);
    [window addSubview:self.bgview];
    
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(SCREEN_WIDTH/2, SCREEN_HEIGHT-200, SCREEN_WIDTH/2, 50);
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:@"确定" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(sure) forControlEvents:UIControlEventTouchUpInside];
    [window addSubview:btn];
    
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(0,SCREEN_HEIGHT-199, SCREEN_WIDTH/2, 49);
    btn1.backgroundColor = [UIColor whiteColor];
    [btn1 setTitle:@"取消" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(cancle) forControlEvents:UIControlEventTouchUpInside];
    [window addSubview:btn1];
    
    
    UILabel *lin = [[UILabel alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-200,SCREEN_WIDTH/2, 1)];
    lin.backgroundColor = [UIColor colorWithWhite:.85 alpha:.3];
    [window addSubview:lin];
    
    [self.view addSubview:window];
    [self.view bringSubviewToFront:window];
    
    [self setUpReflash];
}

- (void)clickadd{
    SYSB_add_edit_ViewController *add = [[SYSB_add_edit_ViewController alloc]init];
    add.navigationItem.title = @"新增";
    [self.navigationController pushViewController:add animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self lod];
    
    statu1 = @"";
    statu2 = @"";
    statu3 = @"";
    statu4 = @"";
    UIBarButtonItem *bar = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(clickadd)];
    UIBarButtonItem *bar2 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(clicksearch)];
    
    self.navigationItem.rightBarButtonItems = @[bar,bar2];
    
    self.arr4 = [@[@"正常",@"停用"]mutableCopy];
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableview registerNib:[UINib nibWithNibName:@"WDSB_Cell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.view addSubview:self.tableview];
    
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    self.tableview.tableHeaderView = v;
    
    
    
    
    [self setupSearchView];
    [self setupErWeiMa];
 
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(save:) name:@"save" object:nil];
}
- (void)save:(NSNotification *)text {
    [self setUpReflash];
}

- (void)setupErWeiMa{
    bgwindowview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    bgwindowview.backgroundColor = [UIColor colorWithWhite:.8 alpha:.5];
    bgwindowview.hidden = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clicktapbgwindowview:)];
    tap.delegate = self;
    [bgwindowview addGestureRecognizer:tap];
    [self.view addSubview:bgwindowview];
    [self.view bringSubviewToFront:bgwindowview];
    
    toplab = [[UILabel alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-400.5, SCREEN_WIDTH, 50)];
    toplab.backgroundColor = [UIColor whiteColor];
    toplab.textAlignment = NSTextAlignmentCenter;
    [bgwindowview addSubview:toplab];
    
    self.tableview1 = [[UITableView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-350, SCREEN_WIDTH, 350)];
    [self.tableview1 registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell1"];
    self.tableview1.delegate = self;
    self.tableview1.dataSource = self;
    [bgwindowview addSubview:self.tableview1];
    
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    self.tableview1.tableFooterView = v;
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UIView"]) {
        return YES;
    }
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UIImageView"]) {
        return YES;
    }
    return NO;
}
- (void)clicktapbgwindowview:(UITapGestureRecognizer *)tap{
    bgwindowview.hidden = YES;
}





#pragma mark - Table view data source
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:self.tableview1]) {

        if ([self.dataArray1 isEqualToArray:self.arr1]) {
            PaiDanModel *model = [self.arr1 objectAtIndex:indexPath.row];
            text3.text = model.name;
            statu1 = model.id;
        }
        if ([self.dataArray1 isEqualToArray:self.arr2]) {
            PaiDanModel *model = [self.arr2 objectAtIndex:indexPath.row];
            text7.text = model.supplierName;
            statu2 = model.id;
        }
        if ([self.dataArray1 isEqualToArray:self.arr3]) {
            PaiDanModel *model = [self.arr3 objectAtIndex:indexPath.row];
            text5.text = model.realName;
            statu3 = model.id;
        }
        if ([self.dataArray1 isEqualToArray:self.arr4]) {
            text4.text = [self.arr4 objectAtIndex:indexPath.row];
            if ([text4.text isEqualToString:@"正常"]) {
                statu4 = @"A";
            }else if ([text7.text isEqualToString:@"停用"]) {
                statu4 = @"B";
            }
        }
        bgwindowview.hidden = YES;
    
    }
    if ([tableView isEqual:self.tableview]) {
        Details_01_ViewController *vc = [[Details_01_ViewController alloc] initWithAddVCARY:@[[Details_1_1_ViewController new],[Details_1_2_ViewController new]] TitleS:@[@"维修记录",@"保养记录"]];
        PaiDanModel *model = [self.dataArray objectAtIndex:indexPath.row];
        
        NSDictionary *dict = [[NSDictionary alloc]init];
        dict = @{@"idstring":model.id};
        NSNotification *notification =[NSNotification notificationWithName:@"wdsb" object:nil userInfo:dict];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        
        [self.navigationController pushViewController:vc animated:YES];
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([tableView isEqual:self.tableview1]) {
        return self.dataArray1.count;
    }
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:self.tableview1]) {
        return 50;
    }
    return 670;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView isEqual:self.tableview1]) {
        if ([self.dataArray1 isEqualToArray:self.arr1]) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            PaiDanModel *model = [self.arr1 objectAtIndex:indexPath.row];
            cell.textLabel.text = model.name;
            return cell;
        }
        if ([self.dataArray1 isEqualToArray:self.arr2]) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            PaiDanModel *model = [self.arr2 objectAtIndex:indexPath.row];
            cell.textLabel.text = model.supplierName;
            return cell;
        }
        if ([self.dataArray1 isEqualToArray:self.arr3]) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            PaiDanModel *model = [self.arr3 objectAtIndex:indexPath.row];
            cell.textLabel.text = model.realName;
            return cell;
        }
        if ([self.dataArray1 isEqualToArray:self.arr4]) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.text = [self.arr4 objectAtIndex:indexPath.row];
            return cell;
        }
    }
    
    static NSString *identifierCell = @"cell";
    WDSB_Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
    if (cell == nil) {
        cell = [[WDSB_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    PaiDanModel *model = [self.dataArray objectAtIndex:indexPath.row];
    
//    LRViewBorderRadius(cell.img1, 0, 1, [UIColor colorWithWhite:.85 alpha:.3]);
//    LRViewBorderRadius(cell.img2, 0, 1, [UIColor colorWithWhite:.85 alpha:.3]);
    
    [cell.img1 sd_setImageWithURL:[NSURL URLWithString:NSString(model.field3)]placeholderImage:[UIImage imageNamed:@"logo"]];
    [cell.img2 sd_setImageWithURL:[NSURL URLWithString:NSString(model.field4)]placeholderImage:[UIImage imageNamed:@"logo"]];
    
    
    cell.img1.contentMode = UIViewContentModeScaleAspectFit;
    cell.img2.contentMode = UIViewContentModeScaleAspectFit;
    
    cell.lab1.text  = model.equipmentNo;
    cell.lab2.text  = model.equipmentName;
    cell.lab3.text  = model.equipmentColor;

    cell.lab4.text  = model.equipmentCategory_model.name;
    
    
    
    if (model.field1 == nil) {
        cell.lab5.text  = @"-";
    }else{
        cell.lab5.text  = model.field1;
    }

    
    for (PaiDanModel *model1 in self.arr3) {
        if ([model.equipmentManager isEqualToString:model1.id]) {
            cell.lab6.text  = model1.realName;
        }
    }
    
    
    
    
    
    
    cell.lab7.text  = model.field2;


    if (model.equipmentSupplier == nil) {
        cell.lab8.text  = @"-";
    }else{
        cell.lab8.text  = model.equipmentSupplier_model.supplierName;
    }

    cell.lab9.text  = model.equipmentUseTime;



    if ([model.equipmentStatus isEqualToString:@"A"]) {
        cell.lab10.text = @"正常";
        cell.lab10.textColor = [UIColor blueColor];
    }else if ([model.equipmentStatus isEqualToString:@"B"]) {
        cell.lab10.text = @"停用";
        cell.lab10.textColor = [UIColor redColor];
    }else if ([model.equipmentStatus isEqualToString:@"C"]) {
        cell.lab10.text = @"维修中";
        cell.lab10.textColor = RGBACOLOR(37,167,159, 1);
    }
    
    
    
    LRViewBorderRadius(cell.btn1, 15, 1, [UIColor blackColor]);
    LRViewBorderRadius(cell.btn2, 15, 1, [UIColor blackColor]);
    LRViewBorderRadius(cell.btn3, 15, 1, [UIColor blackColor]);
    [cell.btn1 setTitle:@"删除" forState:UIControlStateNormal];
    [cell.btn2 setTitle:@"修改" forState:UIControlStateNormal];
    [cell.btn3 setTitle:@"设备详情" forState:UIControlStateNormal];
    [cell.btn3 addTarget:self action:@selector(clickbtn3:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btn2 addTarget:self action:@selector(clickbtn2:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btn1 addTarget:self action:@selector(clickbtn1:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

- (void)clickbtn1:(UIButton *)sender{
    WDSB_Cell *cell = (WDSB_Cell *)[[sender superview] superview];
    NSIndexPath *indexpath = [self.tableview indexPathForCell:cell];
    PaiDanModel *model = [self.dataArray objectAtIndex:indexpath.row];
    
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"bianhao.text"],
            @"id":model.id,
            };
    [session POST:KURLNSString(@"servlet/equipment/equipment/delete") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        //        NSLog(@"----------%@",dic);
        if ([[dic objectForKey:@"code"] isEqualToString:@"success"]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"删除成功！" message:@"温馨提示" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                [weakSelf.dataArray removeObjectAtIndex:indexpath.row];
                [weakSelf.tableview deleteRowsAtIndexPaths:[NSMutableArray arrayWithObject:indexpath] withRowAnimation:UITableViewRowAnimationAutomatic];
            }];
            [alert addAction:cancel];
            [weakSelf presentViewController:alert animated:YES completion:nil];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}
- (void)clickbtn2:(UIButton *)sender{
    WDSB_Cell *cell = (WDSB_Cell *)[[sender superview] superview];
    NSIndexPath *indexpath = [self.tableview indexPathForCell:cell];
    PaiDanModel *model = [self.dataArray objectAtIndex:indexpath.row];
    
    SYSB_edit_ViewController *xiugai = [[SYSB_edit_ViewController alloc]init];
    xiugai.navigationItem.title = @"修改";
    xiugai.idstr = model.id;
    
   
    xiugai.str1   = model.equipmentCategory_model.name;
    xiugai.str1id = model.equipmentCategory_model.id;

    xiugai.str2 = model.equipmentNo;

    xiugai.str3 = model.equipmentName;

    xiugai.str4 = model.equipmentColor;
    
    
    
    for (PaiDanModel *model1 in self.arr3) {
        if ([model.equipmentManager isEqualToString:model1.id]) {
            xiugai.str5    = model1.realName;
            xiugai.str5id  = model1.id;
        }
    }
    

    
    
    
    xiugai.str6 = model.field2;

    xiugai.str7    = model.equipmentSupplier_model.supplierName;
    xiugai.str7id  = model.equipmentSupplier_model.id;

    xiugai.str8 = model.equipmentUseTime;
   
    if ([model.equipmentStatus isEqualToString:@"A"]) {
        xiugai.str9   = @"正常";
        xiugai.str9id = model.equipmentStatus;
    }else if ([model.equipmentStatus isEqualToString:@"B"]) {
        xiugai.str9   = @"停用";
        xiugai.str9id = model.equipmentStatus;
    }
//
//    
    xiugai.imgs1 = NSString(model.field3);
    xiugai.imgs2 = NSString(model.field4);
    
    
    [self.navigationController pushViewController:xiugai animated:YES];
}

- (void)clickbtn3:(UIButton *)sender{
    WDSB_Cell *cell = (WDSB_Cell *)[[sender superview] superview];
    NSIndexPath *indexpath = [self.tableview indexPathForCell:cell];
    PaiDanModel *model = [self.dataArray objectAtIndex:indexpath.row];
    
    WebViewController *web = [[WebViewController alloc]init];
    web.navigationItem.title = @"设备详情";
    web.webStr = KNSString(model.id);
    web.str = @"111";
    [self.navigationController pushViewController:web animated:YES];

}

//刷新数据
-(void)setUpReflash
{
    __weak typeof (self) weakSelf = self;
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loddeList];
    }];
    [self.tableview.mj_header beginRefreshing];
    self.tableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        if (self.dataArray.count == totalnum) {
            [self.tableview.mj_footer setState:MJRefreshStateNoMoreData];
        }else {
            [weakSelf loddeSLList];
        }
    }];
}
- (void)loddeList{
    [self.tableview.mj_footer endRefreshing];
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    page = 1;
    dic = @{@"businessId":[Manager redingwenjianming:@"bianhao.text"],
            @"page":[NSString stringWithFormat:@"%ld",page],
            @"sorttype":@"asc",
            @"sort":@"undefined",
            
            @"equipmentNo":text1.text,
            @"equipmentName":text2.text,
            @"equipmentCategoryId":statu1,
            @"equipmentStatus":statu4,
            
            @"equipmentManager":statu3,
            @"field2":text6.text,
            @"equipmentSupplierId":statu2,
            @"equipmentUseTime":text8.text,
            };
    [session POST:KURLNSString(@"servlet/equipment/equipment/list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
//        NSLog(@"gu----%@",dic);
        totalnum = [[dic objectForKey:@"total"] integerValue];
        [weakSelf.dataArray removeAllObjects];
        if (![[dic objectForKey:@"rows"]isEqual:[NSNull null]]) {
            NSMutableArray *arr = [dic objectForKey:@"rows"];
            for (NSDictionary *dict in arr) {
                PaiDanModel *model = [PaiDanModel mj_objectWithKeyValues:dict];
                PaidanModel1 *model1 = [PaidanModel1 mj_objectWithKeyValues:model.equipmentSupplier];
                model.equipmentSupplier_model = model1;
                
                PaidanModel1 *model2 = [PaidanModel1 mj_objectWithKeyValues:model.equipmentCategory];
                model.equipmentCategory_model = model2;
                
                PaidanModel1 *model3 = [PaidanModel1 mj_objectWithKeyValues:model.departmentPerson];
                model.departmentPerson_model = model3;
                
                [weakSelf.dataArray addObject:model];
            }
        }
        page = 2;
        [weakSelf.tableview reloadData];
        [weakSelf.tableview.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakSelf.tableview.mj_header endRefreshing];
    }];
}
- (void)loddeSLList{
    [self.tableview.mj_header endRefreshing];
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"bianhao.text"],
            @"page":[NSString stringWithFormat:@"%ld",page],
            @"sorttype":@"asc",
            @"sort":@"undefined",
            
            @"equipmentNo":text1.text,
            @"equipmentName":text2.text,
            @"equipmentCategoryId":statu1,
            @"equipmentStatus":statu4,
            
            @"equipmentManager":statu3,
            @"field2":text6.text,
            @"equipmentSupplierId":statu2,
            @"equipmentUseTime":text8.text,
            };
    [session POST:KURLNSString(@"servlet/equipment/equipment/list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        if (![[dic objectForKey:@"rows"]isEqual:[NSNull null]]) {
            NSMutableArray *arr = [dic objectForKey:@"rows"];
            for (NSDictionary *dict in arr) {
                PaiDanModel *model = [PaiDanModel mj_objectWithKeyValues:dict];
                PaidanModel1 *model1 = [PaidanModel1 mj_objectWithKeyValues:model.equipmentSupplier];
                model.equipmentSupplier_model = model1;
                PaidanModel1 *model2 = [PaidanModel1 mj_objectWithKeyValues:model.equipmentCategory];
                model.equipmentCategory_model = model2;
                
                PaidanModel1 *model3 = [PaidanModel1 mj_objectWithKeyValues:model.departmentPerson];
                model.departmentPerson_model = model3;
                [weakSelf.dataArray addObject:model];
            }
        }
        page++;
        [weakSelf.tableview reloadData];
        [weakSelf.tableview.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakSelf.tableview.mj_footer endRefreshing];
    }];
}
- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        self.dataArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray;
}
- (NSMutableArray *)dataArray1 {
    if (_dataArray1 == nil) {
        self.dataArray1 = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray1;
}

- (NSMutableArray *)arr1{
    if (_arr1== nil) {
        self.arr1 = [NSMutableArray arrayWithCapacity:1];
    }
    return _arr1;
}
- (NSMutableArray *)arr2{
    if (_arr2== nil) {
        self.arr2 = [NSMutableArray arrayWithCapacity:1];
    }
    return _arr2;
}
- (NSMutableArray *)arr3{
    if (_arr3== nil) {
        self.arr3 = [NSMutableArray arrayWithCapacity:1];
    }
    return _arr3;
}
- (NSMutableArray *)arr4{
    if (_arr4== nil) {
        self.arr4 = [NSMutableArray arrayWithCapacity:1];
    }
    return _arr4;
}
@end
