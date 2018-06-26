//
//  QueRen__ViewController.m
//  AFEFactory
//
//  Created by ilovedxracer on 2018/1/23.
//  Copyright © 2018年 ilovedxracer. All rights reserved.
//

#import "QueRen__ViewController.h"
#import "PaiDanModel.h"
#import "FeiYong_Cell.h"
@interface QueRen__ViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate,UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

{
    UITextField *text1;
    UITextField *text2;
    UITextField *text3;
    UITextField *text4;
    
    UITextView *textview;
    
    UITextField *text5;
    UITextField *text6;
    UITextField *text7;
    
    NSString *idstring;
    UIImageView *img;
    
    
    
    UIView *bgview;
    UILabel *bglab;
    
    
    CGFloat height;
    NSInteger page;
    NSInteger totalnum;
}
@property(nonatomic,strong)UITableView *tableview1;
@property(nonatomic,strong)NSMutableArray *arr1;

@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)NSMutableArray *arr;
@end

@implementation QueRen__ViewController



- (void)clicksave{
    if (text6.text.length == 0) {
        text6.text = @"";
    }
    if (text7.text.length == 0) {
        text7.text = @"";
    }
   
    if (text4.text.length != 0 && textview.text.length != 0 && self.idstr.length != 0 && idstring.length != 0){
        AFHTTPSessionManager *session = [Manager returnsession];
        __weak typeof(self) weakSelf = self;
        CGSize size = img.image.size;
        size.height = size.height/6;
        size.width  = size.width/6;
        UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
        [img.image drawInRect:CGRectMake(0, 0, size.width, size.height)];
        UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        NSDictionary *dic = [[NSDictionary alloc]init];
        NSString *str;
        
        if ([self.navigationItem.title isEqualToString:@"确认维修"]){
            dic = @{@"businessId":[Manager redingwenjianming:@"bianhao.text"],
                    @"id":self.idstr,
                    @"equipmentId":self.equipmentId,
                    @"endTime":text4.text,
                    @"field1":textview.text,
                    @"status":idstring,
                    @"field5":text6.text,
                    @"field4":text7.text,
                    };
            str = KURLNSString(@"servlet/equipment/equipmentmaintenance/confirm");
        }else {
            dic = @{@"businessId":[Manager redingwenjianming:@"bianhao.text"],
                    @"id":self.idstr,
                    @"endTime":text4.text,
                    @"mainContent":textview.text,
                    @"status":idstring,
                    @"field3":text6.text,
                    @"field2":text7.text,
                    };
            str = KURLNSString(@"servlet/equipment/equipmentmaintain/confirm");
        }
        
        
        [session POST:str parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            if (![img.image isEqual:[NSNull null]] && img.image != nil) {
                NSData * data   =  UIImagePNGRepresentation(scaledImage);
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                formatter.dateFormat = @"yyyyMMddHHmmss";
                NSString *str = [formatter stringFromDate:[NSDate date]];
                NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
                [formData appendPartWithFileData:data name:@"filePath" fileName:fileName mimeType:@"image/png"];
            }
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary *dic = [Manager returndictiondata:responseObject];
            //NSLog(@"%@",[dic objectForKey:@"message"]);
            if ([[dic objectForKey:@"code"]isEqualToString:@"success"]) {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"保存成功😊" preferredStyle:1];
                UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                    weakSelf.imgs2 = nil;
//                    weakSelf.imgs1 = nil;
//                    img1.image = nil;
//                    img2.image = nil;
//                    string1 = nil;
//                    string2 = nil;
                    NSDictionary *dict = [[NSDictionary alloc]init];
                    NSNotification *notification =[NSNotification notificationWithName:@"weixiu" object:nil userInfo:dict];
                    [[NSNotificationCenter defaultCenter] postNotification:notification];
                    [weakSelf setUpReflash];
                }];
                [alert addAction:cancel];
                [weakSelf presentViewController:alert animated:YES completion:nil];
            }else{
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:[dic objectForKey:@"message"] message:@"温馨提示" preferredStyle:1];
                UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                [alert addAction:cancel];
                [weakSelf presentViewController:alert animated:YES completion:nil];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        }];
        
    }else{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请输入完整信息，再重新保存" message:@"温馨提示" preferredStyle:1];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (void)selectedImage{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"请选择图片获取路径" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *actionA = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self pickerPictureFromAlbum];
    }];
    UIAlertAction *actionB = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self pictureFromCamera];
    }];
    UIAlertAction *actionC = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [actionA setValue:RGBACOLOR(32.0, 157.0, 149.0, 1.0) forKey:@"titleTextColor"];
    [actionB setValue:RGBACOLOR(32.0, 157.0, 149.0, 1.0) forKey:@"titleTextColor"];
    [actionC setValue:RGBACOLOR(32.0, 157.0, 149.0, 1.0) forKey:@"titleTextColor"];
    [alert addAction:actionA];
    [alert addAction:actionB];
    [alert addAction:actionC];
    [self presentViewController:alert animated:YES completion:nil];
}





