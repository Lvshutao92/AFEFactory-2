//
//  MoneyViewController.m
//  AFEFactory
//
//  Created by ilovedxracer on 2018/1/10.
//  Copyright © 2018年 ilovedxracer. All rights reserved.
//

#import "MoneyViewController.h"
#import "PaiDanModel.h"
#import "Paidan_5_Cell.h"
@interface MoneyViewController ()<AAChartViewDidFinishLoadDelegate,UITextFieldDelegate,UIGestureRecognizerDelegate,UITableViewDelegate,UITableViewDataSource>

{
    CGFloat tot;
    
    UIView *window;
    UITextField *text1;
    NSString *idstring;
    
    UIView *bgwindowview;
    UILabel *bglab;
}
@property(nonatomic,strong)UIScrollView *bgview;
@property(nonatomic,strong)UILabel *toplab;




@property (nonatomic, strong) AAChartModel *aaChartModel;
@property (nonatomic, strong) AAChartView  *aaChartView;

@property(nonatomic,strong)NSMutableArray *searchArray;

@property(nonatomic,strong)NSMutableArray *dataArray;
@property(strong,nonatomic)UITableView    *tableView;

@property(strong,nonatomic)UITableView    *tableview1;
@property(nonatomic,strong)NSMutableArray *dataArray1;
@end

@implementation MoneyViewController

- (void)setupButton {
    CGFloat height;
    if ([[[Manager sharedManager] iphoneType] isEqualToString:@"iPhone X"]) {
        height = 88;
    }else{
        height = 64;
    }
    
    window = [[UIView alloc] initWithFrame:CGRectMake(0, height, SCREEN_WIDTH, SCREEN_HEIGHT)];
    window.backgroundColor = [UIColor colorWithWhite:.85 alpha:.5];
    window.alpha = 1.f;
    window.hidden = YES;
    
    self.bgview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 0)];
    self.bgview.backgroundColor = [UIColor whiteColor];
    self.bgview.userInteractionEnabled = YES;
    
    UILabel *lab1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 150, 40)];
    lab1.text = @"计件年月";
    [self.bgview addSubview:lab1];
    text1 = [[UITextField alloc] initWithFrame:CGRectMake(10,50, SCREEN_WIDTH-20, 40)];
    text1.delegate = self;
    text1.placeholder = @"请输入计件年月";
    text1.borderStyle = UITextBorderStyleRoundedRect;
    [self.bgview addSubview: text1];
    
    self.bgview.frame = CGRectMake(0, 0, self.view.frame.size.width, SCREEN_HEIGHT-199);
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
    
    [self lodinit];
}
- (void)cancle{
    text1.text = @"";
    idstring = @"";
    window.hidden = YES;
}

- (void)sure{
    if (text1.text.length == 0) {
        text1.text = @"";
    }
    if (idstring.length == 0) {
        idstring = @"";
    }
    [self loddeList:idstring];
    [self lodde:text1.text];
    window.hidden = YES;
}
- (void)clicksearch{
    if (window.hidden == YES) {
        window.hidden = NO;
    }else {
        window.hidden = YES;
    }
    
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    bglab.text = @"计件年月";
    bgwindowview.hidden = NO;
    self.searchArray = self.dataArray1;
    [self.tableview1 reloadData];
    return NO;
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



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem *bar1 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(clicksearch)];
    self.navigationItem.rightBarButtonItem = bar1;
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"Paidan_5_Cell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    [self setupButton];
    [self setupview_tableview];
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    view.backgroundColor = [UIColor whiteColor];
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH-20, 47)];
    lab.text = [NSString stringWithFormat:@"总计：%.2f",tot];
    [view addSubview:lab];
    
    UILabel *lines = [[UILabel alloc]initWithFrame:CGRectMake(0, 47, SCREEN_WIDTH, 3)];
    lines.backgroundColor = RGBACOLOR(228, 228, 228, 1);
    [view addSubview:lines];
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if ([tableView isEqual:self.tableview1]) {
        return 0;
    }
    return 50;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:self.tableview1]) {
        bgwindowview.hidden = YES;
        PaiDanModel *model = [self.searchArray objectAtIndex:indexPath.row];
        text1.text = [NSString stringWithFormat:@"%@",model.salaryMonth];
        idstring = model.id;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([tableView isEqual:self.tableview1]) {
        return self.searchArray.count;
    }
    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:self.tableview1]) {
        return 60;
    }
    return 170;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:self.tableview1]) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cells" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        PaiDanModel *model = [self.searchArray objectAtIndex:indexPath.row];
        cell.textLabel.text = [NSString stringWithFormat:@"%@",model.salaryMonth];
        return cell;
    }
    static NSString *identifierCell = @"cell";
    Paidan_5_Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
    if (cell == nil) {
        cell = [[Paidan_5_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.lab5.hidden = YES;
    cell.lab6.hidden = YES;
    cell.lab7.hidden = YES;
    cell.lab8.hidden = YES;
    cell.lab.hidden = YES;
    PaiDanModel *model = [self.dataArray objectAtIndex:indexPath.row];
    cell.lab1.text = [NSString stringWithFormat:@"日结日期：%@",model.salaryDate];
    cell.lab2.text = [NSString stringWithFormat:@"星期：%@",model.salaryWeekday];
    cell.lab3.text = [NSString stringWithFormat:@"结算类型：%@",model.salaryType];
    
    
    if ([model.salary floatValue]>0) {
        cell.lab4.textColor = [UIColor blueColor];
//        cell.lab4.text = [NSString stringWithFormat:@"结算工资：%@",model.salary];
        NSMutableAttributedString *noteStr1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"结算工资：%@",model.salary]];
        NSRange range1 = NSMakeRange(0, 5);
        [noteStr1 addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range1];
        [cell.lab4 setAttributedText:noteStr1];
    }else{
        cell.lab4.textColor = [UIColor redColor];
        NSMutableAttributedString *noteStr1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"结算工资：%@",model.salary]];
        NSRange range1 = NSMakeRange(0, 5);
        [noteStr1 addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range1];
        [cell.lab4 setAttributedText:noteStr1];
    }
    
    
    return cell;
}

