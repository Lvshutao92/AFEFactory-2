//
//  WYRZ_details_two_ViewController.m
//  AFEFactory
//
//  Created by ilovedxracer on 2017/12/13.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "WYRZ_details_two_ViewController.h"
#import "LOOkPicCell.h"
#import "PaiDanModel.h"
#import "PaidanModel1.h"
#import "LookPictureViewController.h"
#import "WebViewController.h"
@interface WYRZ_details_two_ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSString *idstr;
}
@property(nonatomic, strong)UITableView *tableview;
@property(nonatomic, strong)NSMutableArray *dataArray;
@end

@implementation WYRZ_details_two_ViewController

-  (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableview registerNib:[UINib nibWithNibName:@"LOOkPicCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableview];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(details:) name:@"wyrz_details" object:nil];
    
}
- (void)details:(NSNotification *)text{
    NSDictionary *dic = text.userInfo;
    idstr = [dic objectForKey:@"id"];
    [self loddeList];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 95;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifierCell = @"cell";
    LOOkPicCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
    if (cell == nil) {
        cell = [[LOOkPicCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    PaiDanModel *model = [self.dataArray objectAtIndex:indexPath.row];
    
    cell.lab.text = [NSString stringWithFormat:@"文件类型：%@",model.configCert_model.fieldType];
    LRViewBorderRadius(cell.btn, 5, 1, [UIColor blackColor]);
    
    
    [cell.btn addTarget:self action:@selector(clickbtn:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
- (void)clickbtn:(UIButton *)sender{
    LOOkPicCell *cell = (LOOkPicCell *)[[sender superview] superview];
    NSIndexPath *indexpath = [self.tableview indexPathForCell:cell];
    PaiDanModel *model = [self.dataArray objectAtIndex:indexpath.row];
    
    WebViewController *look = [[WebViewController alloc]init];
    look.webStr = NSString(model.fieldUrl);
    look.str = @"pdf";
    [self.navigationController pushViewController:look animated:YES];
}








- (void)loddeList{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    if (idstr == nil || idstr.length == 0) {
        idstr = @"";
    }
    dic = @{@"businessId":[Manager redingwenjianming:@"bianhao.text"],
            @"page":@"1",
            @"personId":idstr,
            };
    [session POST:KURLNSString(@"servlet/organization/departmentpersoncert/list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        //NSLog(@"-------%@",dic);
        [weakSelf.dataArray removeAllObjects];
        if (![[dic objectForKey:@"rows"] isEqual:[NSNull null]]) {
            NSMutableArray *arr = [dic objectForKey:@"rows"];
            for (NSDictionary *dict in arr) {
                PaiDanModel *model = [PaiDanModel mj_objectWithKeyValues:dict];

                PaidanModel1 *model1 = [PaidanModel1 mj_objectWithKeyValues:model.configCert];
                model.configCert_model = model1;

                [weakSelf.dataArray addObject:model];
            }
        }
        [weakSelf.tableview reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}




- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        self.dataArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray;
}
@end
