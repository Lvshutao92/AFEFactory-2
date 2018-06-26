//
//  SBWXS_TableViewController.m
//  AFEFactory
//
//  Created by ilovedxracer on 2018/1/11.
//  Copyright © 2018年 ilovedxracer. All rights reserved.
//

#import "SBWXS_TableViewController.h"
#import "SY_11_Cell.h"
#import "PaiDanModel.h"
#import "XiuGaiViewController.h"

@interface SBWXS_TableViewController ()<UITextFieldDelegate>
{
    CGFloat height;
    NSInteger page;
    NSInteger totalnum;
    
    CGFloat height1;
    CGFloat height2;
    
    UIView *window;
    
    UITextField *text1;
    UITextField *text2;
    UITextField *text3;
    UITextField *text4;
    NSString *stu;
}
@property(nonatomic,strong)UIScrollView *BgView;
@property(nonatomic,strong)UILabel *toplab;


@property(nonatomic,strong)NSMutableArray *dataArray;
@end

@implementation SBWXS_TableViewController
- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        self.dataArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray;
}
- (void)clickadd{
    XiuGaiViewController *xiugai = [[XiuGaiViewController alloc]init];
    xiugai.navigationItem.title = @"新增";
    xiugai.idstr = @"";
    xiugai.str1 = @"";
    xiugai.str2 = @"";
    xiugai.str3 = @"";
    xiugai.str4 = @"";
    xiugai.str5 = @"";
    xiugai.str6 = @"";
    xiugai.str7 = @"";
    xiugai.str8 = @"";
    xiugai.str9 = @"";
    xiugai.str10 = @"";
    xiugai.str11 = @"正常";
    [self.navigationController pushViewController:xiugai animated:YES];
}
- (void)clicksearch{
    text1.text = nil;
    text2.text = nil;
    text3.text = nil;
    text4.text = nil;
    stu = @"";
    if (window.hidden == YES) {
        window.hidden = NO;
    }else{
        window.hidden = YES;
    }
}






