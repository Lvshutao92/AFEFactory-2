//
//  WPLY_edit_ViewController.m
//  AFEFactory
//
//  Created by ilovedxracer on 2017/12/20.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "WPLY_edit_ViewController.h"
#import "WPLY_edit_Cell.h"

#import "PaiDanModel.h"
#import "WPLY_0ceng_ViewController.h"
#import "PurchaseCarAnimationTool.h"
#define  TAG_BACKGROUNDVIEW 350
@interface WPLY_edit_ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    CAGradientLayer *_gradientLayer;
    UILabel *txlab;//没有选择商品点击结算提示label
    UIView *bgView;//底部视图
    //    UIButton *btn;//编辑按钮
    UITableView *myTableView;
    //全选按钮
    UIButton *selectAll;
    //展示数据源数组
    NSMutableArray *dataArray;
    //是否全选
    BOOL isSelect;
    //已选的商品集合
    NSMutableArray *selectGoods;
    UILabel *priceLabel;
    
    BOOL isedit;
    UIButton *editbtn;
    
    NSMutableArray *deleateArr;
    
    NSInteger totolNum;
    UIButton *btn;
    UIButton *button;
    CGFloat money;
    
}



@end

@implementation WPLY_edit_ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title = @"新建物品领用单";
    deleateArr = [NSMutableArray arrayWithCapacity:1];
    dataArray = [[NSMutableArray alloc]init];
    selectGoods = [[NSMutableArray alloc]init];
    editbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    editbtn.frame = CGRectMake(0, 0, 50, 30) ;
    [editbtn setTitle:@"编辑" forState:UIControlStateNormal];
    [editbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [editbtn addTarget:self action:@selector(clickEdit) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *bar = [[UIBarButtonItem alloc]initWithCustomView:editbtn];
    //self.navigationItem.rightBarButtonItem = bar;
    
    
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 120) style:UITableViewStylePlain];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.rowHeight = 100;
    myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    myTableView.backgroundColor = RGBCOLOR(245, 246, 248);
    
}
-(void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = YES;
    //每次进入购物车的时候把选择的置空
    [deleateArr removeAllObjects];
    [selectGoods removeAllObjects];
    isSelect = NO;
    selectAll.selected = NO;
    priceLabel.text = [NSString stringWithFormat:@"￥0.00"];
    
    [self.view addSubview:myTableView];
    [self setupBottomView];
    
    [self lodXL];
}



- (void)clickEdit {
    //每次进入购物车的时候把选择的置空
    [selectGoods removeAllObjects];
    isSelect = NO;
    //    [self networkRequest];
    selectAll.selected = NO;
    priceLabel.text = [NSString stringWithFormat:@"￥0.00"];
    [myTableView reloadData];
    
    if (isedit == NO) {
        [deleateArr removeAllObjects];
        [editbtn setTitle:@"完成" forState:UIControlStateNormal];
    }else {
        [editbtn setTitle:@"编辑" forState:UIControlStateNormal];
    }
    isedit = !isedit;;
    [self setupBottomView];
}

#pragma mark <UITableViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //    XH_PL_details_TableViewController *details = [[XH_PL_details_TableViewController alloc]init];
    //    PL_____model *model = [dataArray objectAtIndex:indexPath.row];
    //    details.idstr = model.id;
    //    details.fuhao = model.model3.field1;
    //    [self.navigationController pushViewController:details animated:YES];
}

