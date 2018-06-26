//
//  YHPLB_ViewController.m
//  AFEFactory
//
//  Created by ilovedxracer on 2017/12/12.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "YHPLB_ViewController.h"
#import "YuanGong_Cell.h"

#import "PaiDanModel.h"
#import "PaidanModel1.h"
@interface YHPLB_ViewController ()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate,UITextFieldDelegate>
{
    CGFloat height;
    NSInteger page;
    NSInteger totalnum;
    
    UIView *window;
    UITextField *text1;
    UITextField *text2;
    UITextField *text3;
    UITextField *text4;
    UITextField *text5;
    
    NSString *idstring;
  
    UIView *bgwindowview;
    UILabel *bglab;
}
@property(nonatomic,strong)UIScrollView *bgview;
@property(nonatomic,strong)UILabel *toplab;
@property(nonatomic,strong)NSMutableArray *dataArray1;
@property(strong,nonatomic)UITableView    *tableview1;


@property(nonatomic, strong)UITableView *tableview;
@property(nonatomic, strong)NSMutableArray *dataArray;

@end

@implementation YHPLB_ViewController




- (void)setrespos{
    [text1 resignFirstResponder];
    [text2 resignFirstResponder];
    [text3 resignFirstResponder];
    [text4 resignFirstResponder];
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if ([textField isEqual:text5]) {
        [self setrespos];
        bglab.text = @"类别";
        bgwindowview.hidden = NO;
        return NO;
    }
    return YES;
}
- (void)cancle{
    [self setrespos];
    text1.text = @"";
    text2.text = @"";
    text3.text = @"";
    text4.text = @"";
    text5.text = @"";
    idstring = @"";
    window.hidden = YES;
}
- (void)sure{
    [self setrespos];
    if (text1.text.length == 0) {
        text1.text = @"";
    }
    if (text2.text.length == 0) {
        text2.text = @"";
    }
    if (text3.text.length == 0) {
        text3.text = @"";
    }
    if (text4.text.length == 0) {
        text4.text = @"";
    }
    if (text5.text.length == 0) {
        text5.text = @"";
    }
    if (idstring.length == 0) {
        idstring = @"";
    }
    [self setUpReflash];
    window.hidden = YES;
}
- (void)clicksearch{
    [self setrespos];
    text1.text = @"";
    text2.text = @"";
    text3.text = @"";
    text4.text = @"";
    text5.text = @"";
    idstring = @"";
    if (window.hidden == YES) {
        window.hidden = NO;
    }else{
        window.hidden = YES;
    }
}
- (void)setupButton {
    
    CGFloat height;
    if ([[[Manager sharedManager] iphoneType] isEqualToString:@"iPhone X"]) {
        height = 88;
    }else{
        height = 64;
    }
    
    window = [[UIView alloc] initWithFrame:CGRectMake(0, height, SCREEN_WIDTH, SCREEN_HEIGHT)];
    window.backgroundColor = [UIColor colorWithWhite:.85 alpha:.5];
    //window.windowLevel = UIWindowLevelNormal;
    window.alpha = 1.f;
    window.hidden = YES;
    
    
    self.bgview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 0)];
    self.bgview.backgroundColor = [UIColor whiteColor];
    self.bgview.userInteractionEnabled = YES;
    
    UILabel *lab1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 150, 40)];
    lab1.text = @"编号";
    [self.bgview addSubview:lab1];
    text1 = [[UITextField alloc] initWithFrame:CGRectMake(10,50, SCREEN_WIDTH-20, 40)];
    text1.delegate = self;
    text1.text= @"";
    text1.placeholder = @"请输入编号";
    text1.borderStyle = UITextBorderStyleRoundedRect;
    [self.bgview addSubview: text1];
    
    UILabel *lab2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 100, 100, 40)];
    lab2.text = @"名称";
    [self.bgview addSubview:lab2];
    text2 = [[UITextField alloc] initWithFrame:CGRectMake(10, 145, SCREEN_WIDTH-20, 40)];
    text2.delegate = self;
    text2.borderStyle = UITextBorderStyleRoundedRect;
    text2.text= @"";
    text2.placeholder = @"请输入名称";
    
    [self.bgview addSubview: text2];
    
    UILabel *lab3 = [[UILabel alloc]initWithFrame:CGRectMake(10, 195, 150, 40)];
    lab3.text = @"品牌";
    [self.bgview addSubview:lab3];
    text3 = [[UITextField alloc] initWithFrame:CGRectMake(10,240, SCREEN_WIDTH-20, 40)];
    text3.delegate = self;
    text3.text= @"";
    text3.placeholder = @"请输入品牌";
    text3.borderStyle = UITextBorderStyleRoundedRect;
    [self.bgview addSubview: text3];
    
    UILabel *lab4 = [[UILabel alloc]initWithFrame:CGRectMake(10, 290, 150, 40)];
    lab4.text = @"规格";
    [self.bgview addSubview:lab4];
    text4 = [[UITextField alloc] initWithFrame:CGRectMake(10,335, SCREEN_WIDTH-20, 40)];
    text4.delegate = self;
    text4.text= @"";
    text4.placeholder = @"请输入规格";
    text4.borderStyle = UITextBorderStyleRoundedRect;
    [self.bgview addSubview: text4];
    
    UILabel *lab5 = [[UILabel alloc]initWithFrame:CGRectMake(10, 385, 150, 40)];
    lab5.text = @"类别";
    [self.bgview addSubview:lab5];
    text5 = [[UITextField alloc] initWithFrame:CGRectMake(10,430, SCREEN_WIDTH-20, 40)];
    text5.delegate = self;
    text5.text= @"";
    text5.placeholder = @"请选择";
    text5.borderStyle = UITextBorderStyleRoundedRect;
    [self.bgview addSubview: text5];
    
    
    text5.backgroundColor = [UIColor colorWithWhite:.85 alpha:.4];
   
    
    self.bgview.frame = CGRectMake(0, 0, self.view.frame.size.width, SCREEN_HEIGHT-199);
    self.bgview.contentSize = CGSizeMake(0, 700);
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
- (void)setupview_tableview{
    bgwindowview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    bgwindowview.backgroundColor = [UIColor colorWithWhite:.8 alpha:.5];
    bgwindowview.hidden = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clicktapbgwindowview:)];
    tap.delegate = self;
    [bgwindowview addGestureRecognizer:tap];
    [self.view addSubview:bgwindowview];
    [self.view bringSubviewToFront:bgwindowview];
    
    bglab = [[UILabel alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-400.5, SCREEN_WIDTH, 50)];
    bglab.backgroundColor = [UIColor whiteColor];
    bglab.textAlignment = NSTextAlignmentCenter;
    [bgwindowview addSubview:bglab];
    
    self.tableview1 = [[UITableView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-350, SCREEN_WIDTH, 350)];
    [self.tableview1 registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cells"];
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
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UILabel"]) {
        return YES;
    }
    return NO;
}
- (void)clicktapbgwindowview:(UITapGestureRecognizer *)tap{
    bgwindowview.hidden = YES;
}


