//
//  GongZiJieGouTableViewController.m
//  AFEFactory
//
//  Created by ilovedxracer on 2018/1/30.
//  Copyright © 2018年 ilovedxracer. All rights reserved.
//

#import "GongZiJieGouTableViewController.h"
#import "LLDCK_10_Cell.h"
#import "PaiDanModel.h"
@interface GongZiJieGouTableViewController ()
{
    UIView *vie;
    
    BOOL isorno;
    UILabel *lab1;
    UILabel *lab2;
    UILabel *lab3;
    UILabel *lab4;
    UILabel *lab5;
    UILabel *lab6;
   
    UILabel *lines;
    UIImageView *img;
    
    NSString *type;
}
@property(nonatomic,strong)NSMutableArray *dataArray;
@end

@implementation GongZiJieGouTableViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"LLDCK_10_Cell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    self.tableView.tableHeaderView = v;
    
    [self setuptopview];
    
    [self loddeList];
}

- (void)setuptopview{
    vie = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH-20, 47)];
    lable.text = @"工资结构";
    lable.font = [UIFont systemFontOfSize:18];
    lable.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickinfor:)];
    [lable addGestureRecognizer:tap];
    [vie addSubview:lable];
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, 47, SCREEN_WIDTH, 3)];
    line.backgroundColor = RGBACOLOR(228, 228, 228, 1);
    [vie addSubview:line];
    self.tableView.tableHeaderView = vie;
    
    img = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-30, 15, 20, 20)];
    img.image = [UIImage imageNamed:@"jiantou"];
    [vie addSubview:img];
    
    lab1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 55, SCREEN_WIDTH-20, 20)];
    lab1.hidden = YES;
    lab1.font = [UIFont systemFontOfSize:15];
    lab1.textColor = [UIColor redColor];
    [vie addSubview:lab1];
    
    lab2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 80, SCREEN_WIDTH-20, 20)];
    lab2.hidden = YES;
    lab2.font = [UIFont systemFontOfSize:15];
    lab2.textColor = [UIColor redColor];
    [vie addSubview:lab2];
    
    lab3 = [[UILabel alloc]initWithFrame:CGRectMake(10, 105, SCREEN_WIDTH-20, 20)];
    lab3.hidden = YES;
    lab3.font = [UIFont systemFontOfSize:15];
    lab3.textColor = [UIColor redColor];
    [vie addSubview:lab3];
    
    lab4 = [[UILabel alloc]initWithFrame:CGRectMake(10, 130, SCREEN_WIDTH-20, 20)];
    lab4.hidden = YES;
    lab4.font = [UIFont systemFontOfSize:15];
    lab4.textColor = [UIColor redColor];
    [vie addSubview:lab4];
    
    lab5 = [[UILabel alloc]initWithFrame:CGRectMake(10, 155, SCREEN_WIDTH-20, 20)];
    lab5.hidden = YES;
    lab5.font = [UIFont systemFontOfSize:15];
    lab5.textColor = [UIColor redColor];
    [vie addSubview:lab5];
    
    lab6 = [[UILabel alloc]initWithFrame:CGRectMake(10, 180, SCREEN_WIDTH-20, 20)];
    lab6.hidden = YES;
    lab6.font = [UIFont systemFontOfSize:15];
    lab6.textColor = [UIColor redColor];
    [vie addSubview:lab6];
    
    lines = [[UILabel alloc]initWithFrame:CGRectMake(0, 207, SCREEN_WIDTH, 3)];
    lines.backgroundColor = RGBACOLOR(228, 228, 228, 1);
    lines.hidden = YES;
    [vie addSubview:lines];
    
    
}
- (void)clickinfor:(UITapGestureRecognizer *)sender{
    if (isorno == NO) {
        vie.frame = CGRectMake(0, 0, SCREEN_WIDTH, 210);
        self.tableView.tableHeaderView = vie;
        lab1.hidden = NO;
        lab2.hidden = NO;
        lab3.hidden = NO;
        lab4.hidden = NO;
        lab5.hidden = NO;
        lab6.hidden = NO;
        lines.hidden = NO;
        img.image = [UIImage imageNamed:@"jiantou1"];
        [vie addSubview:img];
    }else{
        vie.frame = CGRectMake(0, 0, SCREEN_WIDTH, 50);
        self.tableView.tableHeaderView = vie;
        lab1.hidden = YES;
        lab2.hidden = YES;
        lab3.hidden = YES;
        lab4.hidden = YES;
        lab5.hidden = YES;
        lab6.hidden = YES;
        lines.hidden = YES;
        img.image = [UIImage imageNamed:@"jiantou"];
        [vie addSubview:img];
    }
    isorno = !isorno;
}















