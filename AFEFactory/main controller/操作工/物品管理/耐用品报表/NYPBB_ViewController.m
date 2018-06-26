//
//  NYPBB_ViewController.m
//  AFEFactory
//
//  Created by ilovedxracer on 2017/12/12.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "NYPBB_ViewController.h"
#import "PaiDanModel.h"
@interface NYPBB_ViewController ()
@property(nonatomic,strong)NSMutableArray *arr1;
@property(nonatomic,strong)NSMutableArray *array1;

@property(nonatomic,strong)NSMutableArray *arr2;
@property(nonatomic,strong)NSMutableArray *array2;

@property(nonatomic,strong)NSMutableArray *arr3;
@property(nonatomic,strong)NSMutableArray *array3;

@property(nonatomic,strong)NSMutableArray *arr4;
@property(nonatomic,strong)NSMutableArray *array4;

@property(nonatomic,strong)NSMutableArray *arr5;
@property(nonatomic,strong)NSMutableArray *array5;


@property(nonatomic,strong)UIScrollView *scrollview;


@end

@implementation NYPBB_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.scrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.scrollview.contentSize = CGSizeMake(0,2500);
    [self.view addSubview:self.scrollview];
    [self lod];
    
}

- (void)lod{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"bianhao.text"],
            @"startTime":@"",
            @"endTime":@"",
            };
//     NSLog(@"+++%@",dic);
    [session POST:KURLNSString(@"servlet/officegoods/chart/durable") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
//        NSLog(@"+++%@",dic);
        
        NSMutableArray *arr1 = [dic objectForKey:@"purchaseChart"];
        for (NSDictionary *dic1 in arr1) {
            PaiDanModel *model = [PaiDanModel mj_objectWithKeyValues:dic1];
            [weakSelf.arr1 addObject:model.durableType];
            NSNumber *num = [NSNumber numberWithFloat:[model.num floatValue]];
            [weakSelf.array1 addObject:num];
        }
        
        NSMutableArray *arr2 = [dic objectForKey:@"purchaseCostChart"];
        for (NSDictionary *dic2 in arr2) {
             PaiDanModel *model = [PaiDanModel mj_objectWithKeyValues:dic2];
            [weakSelf.arr2 addObject:model.durableType];
            NSNumber *num = [NSNumber numberWithFloat:[model.subtotal floatValue]];
            [weakSelf.array2 addObject:num];
        }
        
        NSMutableArray *arr3 = [dic objectForKey:@"totalNumChart"];
        for (NSDictionary *dic3 in arr3) {
            PaiDanModel *model = [PaiDanModel mj_objectWithKeyValues:dic3];
            [weakSelf.arr3 addObject:model.durableType];
            NSNumber *num = [NSNumber numberWithFloat:[model.num floatValue]];
            [weakSelf.array3 addObject:num];
        }
        
        NSMutableArray *arr4 = [dic objectForKey:@"totalPriceChart"];
        for (NSDictionary *dic4 in arr4) {
            PaiDanModel *model = [PaiDanModel mj_objectWithKeyValues:dic4];
            [weakSelf.arr4 addObject:model.durableType];
            NSNumber *num = [NSNumber numberWithFloat:[model.totalPrice floatValue]];
            [weakSelf.array4 addObject:num];
        }
        
        NSMutableArray *arr5 = [dic objectForKey:@"userNumChart"];
        for (NSDictionary *dic5 in arr5) {
            PaiDanModel *model = [PaiDanModel mj_objectWithKeyValues:dic5];
            [weakSelf.arr5 addObject:model.durableType];
            NSNumber *num = [NSNumber numberWithFloat:[model.num floatValue]];
            [weakSelf.array5 addObject:num];
        }
        
        
        [weakSelf setupview1];
        [weakSelf setupview2];
        [weakSelf setupview3];
        [weakSelf setupview4];
        [weakSelf setupview5];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}










- (void)setupview1{
    AAChartView *aaChartView = [[AAChartView alloc]initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 400)];
    [self.scrollview addSubview:aaChartView];
    
    AAChartModel *aaChartModel2= AAObject(AAChartModel)
    .chartTypeSet(AAChartTypeArea)
    .titleSet(@"")
    .subtitleSet(@"")
    .categoriesSet(self.arr1)
    .yAxisTitleSet(@"")
    .seriesSet(@[
                 AAObject(AASeriesElement)
                 .nameSet(@"采购数量")
                 .dataSet(self.array1),
                 ]
               );
    [aaChartView aa_drawChartWithChartModel:aaChartModel2];
}