//从手机相册选取图片功能
- (void)pickerPictureFromAlbum {
    //1.创建图片选择器对象
    UIImagePickerController *imagepicker = [[UIImagePickerController alloc]init];
    imagepicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagepicker.allowsEditing = YES;
    imagepicker.delegate = self;
    [self presentViewController:imagepicker animated:YES completion:nil];
}
//拍照--照相机是否可用
- (void)pictureFromCamera {
    //照相机是否可用
    BOOL isCamera = [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
    if (!isCamera) {
        //提示框
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"摄像头不可用" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
        return;//如果不存在摄像头，直接返回即可，不需要做调用相机拍照的操作；
    }
    //创建图片选择器对象
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
    //设置图片选择器选择图片途径
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;//从照相机拍照选取
    //设置拍照时下方工具栏显示样式
    imagePicker.allowsEditing = YES;
    //设置代理对象
    imagePicker.delegate = self;
    //最后模态退出照相机即可
    [self presentViewController:imagePicker animated:YES completion:nil];
}
#pragma mark - UIImagePickerControllerDelegate
//当得到选中的图片或视频时触发的方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *imagesave = [info objectForKey:UIImagePickerControllerOriginalImage];
    UIImageOrientation imageOrientation = imagesave.imageOrientation;
    if(imageOrientation!=UIImageOrientationUp)
    {
        // 原始图片可以根据照相时的角度来显示，但UIImage无法判定，于是出现获取的图片会向左转９０度的现象。
        // 以下为调整图片角度的部分
        UIGraphicsBeginImageContext(imagesave.size);
        [imagesave drawInRect:CGRectMake(0, 0, imagesave.size.width, imagesave.size.height)];
        imagesave = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        // 调整图片角度完毕
    }
    img.image = imagesave;
    [self dismissViewControllerAnimated:YES completion:nil];
    
}






- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *bar = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(clicksave)];
    self.navigationItem.rightBarButtonItem = bar;
    
    if ([self.navigationItem.title isEqualToString:@"确认维修"]) {
        self.arr1 = [@[@"维修成功",@"维修失败"]mutableCopy];
    }else{
        self.arr1 = [@[@"保养成功",@"保养失败"]mutableCopy];
    }
    
    CGFloat he;
    if ([[[Manager sharedManager] iphoneType] isEqualToString:@"iPhone X"]) {
        he = 88;
    }else{
        he = 64;
    }
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.tableview registerNib:[UINib nibWithNibName:@"FeiYong_Cell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableview];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 605)];
    self.tableview.tableHeaderView = view;
    
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    self.tableview.tableFooterView = v;
    
    
    
    NSMutableArray *array1 = [NSMutableArray arrayWithCapacity:1];
    NSMutableArray *array2 = [NSMutableArray arrayWithCapacity:1];
    if ([self.navigationItem.title isEqualToString:@"确认维修"]) {
        array1 = [@[@"维修申请编号",@"设备编号",@"设备维修商",@"维修结束时间"]mutableCopy];
        array2 = [@[@"维修状态",@"发票代码",@"发票号码",@"原始单据"]mutableCopy];
    }else{
        array1 = [@[@"保养申请编号",@"设备编号",@"设备维修商",@"保养结束时间"]mutableCopy];
        array2 = [@[@"保养状态",@"发票代码",@"发票号码",@"原始单据"]mutableCopy];
    }
    
    for (int i = 0; i<array1.count; i++) {
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(10, 10+30*i+20*i, 135, 30)];
        lab.text = array1[i];
        lab.textAlignment = NSTextAlignmentLeft;
        lab.font = [UIFont systemFontOfSize:16];
        [view addSubview:lab];
    }
    for (int i = 0; i<4; i++) {
        UITextField *textfield = [[UITextField alloc]initWithFrame:CGRectMake(150,5+40*i+10*i, SCREEN_WIDTH-165, 40)];
        textfield.delegate = self;
        switch (i) {
            case 0:
                text1 = textfield;
                text1.text = self.str1;
                text1.backgroundColor = [UIColor colorWithWhite:.85 alpha:.3];
                break;
            case 1:
                text2 = textfield;
                text2.text = self.str2;
                text2.backgroundColor = [UIColor colorWithWhite:.85 alpha:.3];
                break;
            case 2:
                text3 = textfield;
                text3.text = self.str3;
                text3.backgroundColor = [UIColor colorWithWhite:.85 alpha:.3];
                break;
            case 3:
                text4 = textfield;
                text4.placeholder= @"请选择";
                break;
            default:
                break;
        }
        textfield.borderStyle = UITextBorderStyleRoundedRect;
        [view addSubview:textfield];
    }
    if ([self.navigationItem.title isEqualToString:@"确认维修"]){
        UILabel *labs = [[UILabel alloc]initWithFrame:CGRectMake(10, 220, 135, 30)];
        labs.text = @"维修情况描述";
        labs.textAlignment = NSTextAlignmentLeft;
        labs.font = [UIFont systemFontOfSize:16];
        [view addSubview:labs];
        
    }else{
        UILabel *labs = [[UILabel alloc]initWithFrame:CGRectMake(10, 220, 135, 30)];
        labs.text = @"保养情况描述";
        labs.textAlignment = NSTextAlignmentLeft;
        labs.font = [UIFont systemFontOfSize:16];
        [view addSubview:labs];
    }
    textview = [[UITextView alloc]initWithFrame:CGRectMake(150,215, SCREEN_WIDTH-165, 100)];
    textview.delegate = self;
    LRViewBorderRadius(textview, 5, 1, [UIColor colorWithWhite:.8 alpha:.4]);
    [view addSubview:textview];
    
    
    for (int i = 0; i<array2.count; i++) {
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(10, 325+30*i+20*i, 135, 30)];
        lab.text = array2[i];
        lab.textAlignment = NSTextAlignmentLeft;
        lab.font = [UIFont systemFontOfSize:16];
        [view addSubview:lab];
    }
    for (int i = 0; i<3; i++) {
        UITextField *textfield = [[UITextField alloc]initWithFrame:CGRectMake(150,320+40*i+10*i, SCREEN_WIDTH-165, 40)];
        textfield.delegate = self;
        switch (i) {
            case 0:
                text5 = textfield;
                text5.placeholder= @"请选择";
                break;
            case 1:
                text6 = textfield;
                break;
            case 2:
                text7 = textfield;
                break;
            default:
                break;
        }
        textfield.borderStyle = UITextBorderStyleRoundedRect;
        [view addSubview:textfield];
    }
    img = [[UIImageView alloc]initWithFrame:CGRectMake(150, 485, 100, 100)];
    img.backgroundColor = [UIColor colorWithWhite:.8 alpha:.4];
    img.contentMode = UIViewContentModeScaleAspectFit;
    
    img.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clicktap:)];
    [img addGestureRecognizer:tap1];
    
    [view addSubview:img];
    
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, 600, SCREEN_WIDTH, 5)];
    line.backgroundColor = [UIColor colorWithWhite:.85 alpha:.35];
    [view addSubview:line];
    
    [self setUpReflash];
    [self setupview_tableview];
}

- (void)clicktap:(UITapGestureRecognizer *)tap{
    [self selectedImage];
}



