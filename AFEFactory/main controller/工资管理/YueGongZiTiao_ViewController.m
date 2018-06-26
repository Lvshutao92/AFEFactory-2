//
//  YueGongZiTiao_ViewController.m
//  AFEFactory
//
//  Created by ilovedxracer on 2018/1/30.
//  Copyright © 2018年 ilovedxracer. All rights reserved.
//

#import "YueGongZiTiao_ViewController.h"
#import "GongZiTiao_Cell.h"
#import "PaiDanModel.h"
@interface YueGongZiTiao_ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    CGFloat height;
}
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(strong,nonatomic)UITableView    *tableView;
@end

@implementation YueGongZiTiao_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"GongZiTiao_Cell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    [self lodinit];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 740+height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifierCell = @"cell";
    GongZiTiao_Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
    if (cell == nil) {
        cell = [[GongZiTiao_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    PaiDanModel *model = [self.dataArray objectAtIndex:indexPath.row];
    
    
    cell.lab1.text = [NSString stringWithFormat:@"%@",model.salaryDate];
    cell.lab2.text = [NSString stringWithFormat:@"%@",model.departmentName];
    cell.lab3.text = [NSString stringWithFormat:@"%@",model.positionName];
    cell.lab4.text = [NSString stringWithFormat:@"%@",model.realName];
    
    cell.lab5.text  = model.planTotalFee;
    cell.lab6.text  = model.actTotalFee;
    cell.lab7.text  = model.tax;
    cell.lab8.text  = model.accumulationFundPersosn;
    cell.lab9.text  = model.accumulationFundCompany;
    cell.lab10.text = model.baseSalarySocialSecurity;
    cell.lab11.text = model.socialSecurityPerson;
    cell.lab12.text = model.socialSecurityCompany;
    
    cell.lab13.text = model.socialSecurityPersonDetailMap_model.pension_person;
    cell.lab14.text = model.socialSecurityPersonDetailMap_model.base_care_person;
    cell.lab15.text = model.socialSecurityPersonDetailMap_model.unemployment_person;
    
    cell.lab16.text = model.socialSecurityCompanyDetailMap_model.pension_company;
    cell.lab17.text = model.socialSecurityCompanyDetailMap_model.base_care_company;
    cell.lab18.text = model.socialSecurityCompanyDetailMap_model.unemployment_company;
    cell.lab19.text = model.socialSecurityCompanyDetailMap_model.birth_company;
    cell.lab20.text = model.socialSecurityCompanyDetailMap_model.injury_company;
    cell.lab21.text = model.socialSecurityCompanyDetailMap_model.treatment_company;
    
    
    
    
    if (model.detailJson.count == 1) {
        PaidanModel1 *model0 = model.detailJson[0];
        cell.a.text = model0.salary_type;
        cell.lab22.text = model0.salary_total;
        
        cell.dHeight.constant = 0;
        cell.dTop.constant = 0;
        cell.eHeight.constant = 0;
        cell.eTop.constant = 0;
        cell.fHeight.constant = 0;
        cell.fTop.constant = 0;
        cell.lab25Height.constant = 0;
        cell.lab25Top.constant = 0;
        cell.lab26Height.constant = 0;
        cell.lab26Top.constant = 0;
        cell.lab27Height.constant = 0;
        cell.lab27Top.constant = 0;
        height = 120;
        
        cell.b.hidden = YES;
        cell.c.hidden = YES;
        cell.d.hidden = YES;
        cell.e.hidden = YES;
        cell.f.hidden = YES;
        cell.lab23.hidden = YES;
        cell.lab24.hidden = YES;
        cell.lab25.hidden = YES;
        cell.lab26.hidden = YES;
        cell.lab27.hidden = YES;
        
    }else if (model.detailJson.count == 2) {
        PaidanModel1 *model0 = model.detailJson[0];
        PaidanModel1 *model1 = model.detailJson[1];
        cell.a.text = model0.salary_type;
        cell.b.text = model1.salary_type;
        cell.lab22.text = model0.salary_total;
        cell.lab23.text = model1.salary_total;
        
        cell.dHeight.constant = 0;
        cell.dTop.constant = 0;
        cell.eHeight.constant = 0;
        cell.eTop.constant = 0;
        cell.fHeight.constant = 0;
        cell.fTop.constant = 0;
        cell.lab25Height.constant = 0;
        cell.lab25Top.constant = 0;
        cell.lab26Height.constant = 0;
        cell.lab26Top.constant = 0;
        cell.lab27Height.constant = 0;
        cell.lab27Top.constant = 0;
        height = 120;
        cell.b.hidden = NO;
        cell.c.hidden = YES;
        cell.d.hidden = YES;
        cell.e.hidden = YES;
        cell.f.hidden = YES;
        cell.lab23.hidden = NO;
        cell.lab24.hidden = YES;
        cell.lab25.hidden = YES;
        cell.lab26.hidden = YES;
        cell.lab27.hidden = YES;
    }else if (model.detailJson.count == 3) {
        PaidanModel1 *model0 = model.detailJson[0];
        PaidanModel1 *model1 = model.detailJson[1];
        PaidanModel1 *model2 = model.detailJson[2];
        
        
        cell.a.text = model0.salary_type;
        cell.b.text = model1.salary_type;
        cell.c.text = model2.salary_type;
        
        
        cell.lab22.text = model0.salary_total;
        cell.lab23.text = model1.salary_total;
        cell.lab24.text = model2.salary_total;
       
        
        cell.dHeight.constant = 0;
        cell.dTop.constant = 0;
        cell.eHeight.constant = 0;
        cell.eTop.constant = 0;
        cell.fHeight.constant = 0;
        cell.fTop.constant = 0;
        cell.lab25Height.constant = 0;
        cell.lab25Top.constant = 0;
        cell.lab26Height.constant = 0;
        cell.lab26Top.constant = 0;
        cell.lab27Height.constant = 0;
        cell.lab27Top.constant = 0;
        height = 120;
        cell.b.hidden = NO;
        cell.c.hidden = NO;
        cell.d.hidden = YES;
        cell.e.hidden = YES;
        cell.f.hidden = YES;
        cell.lab23.hidden = NO;
        cell.lab24.hidden = NO;
        cell.lab25.hidden = YES;
        cell.lab26.hidden = YES;
        cell.lab27.hidden = YES;
    }else if (model.detailJson.count == 4) {
        PaidanModel1 *model0 = model.detailJson[0];
        PaidanModel1 *model1 = model.detailJson[1];
        PaidanModel1 *model2 = model.detailJson[2];
        PaidanModel1 *model3 = model.detailJson[3];
        
        
        cell.a.text = model0.salary_type;
        cell.b.text = model1.salary_type;
        cell.c.text = model2.salary_type;
        cell.d.text = model3.salary_type;
        
        
        cell.lab22.text = model0.salary_total;
        cell.lab23.text = model1.salary_total;
        cell.lab24.text = model2.salary_total;
        cell.lab25.text = model3.salary_total;
        
        
        cell.dHeight.constant = 20;
        cell.dTop.constant = 15;
        cell.eHeight.constant = 20;
        cell.eTop.constant = 15;
        cell.fHeight.constant = 20;
        cell.fTop.constant = 15;
        cell.lab25Height.constant = 20;
        cell.lab25Top.constant = 5;
        cell.lab26Height.constant = 20;
        cell.lab26Top.constant = 5;
        cell.lab27Height.constant = 20;
        cell.lab27Top.constant = 5;
        height = 180;
        
        cell.b.hidden = NO;
        cell.c.hidden = NO;
        cell.d.hidden = NO;
        cell.e.hidden = YES;
        cell.f.hidden = YES;
        cell.lab23.hidden = NO;
        cell.lab24.hidden = NO;
        cell.lab25.hidden = NO;
        cell.lab26.hidden = YES;
        cell.lab27.hidden = YES;
    }else if (model.detailJson.count == 5) {
        PaidanModel1 *model0 = model.detailJson[0];
        PaidanModel1 *model1 = model.detailJson[1];
        PaidanModel1 *model2 = model.detailJson[2];
        PaidanModel1 *model3 = model.detailJson[3];
        PaidanModel1 *model4 = model.detailJson[4];
        
        cell.a.text = model0.salary_type;
        cell.b.text = model1.salary_type;
        cell.c.text = model2.salary_type;
        cell.d.text = model3.salary_type;
        cell.e.text = model4.salary_type;
        
        cell.lab22.text = model0.salary_total;
        cell.lab23.text = model1.salary_total;
        cell.lab24.text = model2.salary_total;
        cell.lab25.text = model3.salary_total;
        cell.lab26.text = model4.salary_total;
        
        
        cell.dHeight.constant = 20;
        cell.dTop.constant = 15;
        cell.eHeight.constant = 20;
        cell.eTop.constant = 15;
        cell.fHeight.constant = 20;
        cell.fTop.constant = 15;
        cell.lab25Height.constant = 20;
        cell.lab25Top.constant = 5;
        cell.lab26Height.constant = 20;
        cell.lab26Top.constant = 5;
        cell.lab27Height.constant = 20;
        cell.lab27Top.constant = 5;
        height = 180;
        
        cell.b.hidden = NO;
        cell.c.hidden = NO;
        cell.d.hidden = NO;
        cell.e.hidden = NO;
        cell.f.hidden = YES;
        cell.lab23.hidden = NO;
        cell.lab24.hidden = NO;
        cell.lab25.hidden = NO;
        cell.lab26.hidden = NO;
        cell.lab27.hidden = YES;
    }else if (model.detailJson.count == 6) {
        PaidanModel1 *model0 = model.detailJson[0];
        PaidanModel1 *model1 = model.detailJson[1];
        PaidanModel1 *model2 = model.detailJson[2];
        PaidanModel1 *model3 = model.detailJson[3];
        PaidanModel1 *model4 = model.detailJson[4];
        PaidanModel1 *model5 = model.detailJson[5];
        
        cell.a.text = model0.salary_type;
        cell.b.text = model1.salary_type;
        cell.c.text = model2.salary_type;
        cell.d.text = model3.salary_type;
        cell.e.text = model4.salary_type;
        cell.f.text = model5.salary_type;
        
        cell.lab22.text = model0.salary_total;
        cell.lab23.text = model1.salary_total;
        cell.lab24.text = model2.salary_total;
        cell.lab25.text = model3.salary_total;
        cell.lab26.text = model4.salary_total;
        cell.lab27.text = model5.salary_total;
        
        
        cell.dHeight.constant = 20;
        cell.dTop.constant = 15;
        cell.eHeight.constant = 20;
        cell.eTop.constant = 15;
        cell.fHeight.constant = 20;
        cell.fTop.constant = 15;
        cell.lab25Height.constant = 20;
        cell.lab25Top.constant = 5;
        cell.lab26Height.constant = 20;
        cell.lab26Top.constant = 5;
        cell.lab27Height.constant = 20;
        cell.lab27Top.constant = 5;
        height = 180;
        cell.b.hidden = NO;
        cell.c.hidden = NO;
        cell.d.hidden = NO;
        cell.e.hidden = NO;
        cell.f.hidden = NO;
        cell.lab23.hidden = NO;
        cell.lab24.hidden = NO;
        cell.lab25.hidden = NO;
        cell.lab26.hidden = NO;
        cell.lab27.hidden = NO;
    }
    
    
    cell.lab28.text = model.planTotalFee;
    cell.lab29.text = [NSString stringWithFormat:@"-%@",model.accumulationFundPersosn];
    cell.lab30.text = [NSString stringWithFormat:@"-%@",model.socialSecurityPerson];
    cell.lab31.text = [NSString stringWithFormat:@"-%@",model.tax];
    
    return cell;
}

- (void)lodinit{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"bianhao.text"],
            @"personId":[Manager redingwenjianming:@"id.text"],
            };
    [session POST:KURLNSString(@"servlet/salary/salarypayroll/mySalaryByMonthhtm") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
//      NSLog(@"guowai----%@",dic);
        [weakSelf.dataArray removeAllObjects];
        if (![[dic objectForKey:@"salaryPayrollList"] isEqual:[NSNull null]]) {
            NSMutableArray *arr = [dic objectForKey:@"salaryPayrollList"];
            for (NSDictionary *dic in arr) {
                [PaiDanModel mj_setupObjectClassInArray:^NSDictionary *{
                    return @{
                             @"detailJson" : [PaidanModel1 class],
                             };
                }];
                PaiDanModel *model = [PaiDanModel mj_objectWithKeyValues:dic];
                PaidanModel1 *model1 = [PaidanModel1 mj_objectWithKeyValues:model.socialSecurityPersonDetailMap];
                model.socialSecurityPersonDetailMap_model = model1;
                
                PaidanModel1 *model2 = [PaidanModel1 mj_objectWithKeyValues:model.socialSecurityCompanyDetailMap];
                model.socialSecurityCompanyDetailMap_model = model2;
                
                [weakSelf.dataArray addObject:model];
            }
        }
        [weakSelf.tableView reloadData];
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
