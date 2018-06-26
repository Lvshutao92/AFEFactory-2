//
//  RenYuanPeiZhi_ViewController.m
//  AFEFactory
//
//  Created by ilovedxracer on 2017/12/5.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "RenYuanPeiZhi_ViewController.h"
#import "PaiDanModel.h"
#import "PaidanModel1.h"
#import "PaidanModel2.h"
@interface RenYuanPeiZhi_ViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>
{
    NSInteger inter;
    UIButton  *btn;
}
@property(nonatomic,strong)UIScrollView *scrollview;
@property(nonatomic,strong)UIView *bgview;


@property(nonatomic,strong)UIImageView *img;

@property(nonatomic,strong)UILabel *celllab1;

@property(nonatomic,strong)UILabel *celllab2;

@property(nonatomic,strong)UILabel *celllab3;

@property(nonatomic,strong)UILabel *celllab4;
@property(nonatomic,strong)UITextField *textfield;

@property(nonatomic,strong)NSMutableArray *tablearr;
@property(nonatomic,strong)NSMutableArray *textarr;
@property(nonatomic,assign)NSInteger index;


@property(nonatomic,strong)NSMutableArray *dataArray;


@property(nonatomic,strong)NSMutableArray *idarr;
@property(nonatomic,strong)NSMutableArray *strarr;



@property(nonatomic, strong)UITableView *tableview1;
@property(nonatomic, strong)NSMutableArray *dataArray1;
@end

@implementation RenYuanPeiZhi_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"人员配置";
    
    self.scrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.scrollview.contentSize = CGSizeMake(0, SCREEN_HEIGHT);
    self.scrollview.backgroundColor = RGBACOLOR(230, 230, 230, 1);
    [self.view addSubview:self.scrollview];
    
    UITapGestureRecognizer *taps = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapgesture:)];
    taps.delegate = self;
    [self.scrollview addGestureRecognizer:taps];
    
    
    btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, SCREEN_HEIGHT-50, SCREEN_WIDTH, 50);
    btn.backgroundColor = RGBACOLOR(32.0, 157.0, 149.0, 1.0);
    [btn setTitle:@"保存" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickadd) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    self.tableview1 = [[UITableView alloc]init];
    self.tableview1.frame = CGRectMake(180, 130, SCREEN_WIDTH-190, SCREEN_HEIGHT-170);
    [self.tableview1.layer setBorderColor:[UIColor colorWithWhite:.5 alpha:.5].CGColor];
    [self.tableview1.layer setBorderWidth:1];
    self.tableview1.delegate = self;
    self.tableview1.dataSource = self;
    self.tableview1.hidden = YES;
    [self.tableview1 registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableview1];
    [self.view bringSubviewToFront:self.tableview1];
    
    
    
    
    [self lodxialalist];
    
    [self lodlist];
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([touch.view isDescendantOfView:self.tableview1])
    {
        return NO;
    }
    return YES;
}

- (void)tapgesture:(UITapGestureRecognizer *)sender{
    self.tableview1.hidden = YES;
}