- (void)setupview_tableview{
    bgview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    bgview.backgroundColor = [UIColor colorWithWhite:.8 alpha:.5];
    bgview.hidden = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clicktapbgwindowview:)];
    tap.delegate = self;
    [bgview addGestureRecognizer:tap];
    [self.view addSubview:bgview];
    [self.view bringSubviewToFront:bgview];
    
    bglab = [[UILabel alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-400.5, SCREEN_WIDTH, 50)];
    bglab.backgroundColor = [UIColor whiteColor];
    if ([self.navigationItem.title isEqualToString:@"确认维修"]){
        bglab.text = @"维修状态";
    }else{
        bglab.text = @"保养状态";
    }
    
    bglab.textAlignment = NSTextAlignmentCenter;
    [bgview addSubview:bglab];
    
    self.tableview1 = [[UITableView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-350, SCREEN_WIDTH, 350)];
    [self.tableview1 registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cells"];
    self.tableview1.delegate = self;
    self.tableview1.dataSource = self;
    [bgview addSubview:self.tableview1];
    
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    self.tableview1.tableFooterView = v;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UIView"]) {
        return YES;
    }
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UILabel"]) {
        return YES;
    }
    return NO;
}
- (void)clicktapbgwindowview:(UITapGestureRecognizer *)tap{
    bgview.hidden = YES;
}




- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if ([textField isEqual:text1]) {
        [text6 resignFirstResponder];
        [text7 resignFirstResponder];
        [textview resignFirstResponder];
        return NO;
    }
    if ([textField isEqual:text2]) {
        [text6 resignFirstResponder];
        [text7 resignFirstResponder];
        [textview resignFirstResponder];
        return NO;
    }
    if ([textField isEqual:text3]) {
        [text6 resignFirstResponder];
        [text7 resignFirstResponder];
        [textview resignFirstResponder];
        return NO;
    }
    if ([textField isEqual:text4]) {
        [text6 resignFirstResponder];
        [text7 resignFirstResponder];
        [textview resignFirstResponder];
        KSDatePicker *picker = [[KSDatePicker alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 40, 300)];
        picker.appearance.radius = 5;
        picker.appearance.resultCallBack = ^void(KSDatePicker* datePicker,NSDate* currentDate,KSDatePickerButtonType buttonType){
            if (buttonType == KSDatePickerButtonCommit) {
                NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"yyyy-MM-dd"];
                NSString *str = [formatter stringFromDate:currentDate];
                text4.text = str;
            }
        };
        [self.view bringSubviewToFront:picker];
        [picker show];
        return NO;
    }
    if ([textField isEqual:text5]) {
        [text6 resignFirstResponder];
        [text7 resignFirstResponder];
        [textview resignFirstResponder];
        bgview.hidden = NO;
        return NO;
    }
    return YES;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:self.tableview1]) {
        text5.text = [self.arr1 objectAtIndex:indexPath.row];
        if ([text5.text isEqualToString:@"维修成功"] || [text5.text isEqualToString:@"保养成功"]) {
            idstring = @"D";
        }else if ([text5.text isEqualToString:@"维修失败"] || [text5.text isEqualToString:@"保养失败"]) {
            idstring = @"E";
        }
        bgview.hidden = YES;
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([tableView isEqual:self.tableview1]) {
        return self.arr1.count;
    }
    return self.arr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:self.tableview1]) {
        return 60;
    }
    return 75;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView isEqual:self.tableview1]) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cells" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text = [self.arr1 objectAtIndex:indexPath.row];
        return cell;
    }
    if ([self.navigationItem.title isEqualToString:@"确认维修"]){
        FeiYong_Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        PaiDanModel *model = [self.arr objectAtIndex:indexPath.row];
        cell.lab1.text = [NSString stringWithFormat:@"维修项目：%@",model.equipmentDetail_model.name];
        cell.lab2.text = [NSString stringWithFormat:@"维修成本：%@",model.cost];
        cell.btn.hidden = YES;
        return cell;
    }
    FeiYong_Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    PaiDanModel *model = [self.arr objectAtIndex:indexPath.row];
    cell.lab1.text = [NSString stringWithFormat:@"保养项目：%@",model.equipmentDetail_model.name];
    cell.lab2.text = [NSString stringWithFormat:@"保养成本：%@",model.cost];
    cell.btn.hidden = YES;
    return cell;
}

