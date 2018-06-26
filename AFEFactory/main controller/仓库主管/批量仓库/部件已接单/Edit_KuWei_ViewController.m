//
//  Edit_KuWei_ViewController.m
//  Factory
//
//  Created by ilovedxracer on 2017/11/28.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "Edit_KuWei_ViewController.h"
#import "PaiDanModel.h"
@interface Edit_KuWei_ViewController ()<UITextFieldDelegate>

@property(nonatomic,strong)UIScrollView *scrollview;


@property(nonatomic,strong)UIView *bgview;

@property(nonatomic,strong)UILabel *celllab1;
@property(nonatomic,strong)UILabel *celllab2;
@property(nonatomic,strong)UILabel *celllab3;


@property(nonatomic,strong)UITextField *textfield;
@property(nonatomic,strong)NSMutableArray *arr;
@property(nonatomic,assign)NSInteger index;

@property(nonatomic,strong)NSMutableArray *dataArray;

@property(nonatomic,strong)NSMutableArray *idarr;
@property(nonatomic,strong)NSMutableArray *strarr;
@end

@implementation Edit_KuWei_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"设置存放位置";
    self.lab1.text = self.lab1str;
    self.lab2.text = self.lab2str;
    self.lab3.text = self.lab3str;
    self.lab4.text = self.lab4str;
    
    self.scrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 240, SCREEN_WIDTH, SCREEN_HEIGHT-290)];
    self.scrollview.contentSize = CGSizeMake(0, SCREEN_HEIGHT);
    self.scrollview.backgroundColor = RGBACOLOR(230, 230, 230, 1);
    [self.view addSubview:self.scrollview];
    
    [self lodlist];
    
    
    
    
    
}

- (void)setupview:(CGFloat )height str1:(NSString *)str1 str2:(NSString *)str2 index:(NSString *)index{

    self.bgview = [[UIView alloc]initWithFrame:CGRectMake(0, height, SCREEN_WIDTH, 130)];
    self.bgview.backgroundColor = [UIColor whiteColor];
    [self.scrollview addSubview:self.bgview];
    
    self.celllab1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-20, 30)];
    self.celllab1.text = [NSString stringWithFormat:@"部件编号：%@",str1];
    [self.bgview addSubview:self.celllab1];
    
    self.celllab2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 50, SCREEN_WIDTH-20, 30)];
    self.celllab2.text = [NSString stringWithFormat:@"入库数量：%@",str2];
    [self.bgview addSubview:self.celllab2];
    
    self.celllab3 = [[UILabel alloc]initWithFrame:CGRectMake(10, 90, 130, 30)];
    self.celllab3.text = @"存放位置编号：";
    [self.bgview addSubview:self.celllab3];
    
    self.textfield = [[UITextField alloc]initWithFrame:CGRectMake(140, 90, SCREEN_WIDTH-150, 30)];
    self.textfield.delegate = self;
    self.textfield.text = index;
    self.textfield.borderStyle = UITextBorderStyleRoundedRect;
    [self.bgview addSubview:self.textfield];
    
    [self.arr addObject:self.textfield];
}


- (void)lodlist{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"bianhao.text"],
            @"departmentId":[Manager redingwenjianming:@"departmentId.text"],
            @"stockInOrderId":self.idstr,
            };
    [session POST:KURLNSString(@"servlet/stock/stockinorderitem/item/list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
//                NSLog(@"%@",dic);
        [weakSelf.dataArray removeAllObjects];
        [weakSelf.idarr removeAllObjects];
        [weakSelf.strarr removeAllObjects];
        NSMutableArray *arr = (NSMutableArray *)dic;
        for (NSDictionary *dict in arr) {
            PaiDanModel *model = [PaiDanModel mj_objectWithKeyValues:dict];
            
            [weakSelf.dataArray addObject:model];
        }
        
        
        for (int i = 0; i<weakSelf.dataArray.count; i++) {
            PaiDanModel *model = weakSelf.dataArray[i];
            [weakSelf setupview:140*i str1:model.partNo str2:model.quantity index:[NSString stringWithFormat:@"%@",model.location]];
            weakSelf.scrollview.contentSize = CGSizeMake(0, 140*i+150);
            weakSelf.index = i;
            [weakSelf.idarr addObject:model.id];
            if (model.location == nil) {
                [weakSelf.strarr addObject:@""];
            }else{
                [weakSelf.strarr addObject:model.location];
            }
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
    
    
}



- (IBAction)clickbtn:(id)sender {
    [self.strarr removeAllObjects];
    
    for (UITextField *textf in self.arr) {
        [self.strarr addObject:textf.text];
    }
    
    
    NSString *strLocation = @"";
    for (int i = 0; i<self.arr.count; i++) {
        strLocation = [strLocation stringByAppendingString:[NSString stringWithFormat:@";%@:%@",self.idarr[i],self.strarr[i]]];
    }
    
    
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"bianhao.text"],
            @"departmentPersonName":[Manager redingwenjianming:@"realName.text"],
            @"id":self.idstr,
            @"locations":[strLocation substringFromIndex:1],
            };
//    NSLog(@"%@",dic);
    [session POST:KURLNSString(@"servlet/stock/stockinorder/set_location") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
//        NSLog(@"%@",dic);
        if ([[dic objectForKey:@"code"] isEqualToString:@"success"]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"设置库位成功" message:@"温馨提示" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }];
            [alert addAction:cancel];
            [weakSelf presentViewController:alert animated:YES completion:nil];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
//

    
    
    
    
}










- (NSMutableArray *)strarr{
    if (_strarr == nil) {
        self.strarr = [NSMutableArray arrayWithCapacity:1];
    }
    return _strarr;
}
- (NSMutableArray *)idarr{
    if (_idarr == nil) {
        self.idarr = [NSMutableArray arrayWithCapacity:1];
    }
    return _idarr;
}
- (NSMutableArray *)arr{
    if (_arr == nil) {
        self.arr = [NSMutableArray arrayWithCapacity:1];
    }
    return _arr;
}
- (NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        self.dataArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray;
}
@end