- (void)clickadd{
    NSString *itemId = @"";
    NSString *person = @"";
    
    for (int i = 0; i<self.idarr.count; i++) {
        NSString *model = [self.idarr objectAtIndex:i];
        person = [person stringByAppendingString:[NSString stringWithFormat:@",%@",model]];
    }
    
    
    
    for (int i = 0; i<self.dataArray1.count; i++) {
        PaiDanModel *model = [self.dataArray1 objectAtIndex:i];
        itemId = [itemId stringByAppendingString:[NSString stringWithFormat:@",%@",model.modelCraftBom_model.id]];
    }
    
//    NSMutableArray *itemarr   = [NSMutableArray arrayWithCapacity:1];
//    NSMutableArray *personarr = [NSMutableArray arrayWithCapacity:1];
//    for (int i = 0; i<self.dataArray.count; i++) {
//        PaiDanModel *model = [self.dataArray objectAtIndex:i];
//        [personarr addObject:model.id];
//    }
//
//    for (int i = 0; i<self.dataArray1.count; i++) {
//        PaiDanModel *model = [self.dataArray1 objectAtIndex:i];
//        [itemarr addObject:model.modelCraftBom_model.id];
//    }
    if ([self.idarr containsObject:@"0"]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"负责人必须全部选择" message:@"温馨提示" preferredStyle:1];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:nil];
    }else{
        AFHTTPSessionManager *session = [Manager returnsession];
        __weak typeof(self) weakSelf = self;
        NSDictionary *dic = [[NSDictionary alloc]init];
        dic = @{@"businessId":[Manager redingwenjianming:@"bianhao.text"],
                @"craftId":self.idstr,
                @"orderPersonId":self.idstr1,
                
                @"personIds":[person substringFromIndex:1],
                @"itemIds":[itemId substringFromIndex:1],
                };
//             NSLog(@"====%@",dic);
        [session POST:KURLNSString(@"servlet/productionconfig/productionorderpersondetail/bind") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary *dic = [Manager returndictiondata:responseObject];
//            NSLog(@"====%@",dic);
            if ([[dic objectForKey:@"code"]isEqualToString:@"success"]) {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"保存成功" message:@"温馨提示" preferredStyle:1];
                UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                }];
                [alert addAction:cancel];
                [weakSelf presentViewController:alert animated:YES completion:nil];
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        }];
    }
    
    
    
    
    
    
    
    
    
    
}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifierCell = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    PaiDanModel *model = [self.dataArray objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@",model.personCode,model.realName];
    
    return cell;
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.tableview1.hidden = YES;
    
    
    PaiDanModel *model = [self.dataArray objectAtIndex:indexPath.row];
    
    UITextField *text  = [self.textarr objectAtIndex:inter];
    
    text.text = [NSString stringWithFormat:@"%@ %@",model.personCode,model.realName];
    
    
//    NSLog(@"%@--------%ld",model.id,inter);
    
    
    [self.idarr replaceObjectAtIndex:inter withObject:model.id];
    
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    
    
    
    if (self.tableview1.hidden == YES) {
        self.tableview1.hidden = NO;
    }else{
        self.tableview1.hidden = YES;
    }
    
    
    
    
    
    int i = 0;
    for (UITextField *textf in self.textarr) {
        
        if ([textField isEqual:textf]) {
            inter = i;
        }
        i++;
    }
    
    return NO;
}