- (void)lodinit{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"bianhao.text"],
            @"personId":[Manager redingwenjianming:@"id.text"],
            };
    [session POST:KURLNSString(@"servlet/salary/mysalary/reporthtm") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
//      NSLog(@"guowai----%@",dic);
        [weakSelf.dataArray1 removeAllObjects];
        NSMutableArray *arr = [dic objectForKey:@"searchYearMonth"];
        if (arr.count != 0) {
            for (NSDictionary *dic in arr) {
                PaiDanModel *model = [PaiDanModel mj_objectWithKeyValues:dic];
                [weakSelf.dataArray1 addObject:model];
            }
            PaiDanModel *models = [weakSelf.dataArray1 firstObject];
            text1.text = models.salaryMonth;
            idstring = models.id;
            [weakSelf loddeList:models.id];
            [weakSelf lodde:models.salaryMonth];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}

- (void)loddeList:(NSString *)str{
    if (str.length == 0) {
        str = @"";
    }
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"bianhao.text"],
            @"personId":[Manager redingwenjianming:@"id.text"],
            @"sorttype":@"asc",
            @"sort":@"salaryDate",
            @"salaryCardId":str,
            };
    [session POST:KURLNSString(@"servlet/salary/salarycarditems/list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
//        NSLog(@"guowai----%@",dic);
        tot = 0.00;
        [weakSelf.dataArray removeAllObjects];
        if (![[dic objectForKey:@"rows"]isEqual:[NSNull null]]) {
            NSMutableArray *arr = [dic objectForKey:@"rows"];
            for (NSDictionary *dict in arr) {
                PaiDanModel *model = [PaiDanModel mj_objectWithKeyValues:dict];
                
                tot = tot + [model.salary doubleValue];
                
                [weakSelf.dataArray addObject:model];
            }
        }
        [weakSelf.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}

- (void)lodde:(NSString *)str{
    if (str.length == 0) {
        str = @"";
    }
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"bianhao.text"],
            @"personId":[Manager redingwenjianming:@"id.text"],
            @"salaryMonth":str,
            };
    [session POST:KURLNSString(@"servlet/salary/mysalary/reportjson") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
//        NSLog(@"guowai----%@",dic);
        NSMutableArray *arr = (NSMutableArray *)dic;
        NSMutableArray *arr1 = [NSMutableArray arrayWithCapacity:1];
        NSMutableArray *arr2 = [NSMutableArray arrayWithCapacity:1];
        [arr1 removeAllObjects];
        [arr2 removeAllObjects];
        for (NSDictionary *dict in arr) {
            PaiDanModel *model = [PaiDanModel mj_objectWithKeyValues:dict];
            [arr1 addObject:model.finish_date];
            
            [arr2 addObject:@([model.total_fee doubleValue])];
        }
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 250)];
        weakSelf.tableView.tableHeaderView = view;
        weakSelf.aaChartView = [[AAChartView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 250)];
        weakSelf.aaChartView.delegate = weakSelf;
        [view addSubview:weakSelf.aaChartView];
        //    //设置 AAChartView 的背景色是否为透明(解开注释查看设置背景色透明后的效果)
        //    self.aaChartView.isClearBackgroundColor = YES;
        //    self.view.backgroundColor = [UIColor blueColor];
        weakSelf.aaChartModel= AAObject(AAChartModel)
        .chartTypeSet(AAChartTypeLine)
        .titleSet(@"")
        .subtitleSet(@"")
        .categoriesSet(arr1)
        .colorsThemeSet(@[@"#6495ED"])
        .yAxisTitleSet(@"")
        .tooltipValueSuffixSet(@"")
        .seriesSet(@[
                     AAObject(AASeriesElement)
                     .nameSet(@"每日汇总")
                     .dataSet(arr2),
                     ]
                   )
        ;
            _aaChartModel.symbolStyle = AAChartSymbolStyleTypeBorderBlank;//设置折线连接点样式为:边缘白色
//           _aaChartModel.symbolStyle = AAChartSymbolStyleTypeInnerBlank;//设置折线连接点样式为:内部白色
        //是否起用渐变色功能
        //_aaChartModel.gradientColorEnable = YES;
        [weakSelf.aaChartView aa_drawChartWithChartModel:_aaChartModel];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}
- (NSArray *)configureTheRandomColorArray {
    NSMutableArray *colorStringArr = [[NSMutableArray alloc]init];
    for (int i=0; i<5; i++) {
        int R = (arc4random() % 256) ;
        int G = (arc4random() % 256) ;
        int B = (arc4random() % 256) ;
        NSString *colorStr = [NSString stringWithFormat:@"rgba(%d,%d,%d,0.9)",R,G,B];
        [colorStringArr addObject:colorStr];
    }
    return colorStringArr;
}

#pragma mark -- AAChartView delegate
-(void)AAChartViewDidFinishLoad {
//    NSLog(@"图表视图已完成加载");
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
- (NSMutableArray *)searchArray{
    if (_searchArray == nil) {
        self.searchArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _searchArray;
}
//支持旋转
 -(BOOL)shouldAutorotate{
    return YES;
}
 - (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscapeLeft;
}



@end