//请求列表
- (void)lodXL{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"bianhao.text"],
            @"takeId":self.takeId,
            @"sorttype":@"asc",
            @"sort":@"undefined",
            };
    [session POST:KURLNSString(@"servlet/officegoods/officegoodstakeitem/list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        NSLog(@"%@",dic);
        
        [dataArray removeAllObjects];
        if (![[dic objectForKey:@"rows"] isEqual:[NSNull null]]) {
            NSMutableArray *arr = [dic objectForKey:@"rows"];
            for (NSDictionary *dict in arr) {
                PaiDanModel *model = [PaiDanModel mj_objectWithKeyValues:dict];
                [dataArray addObject:model];
            }
            
            
            for (PaiDanModel *models in [Manager sharedManager].wplyArr) {
                [dataArray addObject:models];
            }
            
            
        }
        [myTableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
    

}
- (NSMutableArray *)arr{
    if (_arr == nil) {
        self.arr = [NSMutableArray arrayWithCapacity:1];
    }
    return _arr;
}



-(void)selectAllBtnClick:(UIButton*)sender
{
    
    //点击全选时,把之前已选择的全部删除
    [selectGoods removeAllObjects];
    
    sender.selected = !sender.selected;
    isSelect = sender.selected;
    if (isSelect) {
        for (PaiDanModel *model in dataArray) {
            [selectGoods addObject:model];
        }
    }
    else
    {
        [selectGoods removeAllObjects];
    }
    [myTableView reloadData];
}


//合并付款
-(void)goPayBtnClick
{
    if (selectGoods.count == 0)
    {
        txlab.hidden = NO;
        [self.view bringSubviewToFront:txlab];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            txlab.hidden = YES;
        });
    }else {
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:1];
        [array removeAllObjects];
        
        for (PaiDanModel *model in selectGoods) {
            NSDictionary *stuDict = model.mj_keyValues;
            [stuDict setValue:model.id forKey:@"goodsId"];
            [stuDict setValue:model.unitId forKey:@"unitId"];
            [stuDict setValue:model.businessId forKey:@"businessId"];
            [stuDict setValue:@"" forKey:@"id"];
            
            
            [array addObject:stuDict];
        }
        
        
        NSDictionary *body = [[NSDictionary alloc]init];
        body = @{@"businessId":[Manager redingwenjianming:@"bianhao.text"],
                 @"userId":[Manager redingwenjianming:@"userid.text"],
                 @"username":[Manager redingwenjianming:@"name.text"],
                 @"takeId":self.takeId,
                 @"items":array,
                 };
        NSLog(@"-----%@",body);
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:body options:0 error:&error];
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        NSMutableURLRequest *req = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:KURLNSString(@"servlet/officegoods/officegoodstakeitem/update") parameters:nil error:nil];
        req.timeoutInterval= [[[NSUserDefaults standardUserDefaults] valueForKey:@"timeoutInterval"] longValue];
        [req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [req setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [req setHTTPBody:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
        [[manager dataTaskWithRequest:req completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
            
            if (!error) {
                //                NSLog(@"Reply JSON: %@", responseObject);
                if ([[responseObject objectForKey:@"code"]isEqualToString:@"success"]) {
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"申请成功" message:@"温馨提示" preferredStyle:1];
                    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                        
                        NSDictionary *dict = [[NSDictionary alloc]init];
                        NSNotification *notification =[NSNotification notificationWithName:@"wply1ceng_appear" object:nil userInfo:dict];
                        [[NSNotificationCenter defaultCenter] postNotification:notification];
                        
                        
                        [self.navigationController popViewControllerAnimated:YES];
                    }];
                    [alert addAction:cancel];
                    [self presentViewController:alert animated:YES completion:nil];
                }else{
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:[responseObject objectForKey:@"message"] message:@"温馨提示" preferredStyle:1];
                    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    }];
                    [alert addAction:cancel];
                    [self presentViewController:alert animated:YES completion:nil];
                }
                
                if ([responseObject isKindOfClass:[NSDictionary class]]) {
                    
                }
            } else {
                NSLog(@"Error: %@, %@, %@", error, response, responseObject);
            }
            
        }] resume];
        
        
    }
}




- (void)goShoppingBtnClick{
    WPLY_0ceng_ViewController *vc = [[WPLY_0ceng_ViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}




#pragma mark - 设置底部视图

-(void)setupBottomView
{
    //底部视图的 背景
    bgView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 50, SCREEN_WIDTH, 50)];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgView];
    
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    line.backgroundColor = kUIColorFromRGB(0xD5D5D5);
    [bgView addSubview:line];
    //全选按钮
    selectAll = [UIButton buttonWithType:UIButtonTypeCustom];
    selectAll.titleLabel.font = [UIFont systemFontOfSize:13];
    [selectAll setTitle:@"全选" forState:UIControlStateNormal];
    [selectAll setImage:[UIImage imageNamed:@"cart_unSelect_btn1"] forState:UIControlStateNormal];
    
    
    UIImage *theImage = [UIImage imageNamed:@"cart_selected_btn1"];
    theImage = [theImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [selectAll setImage:theImage forState:UIControlStateSelected];
    [selectAll setTintColor:[UIColor redColor]];
    
    [selectAll setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [selectAll addTarget:self action:@selector(selectAllBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:selectAll];
#pragma mark -- 底部视图添加约束
    //全选按钮
    [selectAll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView).offset(10);
        make.top.equalTo(@10);
        make.bottom.equalTo(bgView).offset(-10);
        make.width.equalTo(@60);
        
    }];
    
    
    btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = RGBACOLOR(42, 162, 153, 1.0);
    [btn setTitle:@"确定" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(goPayBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView);
        make.right.equalTo(bgView);
        make.bottom.equalTo(bgView);
        make.width.equalTo(@150);
    }];
    
    
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = RGBACOLOR(250, 180, 30, 1.0);
    [button setTitle:@"查询物品" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(goShoppingBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView).offset(0);
        make.bottom.equalTo(bgView).offset(0);
        make.right.equalTo(btn.mas_left);
        make.width.equalTo(@100);
    }];
    
}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 135;
}

#pragma mark - tableView 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifierCell = @"cell";
    WPLY_edit_Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
    if (cell == nil) {
        cell = [[WPLY_edit_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
    }
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.isSelected = isSelect;
    
    //是否被选中
    if ([selectGoods containsObject:[dataArray objectAtIndex:indexPath.row]]) {
        cell.isSelected = YES;
    }
    
    //选择回调
    cell.cartBlock = ^(BOOL isSelec){
        
        if (isSelec) {
            [selectGoods addObject:[dataArray objectAtIndex:indexPath.row]];
            [deleateArr addObject:[dataArray objectAtIndex:indexPath.row]];
        }
        else
        {
            [selectGoods removeObject:[dataArray objectAtIndex:indexPath.row]];
            [deleateArr removeObject:[dataArray objectAtIndex:indexPath.row]];
        }
        
        if (selectGoods.count == dataArray.count) {
            selectAll.selected = YES;
        }
        else
        {
            selectAll.selected = NO;
        }
        
    };
    
    [cell reloadDataWith:[dataArray objectAtIndex:indexPath.row]];
    
    return cell;
}


@end
