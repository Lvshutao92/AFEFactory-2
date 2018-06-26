//
//  BJYJD_search_list_ViewController.m
//  Factory
//
//  Created by ilovedxracer on 2017/11/28.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "BJYJD_search_list_ViewController.h"
#import "BJRKD_12_Cell.h"
#import "PaiDanModel.h"
#import "PaidanModel1.h"
#import "BJRKD_details_TableViewController.h"
#import "Edit_KuWei_ViewController.h"
#import "Edit_ChaCheGong_ViewController.h"
@interface BJYJD_search_list_ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    CGFloat height;
    NSInteger page;
    NSInteger totalnum;
}
@property(nonatomic, strong)UITableView *tableview;
@property(nonatomic, strong)NSMutableArray *dataArray;

@end

@implementation BJYJD_search_list_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableview registerNib:[UINib nibWithNibName:@"BJRKD_12_Cell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableview];
    
    [self setUpReflash];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(viewappear:) name:@"save_success" object:nil];
}
- (void)viewappear:(NSNotification *)text {
    [self setUpReflash];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    PaiDanModel *model = [self.dataArray objectAtIndex:indexPath.row];
    if (([model.forkliftPersonId isEqualToString:@""]||model.forkliftPersonId==nil) && ([model.stockInStatus isEqualToString:@"finished"] || [model.stockInStatus isEqualToString:@"canceled"] || [model.stockInStatus isEqualToString:@"returned"])) {
        return 370;
    }
    return 410;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifierCell = @"cell";
    BJRKD_12_Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
    if (cell == nil) {
        cell = [[BJRKD_12_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    PaiDanModel *model = [self.dataArray objectAtIndex:indexPath.row];
    cell.lab1.text = [NSString stringWithFormat:@"入库单编号：%@",model.stockInOrderNo];
    if (model.orderNo == nil) {
        cell.lab2.text = [NSString stringWithFormat:@"订单编号：%@",@"-"];
    }else{
        cell.lab2.text = [NSString stringWithFormat:@"订单编号：%@",model.orderNo];
    }
    cell.lab3.text = [NSString stringWithFormat:@"采购单编号：%@",model.purchaseOrderNo];
    
    if ([model.purchaseOrder_model.manual isEqualToString:@"Y"]) {
        cell.lab4.text = @"是否是耗材采购单：✔";
    }else{
        cell.lab4.text = @"是否是耗材采购单：✖";
    }
    cell.lab5.text = [NSString stringWithFormat:@"供应商名称：%@",model.purchaseOrder_model.supplierNo];
    cell.lab6.text = [NSString stringWithFormat:@"入库操作人员：%@ %@",model.receivePerson_model.personCode,model.receivePerson_model.realName];
    if (model.forkliftPerson_model.personCode == nil) {
        cell.lab7.text = [NSString stringWithFormat:@"叉车工：%@",@"-"];
    }else{
        cell.lab7.text = [NSString stringWithFormat:@"叉车工：%@ %@",model.forkliftPerson_model.personCode,model.forkliftPerson_model.realName];
    }
    
    
    if (model.purchaseOrder_model.plateNumber == nil) {
        cell.lab8.text = [NSString stringWithFormat:@"车牌号：%@",@"-"];
    }else{
        cell.lab8.text = [NSString stringWithFormat:@"车牌号：%@",model.purchaseOrder_model.plateNumber];
    }
    if (model.purchaseOrder_model.sendTime == nil) {
        cell.lab9.text = [NSString stringWithFormat:@"预约到货日期：%@",@"-"];
    }else{
        cell.lab9.text = [NSString stringWithFormat:@"预约到货日期：%@",model.purchaseOrder_model.sendTime];
    }
    cell.lab10.text = [NSString stringWithFormat:@"计划最晚入库日期：%@",model.purchaseOrder_model.planProductionDate];
    
    
    if (model.stockInTime == nil) {
        cell.lab11.text = [NSString stringWithFormat:@"入库时间：%@",@"-"];
    }else{
        cell.lab11.text = [NSString stringWithFormat:@"入库时间：%@",model.stockInTime];
    }
    
    
    if ([model.stockInStatus isEqualToString:@"created"]) {
        cell.lab12.text =@"入库情况：待收货";
    }else  if ([model.stockInStatus isEqualToString:@"working"]) {
        cell.lab12.text =@"入库情况：待入库";
    }else  if ([model.stockInStatus isEqualToString:@"finished"]) {
        cell.lab12.textColor = RGBACOLOR(32, 157, 149, 1.0);
        NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:@"入库情况：已入库"];
        NSRange range = NSMakeRange(0, 5);
        [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range];
        [cell.lab12 setAttributedText:noteStr];
    }else  if ([model.stockInStatus isEqualToString:@"canceled"]) {
        cell.lab12.text =@"入库情况：已取消";
    }else  if ([model.stockInStatus isEqualToString:@"returned"]) {
        cell.lab12.text =@"入库情况：已退货";
    }
    
    
    
    if ([model.forkliftPersonId isEqualToString:@""]||model.forkliftPersonId==nil) {
        cell.btn.hidden = YES;
        cell.btnwidth.constant = 0;
        cell.btnrightwidth.constant = 0;
    }else{
        cell.btn.hidden = NO;
        cell.btnwidth.constant = 50;
        cell.btnrightwidth.constant = 10;
    }
    
    
    if ([model.stockInStatus isEqualToString:@"finished"] || [model.stockInStatus isEqualToString:@"canceled"] || [model.stockInStatus isEqualToString:@"returned"]) {
        cell.btn2.hidden = YES;
        cell.btn1.hidden = YES;
    }else{
        cell.btn2.hidden = NO;
        cell.btn1.hidden = NO;
    }
    
    
    if (cell.btn.hidden == YES && cell.btn1.hidden == YES && cell.btn2.hidden == YES) {
        cell.line.hidden = YES;
    }else{
        cell.line.hidden = NO;
    }
    
    LRViewBorderRadius(cell.btn, 10, 1, [UIColor blackColor]);
    LRViewBorderRadius(cell.btn1, 10, 1, [UIColor blackColor]);
    LRViewBorderRadius(cell.btn2, 10, 1, [UIColor blackColor]);
    [cell.btn addTarget:self action:@selector(clickbtn:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btn1 addTarget:self action:@selector(clickbtn1:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btn2 addTarget:self action:@selector(clickbtn2:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
- (void)clickbtn:(UIButton *)sender{
    BJRKD_12_Cell *cell = (BJRKD_12_Cell *)[[sender superview] superview];
    NSIndexPath *indexpath = [self.tableview indexPathForCell:cell];
    PaiDanModel *model = [self.dataArray objectAtIndex:indexpath.row];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确认入库单已入库吗？" message:@"温馨提示" preferredStyle:1];
    UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        AFHTTPSessionManager *session = [Manager returnsession];
        __weak typeof(self) weakSelf = self;
        NSDictionary *dic = [[NSDictionary alloc]init];
        dic = @{@"businessId":[Manager redingwenjianming:@"bianhao.text"],
                @"departmentPersonSessionId":[Manager redingwenjianming:@"id.text"],
                @"departmentPersonName":[Manager redingwenjianming:@"realName.text"],
                @"id":model.id,
                };
        [session POST:KURLNSString(@"servlet/stock/stockinorder/stock_in") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary *dic = [Manager returndictiondata:responseObject];
            if ([[dic objectForKey:@"code"] isEqualToString:@"success"]) {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"入库成功" message:@"温馨提示" preferredStyle:1];
                UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    [weakSelf setUpReflash];
                }];
                [alert addAction:cancel];
                [weakSelf presentViewController:alert animated:YES completion:nil];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        }];
        
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alert addAction:sure];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)clickbtn1:(UIButton *)sender{
    BJRKD_12_Cell *cell = (BJRKD_12_Cell *)[[sender superview] superview];
    NSIndexPath *indexpath = [self.tableview indexPathForCell:cell];
    PaiDanModel *model = [self.dataArray objectAtIndex:indexpath.row];
    Edit_KuWei_ViewController *chachegong = [[Edit_KuWei_ViewController alloc]init];
    chachegong.idstr = model.id;
    
    
    if (model.orderNo == nil) {
        chachegong.lab1str = @"";
    }else{
        chachegong.lab1str = model.orderNo;
    }
    
    if (model.stockInOrderNo == nil) {
        chachegong.lab2str = @"";
    }else{
        chachegong.lab2str = model.stockInOrderNo;
    }
    
    if (model.purchaseOrderNo == nil) {
        chachegong.lab3str = @"";
    }else{
        chachegong.lab3str = model.purchaseOrderNo;
    }
    
    if (model.purchaseOrder_model.supplierNo == nil) {
        chachegong.lab4str = @"";
    }else{
        chachegong.lab4str = model.purchaseOrder_model.supplierNo;
    }
    [self.navigationController pushViewController:chachegong animated:YES];
}
- (void)clickbtn2:(UIButton *)sender{
    BJRKD_12_Cell *cell = (BJRKD_12_Cell *)[[sender superview] superview];
    NSIndexPath *indexpath = [self.tableview indexPathForCell:cell];
    PaiDanModel *model = [self.dataArray objectAtIndex:indexpath.row];
    Edit_ChaCheGong_ViewController *chachegong = [[Edit_ChaCheGong_ViewController alloc]init];
    chachegong.idstr = model.id;
    
    
    if (model.orderNo == nil) {
        chachegong.lab1str = @"";
    }else{
        chachegong.lab1str = model.orderNo;
    }
    
    if (model.stockInOrderNo == nil) {
        chachegong.lab2str = @"";
    }else{
        chachegong.lab2str = model.stockInOrderNo;
    }
    
    if (model.purchaseOrderNo == nil) {
        chachegong.lab3str = @"";
    }else{
        chachegong.lab3str = model.purchaseOrderNo;
    }
    
    if (model.purchaseOrder_model.supplierNo == nil) {
        chachegong.lab4str = @"";
    }else{
        chachegong.lab4str = model.purchaseOrder_model.supplierNo;
    }
    
    
    if (model.forkliftPerson_model.personCode == nil) {
        chachegong.textstr   = @"";
        chachegong.textidstr = @"";
    }else{
        chachegong.textstr   = [NSString stringWithFormat:@"%@ %@",model.forkliftPerson_model.personCode,model.forkliftPerson_model.realName];;
        chachegong.textidstr = model.purchaseOrder_model.forkliftPersonId;
    }
    
    
    [self.navigationController pushViewController:chachegong animated:YES];
}






- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PaiDanModel *model = [self.dataArray objectAtIndex:indexPath.row];
    BJRKD_details_TableViewController *order = [[BJRKD_details_TableViewController alloc]init];
    order.purchaseOrderId = model.id;
    MainTabbarViewController *tabBarVc = (MainTabbarViewController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    MainNavigationViewController *Nav = [tabBarVc selectedViewController];
    [Nav pushViewController:order animated:YES];
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
            @"stockInPersonId":[Manager redingwenjianming:@"user_cert_id.text"],
            @"page":[NSString stringWithFormat:@"%ld",page],
            @"sorttype":@"desc",
            @"sort":@"createTime",
            
            @"stockInOrderNo":self.str1,
            @"orderNo":self.str2,
            @"purchaseOrderNo":self.str3,
            @"planProductionBeginTime":self.str4,
            @"planProductionEndTime":self.str5,
            @"purchaseOrder.supplierNo":self.str6,
            @"purchaseOrder.purchaseOrderType":@"PIA",
            @"stockInStatus":@"working",
            };
    [session POST:KURLNSString(@"servlet/stock/stockinorder/list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        //NSLog(@"%@",dic);
        totalnum = [[dic objectForKey:@"total"] integerValue];
        [weakSelf.dataArray removeAllObjects];
        NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"resultList"];
        for (NSDictionary *dict in arr) {
            PaiDanModel *model = [PaiDanModel mj_objectWithKeyValues:dict];
            
            PaidanModel1 *model1 = [PaidanModel1 mj_objectWithKeyValues:model.purchaseOrder];
            model.purchaseOrder_model = model1;
            
            PaidanModel1 *model2 = [PaidanModel1 mj_objectWithKeyValues:model.receivePerson_ed];
            model.receivePerson_model = model2;
            
            PaidanModel1 *model3 = [PaidanModel1 mj_objectWithKeyValues:model.forkliftPerson_ed];
            model.forkliftPerson_model = model3;
            
            [weakSelf.dataArray addObject:model];
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
            @"stockInPersonId":[Manager redingwenjianming:@"user_cert_id.text"],
            @"page":[NSString stringWithFormat:@"%ld",page],
            @"sorttype":@"desc",
            @"sort":@"createTime",
            
            @"stockInOrderNo":self.str1,
            @"orderNo":self.str2,
            @"purchaseOrderNo":self.str3,
            @"planProductionBeginTime":self.str4,
            @"planProductionEndTime":self.str5,
            @"purchaseOrder.supplierNo":self.str6,
            @"purchaseOrder.purchaseOrderType":@"PIA",
            @"stockInStatus":@"working",
            
            };
    
    [session POST:KURLNSString(@"servlet/stock/stockinorder/list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *diction = [Manager returndictiondata:responseObject];
        NSMutableArray *arr = [[diction objectForKey:@"rows"] objectForKey:@"resultList"];
        for (NSDictionary *dict in arr) {
            PaiDanModel *model = [PaiDanModel mj_objectWithKeyValues:dict];
            PaidanModel1 *model1 = [PaidanModel1 mj_objectWithKeyValues:model.purchaseOrder];
            model.purchaseOrder_model = model1;
            PaidanModel1 *model2 = [PaidanModel1 mj_objectWithKeyValues:model.receivePerson_ed];
            model.receivePerson_model = model2;
            PaidanModel1 *model3 = [PaidanModel1 mj_objectWithKeyValues:model.forkliftPerson_ed];
            model.forkliftPerson_model = model3;
            [weakSelf.dataArray addObject:model];
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
@end