- (void)setupButton {
    window = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    window.backgroundColor = [UIColor colorWithWhite:.85 alpha:.5];
    //    window.windowLevel = UIWindowLevelNormal;
    window.alpha = 1.f;
    window.hidden = YES;
    
    
    self.BgView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 10, self.view.frame.size.width, 0)];
    self.BgView.backgroundColor = [UIColor whiteColor];
    
    
    UILabel *lab1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 150, 40)];
    lab1.text = @"维修商代码";
    [self.BgView addSubview:lab1];
    text1 = [[UITextField alloc] initWithFrame:CGRectMake(10,50, SCREEN_WIDTH-20, 40)];
    text1.delegate = self;
    text1.placeholder = @"请输入维修商代码";
    text1.borderStyle = UITextBorderStyleRoundedRect;
    [self.BgView addSubview: text1];
    
    
    
    UILabel *lab2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 100, 100, 40)];
    lab2.text = @"维修商名称";
    [self.BgView addSubview:lab2];
    text2 = [[UITextField alloc] initWithFrame:CGRectMake(10, 145, SCREEN_WIDTH-20, 40)];
    text2.delegate = self;
    text2.borderStyle = UITextBorderStyleRoundedRect;
    text2.placeholder = @"请输入维修商名称";
    [self.BgView addSubview: text2];
    
    
    UILabel *lab3 = [[UILabel alloc]initWithFrame:CGRectMake(10, 195, SCREEN_WIDTH-20, 40)];
    lab3.text = @"维修商联系人";
    [self.BgView addSubview:lab3];
    text3 = [[UITextField alloc] initWithFrame:CGRectMake(10, 240, SCREEN_WIDTH-20, 40)];
    text3.delegate = self;
    text3.borderStyle = UITextBorderStyleRoundedRect;
    text3.placeholder = @"请输入维修商联系人";
    [self.BgView addSubview: text3];
    
    
    UILabel *lab4 = [[UILabel alloc]initWithFrame:CGRectMake(10, 290, SCREEN_WIDTH-20, 40)];
    lab4.text = @"维修商联系人手机";
    [self.BgView addSubview:lab4];
    text4 = [[UITextField alloc] initWithFrame:CGRectMake(10, 335, SCREEN_WIDTH-20, 40)];
    text4.delegate = self;
    text4.borderStyle = UITextBorderStyleRoundedRect;
    text4.placeholder = @"请输入维修商联系人手机";
    [self.BgView addSubview: text4];
    
    
    self.toplab = [[UILabel alloc]initWithFrame:CGRectMake(10, 385, SCREEN_WIDTH-20, 40)];
    self.toplab.text = @"状态";
    [self.BgView addSubview:self.toplab];
    
    NSArray *arr = @[@"正常",@"停用"];
    CGFloat w = 0;//保存前一个button的宽以及前一个button距离屏幕边缘的距离
    CGFloat h = 430;//用来控制button距离父视图的高
    for (int i = 0; i < arr.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.tag = 100 + i;
        button.backgroundColor = [UIColor colorWithWhite:.8 alpha:.3];
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = 5.0;
        
        [button addTarget:self action:@selector(handleClick:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //根据计算文字的大小
        NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:22.f]};
        CGSize size = CGSizeMake(MAXFLOAT, 25);
        CGFloat length = [arr[i] boundingRectWithSize:size options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attributes context:nil].size.width;
        //为button赋值
        [button setTitle:arr[i] forState:UIControlStateNormal];
        //设置button的frame
        button.frame = CGRectMake(10 + w, h, length + 20 , 40);
        //当button的位置超出屏幕边缘时换行 只是button所在父视图的宽度
        if(10 + w + length + 20 > self.view.frame.size.width){
            w = 0; //换行时将w置为0
            h = h + button.frame.size.height + 10;//距离父视图也变化
            button.frame = CGRectMake(10 + w, h, length + 20, 40);//重设button的frame
        }
        w = button.frame.size.width + button.frame.origin.x;
        [_BgView addSubview:button];
        
    }
    
    
    _BgView.frame = CGRectMake(0, 10, self.view.frame.size.width, SCREEN_HEIGHT-250);
    self.BgView.contentSize = CGSizeMake(0, SCREEN_HEIGHT);
    [window addSubview:_BgView];
    
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(SCREEN_WIDTH/2, SCREEN_HEIGHT-250, SCREEN_WIDTH/2, 50);
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:@"确定" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(sure) forControlEvents:UIControlEventTouchUpInside];
    [window addSubview:btn];
    
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(0,SCREEN_HEIGHT-249, SCREEN_WIDTH/2, 49);
    btn1.backgroundColor = [UIColor whiteColor];
    [btn1 setTitle:@"取消" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(cancle) forControlEvents:UIControlEventTouchUpInside];
    [window addSubview:btn1];
    
    
    UILabel *lin = [[UILabel alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-250,SCREEN_WIDTH/2, 1)];
    lin.backgroundColor = [UIColor colorWithWhite:.85 alpha:.3];
    [window addSubview:lin];
    
    [self.view addSubview:window];
    [self.view bringSubviewToFront:window];
    
    [self setUpReflash];
    
}

- (void)cancle{
    [text1 resignFirstResponder];
    [text2 resignFirstResponder];
    [text3 resignFirstResponder];
    [text4 resignFirstResponder];
    window.hidden = YES;
    text1.text = nil;
    text2.text = nil;
    text3.text = nil;
    text4.text = nil;
    stu = @"";
}




- (void)sure{
    [text1 resignFirstResponder];
    [text2 resignFirstResponder];
    [text3 resignFirstResponder];
    [text4 resignFirstResponder];
    
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
    if (stu.length == 0) {
        stu = @"";
    }
    
    [self setUpReflash];
    window.hidden = YES;
}

- (void)handleClick:(UIButton *)btn{
    [text1 resignFirstResponder];
    [text2 resignFirstResponder];
    [text3 resignFirstResponder];
    [text4 resignFirstResponder];
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
    
    if ([btn.titleLabel.text isEqualToString:@"停用"]) {
        stu = @"N";
    }else{
        stu = @"Y";
    }
    [self setUpReflash];
    window.hidden = YES;
}


- (void)viewWillAppear:(BOOL)animated{
    [self setupButton];
}

