//刷新数据
-(void)setUpReflash
{
    __weak typeof (self) weakSelf = self;
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loddeList];
    }];
    [self.tableview.mj_header beginRefreshing];
    self.tableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        if (self.arr.count == totalnum) {
            [self.tableview.mj_footer setState:MJRefreshStateNoMoreData];
        }else {
            [weakSelf loddeSLList];
        }
    }];
}
- (void)loddeList{
    [self.tableview.mj_footer endRefreshing];
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    page = 1;
    NSString *str;
    if ([self.navigationItem.title isEqualToString:@"确认维修"]){
        str = KURLNSString(@"servlet/equipment/equipmentmaintenancedetail/list");
        dic = @{@"businessId":[Manager redingwenjianming:@"bianhao.text"],
                @"sorttype":@"asc",
                @"sort":@"undefined",
                @"page":[NSString stringWithFormat:@"%ld",page],
                @"maintenanceId":self.idstr,
                };
    }else{
        str = KURLNSString(@"servlet/equipment/equipmentmaintaindetail/list");
        dic = @{@"businessId":[Manager redingwenjianming:@"bianhao.text"],
                @"sorttype":@"asc",
                @"sort":@"undefined",
                @"page":[NSString stringWithFormat:@"%ld",page],
                @"maintainId":self.idstr,
                };
    }
    //    NSLog(@"%@----%@",str,dic);
    [session POST:str parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
                                NSLog(@"guowai----%@",dic);
        totalnum = [[dic objectForKey:@"total"] integerValue];
        [weakSelf.arr removeAllObjects];
        if (![[dic objectForKey:@"rows"]isEqual:[NSNull null]]) {
            NSMutableArray *arr = [dic objectForKey:@"rows"];
            for (NSDictionary *dict in arr) {
                PaiDanModel *model = [PaiDanModel mj_objectWithKeyValues:dict];
                
                PaidanModel1 *model1 = [PaidanModel1 mj_objectWithKeyValues:model.equipmentDetail];
                model.equipmentDetail_model = model1;
                
            
                [weakSelf.arr addObject:model];
            }
        }
        page = 2;
        [weakSelf.tableview reloadData];
        [weakSelf.tableview.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakSelf.tableview.mj_header endRefreshing];
    }];
}
- (void)loddeSLList{
    [self.tableview.mj_header endRefreshing];
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    NSString *str;
    if ([self.navigationItem.title isEqualToString:@"确认维修"]){
        str = KURLNSString(@"servlet/equipment/equipmentmaintenancedetail/list");
        dic = @{@"businessId":[Manager redingwenjianming:@"bianhao.text"],
                @"sorttype":@"asc",
                @"sort":@"undefined",
                @"page":[NSString stringWithFormat:@"%ld",page],
                @"maintenanceId":self.idstr,
                };
    }else{
        str = KURLNSString(@"servlet/equipment/equipmentmaintaindetail/list");
        dic = @{@"businessId":[Manager redingwenjianming:@"bianhao.text"],
                @"sorttype":@"asc",
                @"sort":@"undefined",
                @"page":[NSString stringWithFormat:@"%ld",page],
                @"maintainId":self.idstr,
                };
    }
    [session POST:str parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        if (![[dic objectForKey:@"rows"]isEqual:[NSNull null]]) {
            NSMutableArray *arr = [dic objectForKey:@"rows"];
            for (NSDictionary *dict in arr) {
                PaiDanModel *model = [PaiDanModel mj_objectWithKeyValues:dict];
                
                PaidanModel1 *model1 = [PaidanModel1 mj_objectWithKeyValues:model.equipmentDetail];
                model.equipmentDetail_model = model1;
                
                [weakSelf.arr addObject:model];
            }
        }
        page++;
        [weakSelf.tableview reloadData];
        [weakSelf.tableview.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakSelf.tableview.mj_footer endRefreshing];
    }];
}





- (NSMutableArray *)arr{
    if (_arr == nil) {
        self.arr = [NSMutableArray arrayWithCapacity:1];
    }
    return _arr;
}
- (NSMutableArray *)arr1{
    if (_arr1 == nil) {
        self.arr1 = [NSMutableArray arrayWithCapacity:1];
    }
    return _arr1;
}

@end
