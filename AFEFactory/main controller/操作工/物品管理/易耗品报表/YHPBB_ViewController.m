//
//  YHPBB_ViewController.m
//  AFEFactory
//
//  Created by ilovedxracer on 2017/12/12.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "YHPBB_ViewController.h"
#import "PaiDanModel.h"

@interface YHPBB_ViewController ()
@property(nonatomic,strong)UIScrollView *scrollview;


@property(nonatomic,strong)NSMutableArray *arr1;
@property(nonatomic,strong)NSMutableArray *array1;
@property(nonatomic,strong)NSMutableArray *arr2;
@property(nonatomic,strong)NSMutableArray *array2;
@property(nonatomic,strong)NSMutableArray *arr3;
@property(nonatomic,strong)NSMutableArray *array3;

@end

@implementation YHPBB_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];self.view.backgroundColor = [UIColor whiteColor];
    
    
    self.scrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.scrollview.contentSize = CGSizeMake(0, 1400);
    [self.view addSubview:self.scrollview];
    
    
    
    [self lod];
}


- (void)setupview1{
    AAChartView *aaChartView = [[AAChartView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 400)];
    [self.scrollview addSubview:aaChartView];
    
    AAChartModel *aaChartModel= AAObject(AAChartModel)
    .chartTypeSet(AAChartTypeColumn)
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
    
    [aaChartView aa_drawChartWithChartModel:aaChartModel];
}

- (void)setupview2{
    AAChartView *aaChartView = [[AAChartView alloc]initWithFrame:CGRectMake(0, 500, SCREEN_WIDTH, 400)];
    [self.scrollview addSubview:aaChartView];
    
    AAChartModel *aaChartModel= AAObject(AAChartModel)
    .chartTypeSet(AAChartTypeColumn)
    .titleSet(@"")
    .subtitleSet(@"")
    .categoriesSet(self.arr2)
    .yAxisTitleSet(@"")
    .seriesSet(@[
                 AAObject(AASeriesElement)
                 .nameSet(@"采购金额（元）")
                 .dataSet(self.array2),
                 ]
               );
    
    [aaChartView aa_drawChartWithChartModel:aaChartModel];
}


- (void)setupview3{
    AAChartView *aaChartView = [[AAChartView alloc]initWithFrame:CGRectMake(0, 1000, SCREEN_WIDTH, 400)];
    [self.scrollview addSubview:aaChartView];
    
    AAChartModel *aaChartModel2= AAObject(AAChartModel)
    .chartTypeSet(AAChartTypeArea)
    .titleSet(@"")
    .subtitleSet(@"")
    .categoriesSet(self.arr3)
    .yAxisTitleSet(@"")
    .seriesSet(@[
                 AAObject(AASeriesElement)
                 .nameSet(@"当前使用数")
                 .dataSet(self.array3),
                 ]
               );
    [aaChartView aa_drawChartWithChartModel:aaChartModel2];
}









- (void)lod{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"bianhao.text"],
            };
    //NSLog(@"+++%@",dic);
    [session POST:KURLNSString(@"servlet/officegoods/chart/consumable") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
//        NSLog(@"+++%@",dic);
        
        NSMutableArray *arr1 = [dic objectForKey:@"purchaseChart"];
        for (NSDictionary *dic1 in arr1) {
            PaiDanModel *model = [PaiDanModel mj_objectWithKeyValues:dic1];
            [weakSelf.arr1 addObject:model.durableType];
            [weakSelf.array1 addObject:[dic1 objectForKey:@"num"]];
        }
       
        NSMutableArray *arr2 = [dic objectForKey:@"purchaseCostChart"];
        for (NSDictionary *dic2 in arr2) {
            PaiDanModel *model1 = [PaiDanModel mj_objectWithKeyValues:dic2];
            [weakSelf.arr2 addObject:model1.durableType];
            [weakSelf.array2 addObject:[dic2 objectForKey:@"subtotal"]];
        }
        
        NSMutableArray *arr3 = [dic objectForKey:@"userNumChart"];
        for (NSDictionary *dic3 in arr3) {
            PaiDanModel *model2 = [PaiDanModel mj_objectWithKeyValues:dic3];
            [weakSelf.arr3 addObject:model2.durableType];
            [weakSelf.array3 addObject:[dic3 objectForKey:@"num"]];
        }
       
        
        
        [weakSelf setupview1];
        [weakSelf setupview2];
        [weakSelf setupview3];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
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

@end