- (void)viewDidLoad {
    [super viewDidLoad];
    stu = @"";
    UIBarButtonItem *bar = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(clickadd)];
    UIBarButtonItem *bar1 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(clicksearch)];
    self.navigationItem.rightBarButtonItems = @[bar,bar1];
    
     self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"SY_11_Cell" bundle:nil] forCellReuseIdentifier:@"cell"];
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    self.tableView.tableHeaderView = v;
    
    
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 350+height1+height2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifierCell = @"cell";
    SY_11_Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
    if (cell == nil) {
        cell = [[SY_11_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    PaiDanModel *model = [self.dataArray objectAtIndex:indexPath.row];
    cell.lab1.text = [NSString stringWithFormat:@"维修商代码：%@",model.supplierCode];
    
    
    cell.lab2.text = [NSString stringWithFormat:@"维修商名称：%@",model.supplierName];
    cell.lab2.numberOfLines = 0;
    cell.lab2.lineBreakMode = NSLineBreakByWordWrapping;
    CGSize size = [cell.lab2 sizeThatFits:CGSizeMake(SCREEN_WIDTH-20, MAXFLOAT)];
    cell.lab2height.constant = size.height;
    height1 = size.height;
    
    
    cell.lab3.text = [NSString stringWithFormat:@"维修商联系地址：%@",model.supplierAddress];
    cell.lab3.numberOfLines = 0;
    cell.lab3.lineBreakMode = NSLineBreakByWordWrapping;
    CGSize sizes = [cell.lab3 sizeThatFits:CGSizeMake(SCREEN_WIDTH-20, MAXFLOAT)];
    cell.lab3height.constant = sizes.height;
    height2 = sizes.height;
    
    
    
    cell.lab4.text = [NSString stringWithFormat:@"维修商联系电话：%@",model.supplierTel];
    cell.lab5.text = [NSString stringWithFormat:@"维修商联系人：%@",model.supplierConPerson];
    cell.lab6.text = [NSString stringWithFormat:@"维修商联系人手机：%@",model.supplierConPersonTel];
    
    if (model.field1 == nil) {
        model.field1 = @"-";
    }
    if (model.field2 == nil) {
        model.field2 = @"-";
    }
    if (model.field3 == nil) {
        model.field3 = @"-";
    }
    if (model.field4 == nil) {
        model.field4 = @"-";
    }
    
    
    cell.lab7.text = [NSString stringWithFormat:@"开户银行：%@",model.field1];
    cell.lab8.text = [NSString stringWithFormat:@"银行账户：%@",model.field2];
    cell.lab9.text = [NSString stringWithFormat:@"银行账号：%@",model.field3];
    cell.lab10.text = [NSString stringWithFormat:@"预计付款天数：%@",model.field4];
    
    
    if ([model.status isEqualToString:@"Y"]) {
        cell.lab11.text = [NSString stringWithFormat:@"状态：%@",@"正常"];
    }else{
        cell.lab11.text = [NSString stringWithFormat:@"状态：%@",@"停用"];
    }
    
    
    
    cell.btn2.hidden = YES;
    cell.btn1.hidden = NO;
    [cell.btn setTitle:@"删除" forState:UIControlStateNormal];
    [cell.btn1 setTitle:@"修改" forState:UIControlStateNormal];
    LRViewBorderRadius(cell.btn, 15, 1, [UIColor blackColor]);
    LRViewBorderRadius(cell.btn1, 15, 1, [UIColor blackColor]);

    [cell.btn addTarget:self action:@selector(clickbtn:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btn1 addTarget:self action:@selector(clickbtn1:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

- (void)clickbtn:(UIButton *)sender{
    SY_11_Cell *cell = (SY_11_Cell *)[[sender superview] superview];
    NSIndexPath *indexpath = [self.tableView indexPathForCell:cell];
    PaiDanModel *model = [self.dataArray objectAtIndex:indexpath.row];
    
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"bianhao.text"],
            @"id":model.id,
            };
    [session POST:KURLNSString(@"servlet/equipment/equipmentsupplier/delete") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
//        NSLog(@"----------%@",dic);
        if ([[dic objectForKey:@"code"] isEqualToString:@"success"]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"删除成功！" message:@"温馨提示" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                [weakSelf.dataArray removeObjectAtIndex:indexpath.row];
                [weakSelf.tableView deleteRowsAtIndexPaths:[NSMutableArray arrayWithObject:indexpath] withRowAnimation:UITableViewRowAnimationAutomatic];
            }];
            [alert addAction:cancel];
            [weakSelf presentViewController:alert animated:YES completion:nil];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}
- (void)clickbtn1:(UIButton *)sender{
    SY_11_Cell *cell = (SY_11_Cell *)[[sender superview] superview];
    NSIndexPath *indexpath = [self.tableView indexPathForCell:cell];
    PaiDanModel *model = [self.dataArray objectAtIndex:indexpath.row];
    
    XiuGaiViewController *xiugai = [[XiuGaiViewController alloc]init];
    xiugai.navigationItem.title = @"编辑";
    
    xiugai.idstr = model.id;
    
    if (model.supplierCode == nil) {
        xiugai.str1 = @"";
    }else{
        xiugai.str1 = model.supplierCode;
    }
    
    if (model.supplierName == nil) {
        xiugai.str2 = @"";
    }else{
        xiugai.str2 = model.supplierName;
    }
    
    if (model.supplierAddress == nil) {
        xiugai.str3 = @"";
    }else{
        xiugai.str3 = model.supplierAddress;
    }
    
    if (model.supplierTel == nil) {
        xiugai.str4 = @"";
    }else{
        xiugai.str4 = model.supplierTel;
    }
    
    if (model.supplierConPerson == nil) {
        xiugai.str5 = @"";
    }else{
        xiugai.str5 = model.supplierConPerson;
    }
    
    if (model.supplierConPersonTel == nil) {
        xiugai.str6 = @"";
    }else{
        xiugai.str6 = model.supplierConPersonTel;
    }
    
    if ([model.field1 isEqualToString:@"-"]) {
        xiugai.str7 = @"";
    }else{
        xiugai.str7 = model.field1;
    }
    
    if ([model.field2 isEqualToString:@"-"]) {
        xiugai.str8 = @"";
    }else{
        xiugai.str8 = model.field2;
    }
    
    if ([model.field3 isEqualToString:@"-"]) {
        xiugai.str9 = @"";
    }else{
        xiugai.str9 = model.field3;
    }
    
    if ([model.field4 isEqualToString:@"-"]) {
        xiugai.str10 = @"";
    }else{
        xiugai.str10 = model.field4;
    }
    
    
    if ([model.status isEqualToString:@"N"]) {
        xiugai.str11 = @"停用";
    }else{
        xiugai.str11 = @"正常";
    }
    
    
    
    
    [self.navigationController pushViewController:xiugai animated:YES];
    
}







//刷新数据
-(void)setUpReflash
{
    __weak typeof (self) weakSelf = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loddeList];
    }];
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        if (self.dataArray.count == totalnum) {
            [self.tableView.mj_footer setState:MJRefreshStateNoMoreData];
        }else {
            [weakSelf loddeSLList];
        }
    }];
}
- (void)loddeList{
    [self.tableView.mj_footer endRefreshing];
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    page = 1;
    dic = @{@"businessId":[Manager redingwenjianming:@"bianhao.text"],
            @"page":[NSString stringWithFormat:@"%ld",page],
            @"sorttype":@"asc",
            @"sort":@"undefined",
            
            @"supplierCode":text1.text,
            @"supplierName":text2.text,
            @"supplierConPerson":text3.text,
            @"supplierConPersonTel":text4.text,
            @"status":stu,
            };
    [session POST:KURLNSString(@"servlet/equipment/equipmentsupplier/list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
//                NSLog(@"guowai----%@",dic);
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
        [weakSelf.tableView reloadData];
        [weakSelf.tableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakSelf.tableView.mj_header endRefreshing];
    }];
}
- (void)loddeSLList{
    [self.tableView.mj_header endRefreshing];
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"bianhao.text"],
            @"page":[NSString stringWithFormat:@"%ld",page],
            @"sorttype":@"asc",
            @"sort":@"undefined",
            
            @"supplierCode":text1.text,
            @"supplierName":text2.text,
            @"supplierConPerson":text3.text,
            @"supplierConPersonTel":text4.text,
            @"status":stu,
            };
    [session POST:KURLNSString(@"servlet/equipment/equipmentsupplier/list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
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
        [weakSelf.tableView reloadData];
        [weakSelf.tableView.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakSelf.tableView.mj_footer endRefreshing];
    }];
}











@end