- (void)setupview2{
    AAChartView *aaChartView = [[AAChartView alloc]initWithFrame:CGRectMake(0, 510, SCREEN_WIDTH, 400)];
    [self.scrollview addSubview:aaChartView];
    
    AAChartModel *aaChartModel2= AAObject(AAChartModel)
    .chartTypeSet(AAChartTypeArea)
    .titleSet(@"")
    .subtitleSet(@"")
    .categoriesSet(self.arr2)
    .yAxisTitleSet(@"")
    .seriesSet(@[
                 AAObject(AASeriesElement)
                 .nameSet(@"采购金额(元)")
                 .dataSet(self.array2),
                 ]
               );
    [aaChartView aa_drawChartWithChartModel:aaChartModel2];
}

- (void)setupview3{
    AAChartView *aaChartView = [[AAChartView alloc]initWithFrame:CGRectMake(0, 1010, SCREEN_WIDTH, 400)];
    [self.scrollview addSubview:aaChartView];
    
    AAChartModel *aaChartModel2= AAObject(AAChartModel)
    .chartTypeSet(AAChartTypeArea)
    .titleSet(@"")
    .subtitleSet(@"")
    .categoriesSet(self.arr5)
    .yAxisTitleSet(@"")
    .seriesSet(@[
                 AAObject(AASeriesElement)
                 .nameSet(@"当前使用数")
                 .dataSet(self.array5),
                 ]
               );
    [aaChartView aa_drawChartWithChartModel:aaChartModel2];
}


- (void)setupview4{
    AAChartView *aaChartView = [[AAChartView alloc]initWithFrame:CGRectMake(0, 1510, SCREEN_WIDTH, 400)];
    [self.scrollview addSubview:aaChartView];
    
    AAChartModel *aaChartModel2= AAObject(AAChartModel)
    .chartTypeSet(AAChartTypeArea)
    .titleSet(@"")
    .subtitleSet(@"")
    .categoriesSet(self.arr4)
    .yAxisTitleSet(@"")
    .seriesSet(@[
                 AAObject(AASeriesElement)
                 .nameSet(@"当前物品总价值(元)")
                 .dataSet(self.array4),
                 ]
               );
    [aaChartView aa_drawChartWithChartModel:aaChartModel2];
}


- (void)setupview5{
    AAChartView *aaChartView = [[AAChartView alloc]initWithFrame:CGRectMake(0, 2010, SCREEN_WIDTH, 400)];
    [self.scrollview addSubview:aaChartView];
    
    AAChartModel *aaChartModel2= AAObject(AAChartModel)
    .chartTypeSet(AAChartTypeArea)
    .titleSet(@"")
    .subtitleSet(@"")
    .categoriesSet(self.arr3)
    .yAxisTitleSet(@"")
    .seriesSet(@[
                 AAObject(AASeriesElement)
                 .nameSet(@"当前物品总数量")
                 .dataSet(self.array3),
                 ]
               );
    [aaChartView aa_drawChartWithChartModel:aaChartModel2];
}





























- (NSMutableArray *)arr1{
    if (_arr1 == nil) {
        self.arr1 = [NSMutableArray arrayWithCapacity:1];
    }
    return _arr1;
}
- (NSMutableArray *)array1{
    if (_array1 == nil) {
        self.array1 = [NSMutableArray arrayWithCapacity:1];
    }
    return _array1;
}

- (NSMutableArray *)arr2{
    if (_arr2 == nil) {
        self.arr2 = [NSMutableArray arrayWithCapacity:1];
    }
    return _arr2;
}
- (NSMutableArray *)array2{
    if (_array2 == nil) {
        self.array2 = [NSMutableArray arrayWithCapacity:1];
    }
    return _array2;
}

- (NSMutableArray *)arr3{
    if (_arr3 == nil) {
        self.arr3 = [NSMutableArray arrayWithCapacity:1];
    }
    return _arr3;
}
- (NSMutableArray *)array3{
    if (_array3 == nil) {
        self.array3 = [NSMutableArray arrayWithCapacity:1];
    }
    return _array3;
}

- (NSMutableArray *)arr4{
    if (_arr4 == nil) {
        self.arr4 = [NSMutableArray arrayWithCapacity:1];
    }
    return _arr4;
}
- (NSMutableArray *)array4{
    if (_array4 == nil) {
        self.array4 = [NSMutableArray arrayWithCapacity:1];
    }
    return _array4;
}

- (NSMutableArray *)arr5{
    if (_arr5 == nil) {
        self.arr5 = [NSMutableArray arrayWithCapacity:1];
    }
    return _arr5;
}
- (NSMutableArray *)array5{
    if (_array5 == nil) {
        self.array5 = [NSMutableArray arrayWithCapacity:1];
    }
    return _array5;
}
@end