- (void)lodlist{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"bianhao.text"],
            @"departmentId":[Manager redingwenjianming:@"departmentId.text"],
            @"craftId":self.idstr,
            @"orderPersonId":self.idstr1,
            };
    [session POST:KURLNSString(@"servlet/productionconfig/productionorderpersondetail/list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
//        NSLog(@"%@",dic);
        [weakSelf.dataArray1 removeAllObjects];
//        [weakSelf.idarr removeAllObjects];
//        [weakSelf.strarr removeAllObjects];
        NSMutableArray *arr = (NSMutableArray *)dic;
        for (NSDictionary *dict in arr) {
            
            PaiDanModel *model = [PaiDanModel mj_objectWithKeyValues:dict];
            
            PaidanModel1 *model0 = [PaidanModel1 mj_objectWithKeyValues:model.productionOrderPersonDetail];
            model.productionOrderPersonDetail_model = model0;
            
            
            
            PaidanModel1 *model1 = [PaidanModel1 mj_objectWithKeyValues:model.modelCraftBom];
            model.modelCraftBom_model = model1;
            
            
            
            
            PaidanModel2 *model2 = [PaidanModel2 mj_objectWithKeyValues:model1.modelCraftType];
            model1.modelCraftType_model = model2;
            
            PaidanModel2 *model3 = [PaidanModel2 mj_objectWithKeyValues:model1.modelCraftStep];
            model1.modelCraftStep_model = model3;
            
            PaidanModel2 *model4 = [PaidanModel2 mj_objectWithKeyValues:model1.modelCraftProcedure];
            model1.modelCraftProcedure_model = model4;
            
            [weakSelf.dataArray1 addObject:model];
        }
        

        [weakSelf.idarr removeAllObjects];
        
        for (int i = 0; i<weakSelf.dataArray1.count; i++) {
            PaiDanModel *model = weakSelf.dataArray1[i];
            weakSelf.scrollview.contentSize = CGSizeMake(0, 200*i+250);
            weakSelf.index = i;
            NSString *str1 = @"";;
            NSString *str2 = @"";
            NSString *str3 = @"0";
            for (PaiDanModel *modeld in weakSelf.dataArray) {
                    if ([modeld.id isEqualToString:model.productionOrderPersonDetail_model.personId]) {
                        str1 = modeld.personCode;
                        str2 = modeld.realName;
                        str3 = modeld.id;
                        break;
                    }
            }
            [weakSelf setupview:200*i
                         imgstr:model.modelCraftBom_model.modelCraftStep_model.stepImg str1:model.modelCraftBom_model.modelCraftStep_model.stepName str2:model.modelCraftBom_model.modelCraftProcedure_model.name str3:model.modelCraftBom_model.modelCraftType_model.name
                        textstr:[NSString stringWithFormat:@"%@ %@",str1,str2]];
            [weakSelf.idarr addObject:str3];
        }
        
        [weakSelf.view addSubview:btn];
        [weakSelf.view bringSubviewToFront:btn];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
    
    
}


- (void)setupview:(CGFloat )height imgstr:(NSString *)imgstr str1:(NSString *)str1 str2:(NSString *)str2 str3:(NSString *)str3 textstr:(NSString *)textstr{
    
    self.bgview = [[UIView alloc]initWithFrame:CGRectMake(0, height, SCREEN_WIDTH, 190)];
    self.bgview.backgroundColor = [UIColor whiteColor];
    [self.scrollview addSubview:self.bgview];
    
    self.img = [[UIImageView alloc]initWithFrame:CGRectMake(10, 45, 100, 100)];
    [self.img sd_setImageWithURL:[NSURL URLWithString:NSString(imgstr)]placeholderImage:[UIImage imageNamed:@"user"]];
    [self.bgview addSubview:self.img];
    
    
    self.celllab1 = [[UILabel alloc]initWithFrame:CGRectMake(115, 15, SCREEN_WIDTH-120, 30)];
    self.celllab1.text = [NSString stringWithFormat:@"步骤名称：%@",str1];
    [self.bgview addSubview:self.celllab1];
    
    self.celllab2 = [[UILabel alloc]initWithFrame:CGRectMake(115, 55, SCREEN_WIDTH-120, 30)];
    self.celllab2.text = [NSString stringWithFormat:@"步骤位置：%@",str2];
    [self.bgview addSubview:self.celllab2];
    
    
    self.celllab3 = [[UILabel alloc]initWithFrame:CGRectMake(115, 95, SCREEN_WIDTH-120, 30)];
    self.celllab3.text = [NSString stringWithFormat:@"工艺类型：%@",str3];
    [self.bgview addSubview:self.celllab3];
    
    
    self.celllab4 = [[UILabel alloc]initWithFrame:CGRectMake(115, 135, 70, 30)];
    self.celllab4.text = @"负责人：";
    [self.bgview addSubview:self.celllab4];
    
    self.celllab1.font = [UIFont systemFontOfSize:14];
    self.celllab2.font = [UIFont systemFontOfSize:14];
    self.celllab3.font = [UIFont systemFontOfSize:14];
    self.celllab4.font = [UIFont systemFontOfSize:14];
    
    self.textfield = [[UITextField alloc]initWithFrame:CGRectMake(180, 135, SCREEN_WIDTH-190, 30)];
    self.textfield.delegate = self;
    self.textfield.text = textstr;
    self.textfield.borderStyle = UITextBorderStyleRoundedRect;
    
    [self.textarr addObject:self.textfield];
    
    [self.bgview addSubview:self.textfield];
   
}






- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.tableview1.hidden = YES;
}





- (void)lodxialalist{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"bianhao.text"],
            @"departmentId":[Manager redingwenjianming:@"departmentId.text"],
            };
    [session POST:KURLNSString(@"servlet/productionconfig/productionorderpersondetail/add/inittext") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
//         NSLog(@"%@",dic);
        [weakSelf.dataArray removeAllObjects];
        NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"personList"];
        for (NSDictionary *dict in arr) {
            PaiDanModel *model = [PaiDanModel mj_objectWithKeyValues:dict];
            [weakSelf.dataArray addObject:model];
        }
        [weakSelf.tableview1 reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}






- (NSMutableArray *)idarr {
    if (_idarr == nil) {
        self.idarr = [NSMutableArray arrayWithCapacity:1];
    }
    return _idarr;
}

- (NSMutableArray *)tablearr {
    if (_tablearr == nil) {
        self.tablearr = [NSMutableArray arrayWithCapacity:1];
    }
    return _tablearr;
}
- (NSMutableArray *)dataArray1 {
    if (_dataArray1 == nil) {
        self.dataArray1 = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray1;
}
- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        self.dataArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray;
}
- (NSMutableArray *)textarr{
    if (_textarr == nil) {
        self.textarr = [NSMutableArray arrayWithCapacity:1];
    }
    return _textarr;
}
@end