- (void)lodd{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"bianhao.text"],
            };
    [session POST:KURLNSString(@"servlet/officegoods/officegoodsconsumable") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
//        NSLog(@"-------%@",dic);
        
        
        [weakSelf.dataArray1 removeAllObjects];
        if (![[dic objectForKey:@"types"] isEqual:[NSNull null]]) {
            NSMutableArray *arr = [dic objectForKey:@"types"];
            for (NSDictionary *dict in arr) {
                PaiDanModel *model = [PaiDanModel mj_objectWithKeyValues:dict];
                [weakSelf.dataArray1 addObject:model];
            }
        }
        [weakSelf.tableview1 reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
    
    
}










- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    idstring = @"";
    
    UIBarButtonItem *bar = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(clicksearch)];
    self.navigationItem.rightBarButtonItem = bar;
    
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableview registerNib:[UINib nibWithNibName:@"YuanGong_Cell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableview];
    
    
    [self setupButton];
    [self setupview_tableview];
    [self lodd];
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:self.tableview1]) {
        PaiDanModel *model = [self.dataArray1 objectAtIndex:indexPath.row];
        text5.text = model.name;
        idstring = model.id;
        bgwindowview.hidden = YES;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:self.tableview1]) {
        return 60;
    }
    return 185;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([tableView isEqual:self.tableview1]) {
        return self.dataArray1.count;
    }
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:self.tableview1]) {
        static NSString *identifierCell = @"cells";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        PaiDanModel *model = [self.dataArray1 objectAtIndex:indexPath.row];
        cell.textLabel.text = model.name;
        return cell;
    }
    static NSString *identifierCell = @"cell";
    YuanGong_Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
    if (cell == nil) {
        cell = [[YuanGong_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.lab6.hidden  = YES;
    cell.lab7.hidden  = YES;
    cell.lab8.hidden  = YES;
    cell.lab9.hidden  = YES;
    cell.lab10.hidden = YES;
    cell.lab11.hidden = YES;
    cell.lab12.hidden = YES;
    cell.line.hidden  = YES;
    cell.btn.hidden   = YES;
    cell.btn1.hidden   = YES;
    PaiDanModel *model = [self.dataArray objectAtIndex:indexPath.row];
    
    [cell.img sd_setImageWithURL:[NSURL URLWithString:NSString(model.picture)]placeholderImage:[UIImage imageNamed:@"user"]];
    cell.img.contentMode = UIViewContentModeScaleAspectFit;

    cell.lab1.text = [NSString stringWithFormat:@"编号：%@",model.code];



    
    cell.lab2.text = [NSString stringWithFormat:@"名称：%@",model.name];

    cell.lab3.text = [NSString stringWithFormat:@"品牌：%@",model.brand];
  
    
    cell.lab4.text = [NSString stringWithFormat:@"规格：%@",model.standard];


   


  
    cell.lab5.text = [NSString stringWithFormat:@"库存：%@     单位：%@",model.stock,model.unit];
    

    
    
    return cell;
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
            @"departmentPersonSessionId":[Manager redingwenjianming:@"id.text"],
            @"page":[NSString stringWithFormat:@"%ld",page],
            @"sorttype":@"asc",
            @"sort":@"code",
            
            @"code":text1.text,
            @"name":text2.text,
            @"brand":text3.text,
            @"standard":text4.text,
            @"durableTypeId":idstring,
            };
    [session POST:KURLNSString(@"servlet/officegoods/officegoodsconsumable/list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
//        NSLog(@"%@",dic);
        totalnum = [[dic objectForKey:@"total"] integerValue];
        [weakSelf.dataArray removeAllObjects];
        if (![[dic objectForKey:@"rows"] isEqual:[NSNull null]]) {
            NSMutableArray *arr = [dic objectForKey:@"rows"];
            for (NSDictionary *dict in arr) {
                PaiDanModel *model = [PaiDanModel mj_objectWithKeyValues:dict];
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
            @"departmentPersonSessionId":[Manager redingwenjianming:@"id.text"],
            @"page":[NSString stringWithFormat:@"%ld",page],
            @"sorttype":@"asc",
            @"sort":@"code",
            
            @"code":text1.text,
            @"name":text2.text,
            @"brand":text3.text,
            @"standard":text4.text,
            @"durableTypeId":idstring,
            };
    [session POST:KURLNSString(@"servlet/officegoods/officegoodsconsumable/list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dic = [Manager returndictiondata:responseObject];

        if (![[dic objectForKey:@"rows"] isEqual:[NSNull null]]) {
            NSMutableArray *arr = [dic objectForKey:@"rows"];
            for (NSDictionary *dict in arr) {
                PaiDanModel *model = [PaiDanModel mj_objectWithKeyValues:dict];
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

@end