#pragma mark - Table view data source
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    PaiDanModel *model = [self.dataArray objectAtIndex:indexPath.row];
    if (model.detailList.count == 1) {
        return 180;
    }else if (model.detailList.count == 2) {
        return 210;
    }
    return 255;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    
    
    
    
    
    static NSString *identifierCell = @"cell";
    LLDCK_10_Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
    if (cell == nil) {
        cell = [[LLDCK_10_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    PaiDanModel *model = [self.dataArray objectAtIndex:indexPath.row];
    
    
    cell.lab1.text  = [NSString stringWithFormat:@"日   期：%@",model.card_model.salaryMonth];
    cell.lab2.text  = [NSString stringWithFormat:@"薪资方式：%@",type];
    
    if (model.card_model.actTotalResult != nil) {
        cell.lab3.text  = [NSString stringWithFormat:@"税前小计：%@",model.card_model.actTotalResult];
    }else{
        cell.lab3.text  = [NSString stringWithFormat:@"税前小计：%@",@"-"];
    }
    
    
    
    if (model.detailList.count == 1) {
        PaidanModel1 *model0 = model.detailList[0];
        if (model0.salary_total == nil) {
            model0.salary_total = @"";
        }
        cell.lab4.text   = [NSString stringWithFormat:@"%@：%@",model0.salary_type,model0.salary_total];
        cell.lab5.hidden = YES;
        cell.lab6.hidden = YES;
    }
    else if (model.detailList.count == 2){
        PaidanModel1 *model0 = model.detailList[0];
        PaidanModel1 *model1 = model.detailList[1];
        if (model0.salary_total == nil) {
            model0.salary_total = @"";
        }
        if (model1.salary_total == nil) {
            model1.salary_total = @"";
        }
        cell.lab4.text   = [NSString stringWithFormat:@"%@：%@",model0.salary_type,model0.salary_total];
        cell.lab5.text  = [NSString stringWithFormat:@"%@：%@",model1.salary_type,model1.salary_total];
        cell.lab5.hidden = NO;
        cell.lab6.hidden = YES;
    }
    else if (model.detailList.count == 3){
        PaidanModel1 *model0 = model.detailList[0];
        PaidanModel1 *model1 = model.detailList[1];
        PaidanModel1 *model2 = model.detailList[2];
        if (model0.salary_total == nil) {
            model0.salary_total = @"";
        }
        if (model1.salary_total == nil) {
            model1.salary_total = @"";
        }
        if (model2.salary_total == nil) {
            model2.salary_total = @"";
        }
        cell.lab4.text   = [NSString stringWithFormat:@"%@：%@",model0.salary_type,model0.salary_total];
        cell.lab5.text  = [NSString stringWithFormat:@"%@：%@",model1.salary_type,model1.salary_total];
        cell.lab6.text  = [NSString stringWithFormat:@"%@：%@",model2.salary_type,model2.salary_total];
        cell.lab5.hidden = NO;
        cell.lab6.hidden = NO;
    }
    else if (model.detailList.count == 4){
        PaidanModel1 *model0 = model.detailList[0];
        PaidanModel1 *model1 = model.detailList[1];
        PaidanModel1 *model2 = model.detailList[2];
        PaidanModel1 *model3 = model.detailList[3];
        if (model0.salary_total == nil) {
            model0.salary_total = @"";
        }
        if (model1.salary_total == nil) {
            model1.salary_total = @"";
        }
        if (model2.salary_total == nil) {
            model2.salary_total = @"";
        }
        if (model3.salary_total == nil) {
            model3.salary_total = @"";
        }
        cell.lab4.text   = [NSString stringWithFormat:@"%@：%@   %@：%@",model0.salary_type,model0.salary_total,model1.salary_type,model1.salary_total];
        cell.lab5.text  = [NSString stringWithFormat:@"%@：%@",model2.salary_type,model2.salary_total];
        cell.lab6.text  = [NSString stringWithFormat:@"%@：%@",model3.salary_type,model3.salary_total];
        cell.lab5.hidden = NO;
        cell.lab6.hidden = NO;
    }
    else if (model.detailList.count == 5){
        PaidanModel1 *model0 = model.detailList[0];
        PaidanModel1 *model1 = model.detailList[1];
        PaidanModel1 *model2 = model.detailList[2];
        PaidanModel1 *model3 = model.detailList[3];
        PaidanModel1 *model4 = model.detailList[4];
        if (model0.salary_total == nil) {
            model0.salary_total = @"";
        }
        if (model1.salary_total == nil) {
            model1.salary_total = @"";
        }
        if (model2.salary_total == nil) {
            model2.salary_total = @"";
        }
        if (model3.salary_total == nil) {
            model3.salary_total = @"";
        }
        if (model4.salary_total == nil) {
            model4.salary_total = @"";
        }
        cell.lab4.text   = [NSString stringWithFormat:@"%@：%@   %@：%@",model0.salary_type,model0.salary_total,model1.salary_type,model1.salary_total];
        cell.lab5.text  = [NSString stringWithFormat:@"%@：%@   %@：%@",model2.salary_type,model2.salary_total,model3.salary_type,model3.salary_total];
        cell.lab6.text  = [NSString stringWithFormat:@"%@：%@",model4.salary_type,model4.salary_total];
        cell.lab5.hidden = NO;
        cell.lab6.hidden = NO;
    }
    else if (model.detailList.count == 6){
        PaidanModel1 *model0 = model.detailList[0];
        PaidanModel1 *model1 = model.detailList[1];
        PaidanModel1 *model2 = model.detailList[2];
        PaidanModel1 *model3 = model.detailList[3];
        PaidanModel1 *model4 = model.detailList[4];
        PaidanModel1 *model5 = model.detailList[5];
        if (model0.salary_total == nil) {
            model0.salary_total = @"";
        }
        if (model1.salary_total == nil) {
            model1.salary_total = @"";
        }
        if (model2.salary_total == nil) {
            model2.salary_total = @"";
        }
        if (model3.salary_total == nil) {
            model3.salary_total = @"";
        }
        if (model4.salary_total == nil) {
            model4.salary_total = @"";
        }
        if (model5.salary_total == nil) {
            model5.salary_total = @"";
        }
        cell.lab4.text   = [NSString stringWithFormat:@"%@：%@   %@：%@",model0.salary_type,model0.salary_total,model1.salary_type,model1.salary_total];
        cell.lab5.text  = [NSString stringWithFormat:@"%@：%@   %@：%@",model2.salary_type,model2.salary_total,model3.salary_type,model3.salary_total];
        cell.lab6.text  = [NSString stringWithFormat:@"%@：%@   %@：%@",model4.salary_type,model4.salary_total ,model5.salary_type,model5.salary_total];
        cell.lab5.hidden = NO;
        cell.lab6.hidden = NO;
    }
    
    cell.lab7.hidden = YES;
    cell.lab8.hidden = YES;
    cell.lab9.hidden = YES;
    cell.lab10.hidden = YES;
    return cell;
}







- (void)loddeList{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"bianhao.text"],
            @"personId":[Manager redingwenjianming:@"id.text"],
            };
    [session POST:KURLNSString(@"servlet/salary/mysalary/detailhtm") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
//        NSLog(@"===---======-%@",dic);
        
        [weakSelf.dataArray removeAllObjects];
        if (![[dic objectForKey:@"cardResultList"]isEqual:[NSNull null]]) {
            NSMutableArray *arr = [dic objectForKey:@"cardResultList"];
            for (NSDictionary *dict in arr) {
                [PaiDanModel mj_setupObjectClassInArray:^NSDictionary *{
                    return @{
                             @"detailList" : [PaidanModel1 class],
                             };
                }];
                PaiDanModel *model = [PaiDanModel mj_objectWithKeyValues:dict];
                PaidanModel1 *model1 = [PaidanModel1 mj_objectWithKeyValues:model.card];
                model.card_model = model1;
                [weakSelf.dataArray addObject:model];
            }
        }
        
        NSDictionary *dict = [dic objectForKey:@"departmentPersonSalay"];
        lab1.text = [NSString stringWithFormat:@"姓名：%@",[dict objectForKey:@"real_name"]];
        lab2.text = [NSString stringWithFormat:@"部门名称：%@",[dict objectForKey:@"department_name"]];
        lab3.text = [NSString stringWithFormat:@"岗位名称：%@",[dict objectForKey:@"position_name"]];
        lab4.text = [NSString stringWithFormat:@"薪资方式：%@",[dict objectForKey:@"type"]];
        lab5.text = [NSString stringWithFormat:@"绩效工资(月)：%@",[dict objectForKey:@"performance_salary_id"]];
        lab6.text = [NSString stringWithFormat:@"合计：%@",@"绩效工资(月)+实际每月计件工资"];
        
        type = [dict objectForKey:@"type"];
        
        [weakSelf.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    view.backgroundColor = [UIColor whiteColor];
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH-20, 47)];
    lab.text = @"税前工资";
    [view addSubview:lab];
    
    UILabel *lines = [[UILabel alloc]initWithFrame:CGRectMake(0, 47, SCREEN_WIDTH, 3)];
    lines.backgroundColor = RGBACOLOR(228, 228, 228, 1);
    [view addSubview:lines];
    return view;
}
- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        self.dataArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray;
}
@end
