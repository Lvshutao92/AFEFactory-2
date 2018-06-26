//
//  Search_two_ViewController.m
//  AFEFactory
//
//  Created by ilovedxracer on 2017/12/8.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "Search_two_ViewController.h"
#import "DSC_5_Cell.h"
#import "PaiDanModel.h"
#import "PaidanModel1.h"
@interface Search_two_ViewController ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>
{
    CGFloat height;
    NSInteger page;
    NSInteger totalnum;
    
    CGFloat hei;
}
@property(nonatomic, strong)UITableView *tableview;
@property(nonatomic, strong)NSMutableArray *dataArray;
@property(nonatomic,strong)UISearchBar *searchbar;
@end

@implementation Search_two_ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _searchbar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    _searchbar.delegate = self;
    _searchbar.searchBarStyle = UISearchBarStyleMinimal;
    _searchbar.placeholder = @"请输入出货单号";
    
    [_searchbar setImage:[UIImage imageNamed:@"sousuo"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    //    _searchbar.contentMode  = UIViewContentModeScaleAspectFit;
    _searchbar.tintColor = [UIColor whiteColor];
    
    UITextField *searchField = [_searchbar valueForKey:@"_searchField"];
    //改变searcher的textcolor
    searchField.textColor=[UIColor whiteColor];
    //改变placeholder的颜色
    [searchField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    // searchBar光标颜色
    [[[self.searchbar.subviews objectAtIndex:0].subviews objectAtIndex:1] setTintColor:[UIColor whiteColor]];
    self.navigationItem.titleView = _searchbar;
    
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableview registerNib:[UINib nibWithNibName:@"DSC_5_Cell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableview];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 190+hei;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifierCell = @"cell";
    DSC_5_Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
    if (cell == nil) {
        cell = [[DSC_5_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    PaiDanModel *model = [self.dataArray objectAtIndex:indexPath.row];
    cell.lab1.text = [NSString stringWithFormat:@"出货单号：%@",model.exportNo];
    cell.lab2.text = [NSString stringWithFormat:@"客户名称：%@",model.dealerName];
    cell.lab3.text = [NSString stringWithFormat:@"申请出货日期：%@",model.planShipmentDate];
    
    if (model.field8 == nil) {
        cell.lab4.text = [NSString stringWithFormat:@"提货人信息：%@",@"-"];
    }else{
        NSData *jsonData = [model.field8 dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:nil];
        if ([dic objectForKey:@"cardNo"] != nil) {
            cell.lab4.text = [NSString stringWithFormat:@"提货人信息：%@ %@ %@",[dic objectForKey:@"cardNo"],[dic objectForKey:@"contact"],[dic objectForKey:@"phone"]];
        }else{
            cell.lab4.text = [NSString stringWithFormat:@"提货人信息：%@",@"-"];
        }
        
    }
    cell.lab4.numberOfLines = 0;
    cell.lab4.lineBreakMode = NSLineBreakByWordWrapping;
    CGSize size = [cell.lab4 sizeThatFits:CGSizeMake(SCREEN_WIDTH-20, MAXFLOAT)];
    cell.lab4height.constant = size.height;
    hei = size.height;
    
    
    if (model.actualDate == nil) {
        cell.lab5.text = [NSString stringWithFormat:@"预计提货日期：%@",@"-"];
    }else{
        cell.lab5.text = [NSString stringWithFormat:@"预计提货日期：%@",model.actualDate];
    }
    
    return cell;
}










//刷新数据
-(void)setUpReflash:(NSString *)str
{
    __weak typeof (self) weakSelf = self;
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loddeList:str];
    }];
    [self.tableview.mj_header beginRefreshing];
    self.tableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        if (self.dataArray.count == totalnum) {
            [self.tableview.mj_footer setState:MJRefreshStateNoMoreData];
        }else {
            [weakSelf loddeSLList:str];
        }
    }];
}
- (void)loddeList:(NSString *)str{
    [self.tableview.mj_footer endRefreshing];
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    page = 1;
    dic = @{@"businessId":[Manager redingwenjianming:@"bianhao.text"],
            @"page":[NSString stringWithFormat:@"%ld",page],
            @"sorttype":@"asc",
            @"sort":@"undefined",
            @"status":@"create",
            
            
            @"exportNo":str,
            };
    [session POST:KURLNSString(@"servlet/shipment/exportorder/list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        //        NSLog(@"guowai----%@",dic);
        totalnum = [[dic objectForKey:@"total"] integerValue];
        [weakSelf.dataArray removeAllObjects];
        if (![[dic objectForKey:@"rows"]isEqual:[NSNull null]]) {
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
- (void)loddeSLList:(NSString *)str{
    [self.tableview.mj_header endRefreshing];
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"bianhao.text"],
            @"page":[NSString stringWithFormat:@"%ld",page],
            @"sorttype":@"asc",
            @"sort":@"undefined",
            @"status":@"create",
            
            @"exportNo":str,
            };
    [session POST:KURLNSString(@"servlet/shipment/exportorder/list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        if (![[dic objectForKey:@"rows"]isEqual:[NSNull null]]) {
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



- (void)viewWillAppear:(BOOL)animated{
    [self.searchbar becomeFirstResponder];
}
#pragma mark --searchBar delegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    [self setUpReflash:searchBar.text];
}

-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    searchBar.showsCancelButton = YES;
    return YES;
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    searchBar.showsCancelButton = NO;
    [searchBar resignFirstResponder];
}

@end
