//
//  SYSB_edit_ViewController.m
//  AFEFactory
//
//  Created by ilovedxracer on 2018/1/16.
//  Copyright © 2018年 ilovedxracer. All rights reserved.
//

#import "SYSB_edit_ViewController.h"
#import "PaiDanModel.h"
@interface SYSB_edit_ViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UITextField *text1;
    UITextField *text3;
    UITextField *text4;
    UITextField *text5;
    UITextField *text6;
    UITextField *text7;
    UITextField *text8;
    UITextField *text9;
    UITextField *text2;
    UIImageView *img1;
    UIImageView *img2;
    
    UIView *bgwindowview;
    UILabel *toplab;
    
    NSString *imgstr;
    NSString *statu1;
    NSString *statu2;
    NSString *statu3;
    NSString *statu4;
    
    
    NSString *string1;
    NSString *string2;
}
@property(nonatomic,strong)UIScrollView *scrollview;


@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)NSMutableArray *dataArray;

@property(nonatomic,strong)NSMutableArray *arr1;
@property(nonatomic,strong)NSMutableArray *arr2;
@property(nonatomic,strong)NSMutableArray *arr3;
@property(nonatomic,strong)NSMutableArray *arr4;

@end

@implementation SYSB_edit_ViewController




- (void)clicksave{
    
    if (statu1.length != 0 && statu2.length != 0 && statu3.length != 0  && statu4.length != 0 &&
        text3.text.length != 0 && text4.text.length != 0 && text5.text.length != 0 &&
        text7.text.length != 0 && text8.text.length != 0 && text9.text.length != 0 &&
        text1.text.length != 0 && text2.text.length != 0 && text6.text.length != 0 &&
        string1 != nil && string2 != nil) {
        
        AFHTTPSessionManager *session = [Manager returnsession];
        __weak typeof(self) weakSelf = self;
        
        CGSize size = img1.image.size;
        size.height = size.height/6;
        size.width  = size.width/6;
        UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
        [img1.image drawInRect:CGRectMake(0, 0, size.width, size.height)];
        UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
        
        
        CGSize size1 = img2.image.size;
        size1.height = size1.height/6;
        size1.width  = size1.width/6;
        UIGraphicsBeginImageContextWithOptions(size1, NO, [UIScreen mainScreen].scale);
        [img2.image drawInRect:CGRectMake(0, 0, size1.width, size1.height)];
        UIImage *scaledImage1 = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        
        NSDictionary *dic = [[NSDictionary alloc]init];
        dic = @{@"businessId":[Manager redingwenjianming:@"bianhao.text"],
                @"userId":[Manager redingwenjianming:@"userid.text"],
                @"id":self.idstr,
                @"equipmentCategoryId":statu1,
                @"equipmentNo":text2.text,
                @"equipmentName":text3.text,
                @"equipmentColor":text4.text,
                
                @"equipmentManager":statu2,
                @"field2":text6.text,
                @"equipmentSupplierId":statu3,
                @"equipmentUseTime":text8.text,
                @"equipmentStatus":statu4,
                };
        [session POST:KURLNSString(@"servlet/equipment/equipment/update") parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            NSData * data   =  UIImagePNGRepresentation(scaledImage);
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
            [formData appendPartWithFileData:data name:@"filePath" fileName:fileName mimeType:@"image/png"];
            
            NSData * data1   =  UIImagePNGRepresentation(scaledImage1);
            NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
            formatter1.dateFormat = @"yyyyMMddHHmmss";
            NSString *str1 = [formatter1 stringFromDate:[NSDate date]];
            NSString *fileName1 = [NSString stringWithFormat:@"%@.png", str1];
            [formData appendPartWithFileData:data1 name:@"filePath1" fileName:fileName1 mimeType:@"image/png"];
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary *dic = [Manager returndictiondata:responseObject];
//            NSLog(@"%@",[dic objectForKey:@"message"]);
            if ([[dic objectForKey:@"code"]isEqualToString:@"success"]) {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"保存成功😊" preferredStyle:1];
                UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                    weakSelf.imgs2 = nil;
                    weakSelf.imgs1 = nil;
                    img1.image = nil;
                    img2.image = nil;
                    string1 = nil;
                    string2 = nil;
                    
                    
                    NSDictionary *dict = [[NSDictionary alloc]init];
                    NSNotification *notification =[NSNotification notificationWithName:@"save" object:nil userInfo:dict];
                    [[NSNotificationCenter defaultCenter] postNotification:notification];
                    
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                }];
                [alert addAction:cancel];
                [weakSelf presentViewController:alert animated:YES completion:nil];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        }];
    }else{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"所有信息不能为空" message:@"" preferredStyle:1];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    
    
}











- (void)viewDidLoad {
    [super viewDidLoad];
    [self lod];
    self.view.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem *bar = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(clicksave)];
    self.navigationItem.rightBarButtonItem = bar;
    self.scrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(5, 5, SCREEN_WIDTH-10, SCREEN_HEIGHT-10)];
    self.scrollview.backgroundColor = [UIColor colorWithWhite:.85 alpha:.5];
    self.scrollview.userInteractionEnabled = YES;
    [self.view addSubview:self.scrollview];
    
    NSArray *arr = @[@"设备类别",@"设备编号",@"设备名称",@"设备颜色",@"设备管理员",@"设备使用人",@"设备维修商",@"开始使用时间",@"设备状态"];
    self.arr4 = [@[@"正常",@"停用"]mutableCopy];
    for (int i = 0; i < arr.count; i++) {
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(5, 10+30*i+20*i, 120, 30)];
        lab.text = arr[i];
        [self.scrollview addSubview:lab];
    }
    for (int j = 0; j < arr.count; j++) {
        UITextField *text = [[UITextField alloc]initWithFrame:CGRectMake(135, 5+50*j, SCREEN_WIDTH-150, 40)];
        text.delegate = self;
        switch (j) {
            case 0:
                text1 = text;
                break;
            case 1:
                text2 = text;
                break;
            case 2:
                text3 = text;
                break;
            case 3:
                text4 = text;
                break;
                
            case 4:
                text5 = text;
                break;
            case 5:
                text6 = text;
                break;
            case 6:
                text7 = text;
                break;
            case 7:
                text8 = text;
                break;
            case 8:
                text9 = text;
                break;
            default:
                break;
        }
        text.borderStyle = UITextBorderStyleRoundedRect;
        [self.scrollview addSubview:text];
    }
    
    
    
    UILabel *lab1 = [[UILabel alloc]initWithFrame:CGRectMake(5, 460, 120, 30)];
    lab1.text = @"上传设备图片";
    [self.scrollview addSubview:lab1];
    img1 = [[UIImageView alloc]initWithFrame:CGRectMake(135, 460, 100, 100)];
    img1.contentMode = UIViewContentModeScaleAspectFit;
    img1.userInteractionEnabled = YES;
    img1.backgroundColor = [UIColor whiteColor];
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clicktap1:)];
    [img1 addGestureRecognizer:tap1];
    [self.scrollview addSubview:img1];
    
    UILabel *lab2 = [[UILabel alloc]initWithFrame:CGRectMake(5, 580, 130, 30)];
    lab2.text = @"上传设备标识图";
    [self.scrollview addSubview:lab2];
    img2 = [[UIImageView alloc]initWithFrame:CGRectMake(135, 580, 100, 100)];
    img2.contentMode = UIViewContentModeScaleAspectFit;
    img2.backgroundColor = [UIColor whiteColor];
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clicktap2:)];
    [img2 addGestureRecognizer:tap2];
    img2.userInteractionEnabled = YES;
    [self.scrollview addSubview:img2];
    
    self.scrollview.contentSize = CGSizeMake(0, SCREEN_HEIGHT*1.01);
    
//    NSLog(@"%@---------------%@",self.imgs1,self.imgs2);
    
        text1.text = self.str1;
        text2.text = self.str2;
        text3.text = self.str3;
        text4.text = self.str4;
        text5.text = self.str5;
        
        text6.text = self.str6;
        text7.text = self.str7;
        text8.text = self.str8;
        text9.text = self.str9;
        
        
        NSURLRequest *req = [NSURLRequest requestWithURL:[NSURL URLWithString:self.imgs1]];
        [NSURLConnection sendAsynchronousRequest:req queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            UIImage *img1a = [UIImage imageWithData:data];
            if (img1a == nil) {
                string1 = nil;
            } else {
                img1.image = img1a;
                string1 = @"1";
            }
        }];
        
        NSURLRequest *req1 = [NSURLRequest requestWithURL:[NSURL URLWithString:self.imgs2]];
        [NSURLConnection sendAsynchronousRequest:req1 queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            UIImage *img2a = [UIImage imageWithData:data];
            if (img2a == nil) {
               string2 = nil;
            } else {
                img2.image = img2a;
                string2 = @"2";
            }
        }];
        
        statu4 = self.str9id;
        statu3 = self.str7id;
        statu2 = self.str5id;
        statu1 = self.str1id;
    
    
    
    [self setupview];
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if ([textField isEqual:text1]) {
        [self hhh];
        toplab.text = @"设备类别";
        bgwindowview.hidden = NO;
        self.dataArray = self.arr1;
        [self.tableview reloadData];
        return NO;
    }
    if ([textField isEqual:text5]) {
        [self hhh];
        toplab.text = @"设备管理员";
        bgwindowview.hidden = NO;
        self.dataArray = self.arr3;
        [self.tableview reloadData];
        return NO;
    }
    if ([textField isEqual:text7]) {
        [self hhh];
        toplab.text = @"设备维修商";
        bgwindowview.hidden = NO;
        self.dataArray = self.arr2;
        [self.tableview reloadData];
        return NO;
    }
    if ([textField isEqual:text8]) {
        [self hhh];
        KSDatePicker *picker = [[KSDatePicker alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 40, 300)];
        picker.appearance.radius = 5;
        picker.appearance.resultCallBack = ^void(KSDatePicker* datePicker,NSDate* currentDate,KSDatePickerButtonType buttonType){
            if (buttonType == KSDatePickerButtonCommit) {
                NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"yyyy-MM-dd"];
                NSString *str = [formatter stringFromDate:currentDate];
                text9.text = str;
            }
        };
        [self.view bringSubviewToFront:picker];
        [picker show];
        return NO;
    }
    if ([textField isEqual:text9]) {
        [self hhh];
        toplab.text = @"设备状态";
        bgwindowview.hidden = NO;
        self.dataArray = self.arr4;
        [self.tableview reloadData];
        return NO;
    }
    
    return YES;
}



- (void)setupview{
    bgwindowview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    bgwindowview.backgroundColor = [UIColor colorWithWhite:.8 alpha:.5];
    bgwindowview.hidden = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clicktapbgwindowview:)];
    tap.delegate = self;
    [bgwindowview addGestureRecognizer:tap];
    [self.view addSubview:bgwindowview];
    [self.view bringSubviewToFront:bgwindowview];
    
    toplab = [[UILabel alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-400.5, SCREEN_WIDTH, 50)];
    toplab.backgroundColor = [UIColor whiteColor];
    toplab.textAlignment = NSTextAlignmentCenter;
    [bgwindowview addSubview:toplab];
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-350, SCREEN_WIDTH, 350)];
    [self.tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [bgwindowview addSubview:self.tableview];
    
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    self.tableview.tableFooterView = v;
}

- (void)clicktap1:(UITapGestureRecognizer *)tap{
    imgstr = @"/pics.png";
    [self selectedImage];
}
- (void)clicktap2:(UITapGestureRecognizer *)tap{
    imgstr = @"/imgs.png";
    [self selectedImage];
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
    
    
    if ([imgstr isEqualToString:@"/pics.png"]) {
        img1.image = imagesave;
        string1 = @"1";
    }else{
        img2.image = imagesave;
        string2 = @"2";
    }
    
//    NSData * imageData = UIImagePNGRepresentation(imagesave);
//    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString * documentsDirectory = [paths objectAtIndex:0];
//    NSString * fullPathToFile = [documentsDirectory stringByAppendingString:imgstr];
//    [imageData writeToFile:fullPathToFile atomically:NO];
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}







- (void)lod{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"bianhao.text"],
            @"type":@"all",
            };
    [session POST:KURLNSString(@"servlet/equipment/equipment") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
//        NSLog(@"%@",dic);
        [weakSelf.arr1 removeAllObjects];
        if (![[dic objectForKey:@"equipmentCategoryList"] isEqual:[NSNull null]]) {
            NSMutableArray *arr = [dic objectForKey:@"equipmentCategoryList"];
            for (NSDictionary *dic in arr) {
                PaiDanModel *model = [PaiDanModel mj_objectWithKeyValues:dic];
                [weakSelf.arr1 addObject:model];
            }
        }
        
        [weakSelf.arr2 removeAllObjects];
        if (![[dic objectForKey:@"equipmentSupplierList"] isEqual:[NSNull null]]) {
            NSMutableArray *arr = [dic objectForKey:@"equipmentSupplierList"];
            for (NSDictionary *dic in arr) {
                PaiDanModel *model = [PaiDanModel mj_objectWithKeyValues:dic];
                [weakSelf.arr2 addObject:model];
            }
        }
        
        [weakSelf.arr3 removeAllObjects];
        if (![[dic objectForKey:@"departmentPersonList"] isEqual:[NSNull null]]) {
            NSMutableArray *arr = [dic objectForKey:@"departmentPersonList"];
            for (NSDictionary *dic in arr) {
                PaiDanModel *model = [PaiDanModel mj_objectWithKeyValues:dic];
                [weakSelf.arr3 addObject:model];
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.dataArray isEqualToArray:self.arr1]) {
        PaiDanModel *model = [self.arr1 objectAtIndex:indexPath.row];
        text1.text = model.name;
        statu1 = model.id;
    }
    if ([self.dataArray isEqualToArray:self.arr2]) {
        PaiDanModel *model = [self.arr2 objectAtIndex:indexPath.row];
        text7.text = model.supplierName;
        statu3 = model.id;
    }
    if ([self.dataArray isEqualToArray:self.arr3]) {
        PaiDanModel *model = [self.arr3 objectAtIndex:indexPath.row];
        text5.text = model.realName;
        statu2 = model.id;
    }
    if ([self.dataArray isEqualToArray:self.arr4]) {
        text9.text = [self.arr4 objectAtIndex:indexPath.row];
        if ([text9.text isEqualToString:@"正常"]) {
            statu4 = @"A";
        }else if ([text9.text isEqualToString:@"停用"]) {
            statu4 = @"B";
        }
    }
    bgwindowview.hidden = YES;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.dataArray isEqualToArray:self.arr1]) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        PaiDanModel *model = [self.arr1 objectAtIndex:indexPath.row];
        cell.textLabel.text = model.name;
        return cell;
    }
    if ([self.dataArray isEqualToArray:self.arr2]) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        PaiDanModel *model = [self.arr2 objectAtIndex:indexPath.row];
        cell.textLabel.text = model.supplierName;
        return cell;
    }
    if ([self.dataArray isEqualToArray:self.arr3]) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        PaiDanModel *model = [self.arr3 objectAtIndex:indexPath.row];
        cell.textLabel.text = model.realName;
        return cell;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = [self.arr4 objectAtIndex:indexPath.row];
    return cell;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UIView"]) {
        return YES;
    }
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UILabel"]) {
        return YES;
    }
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UIImageView"]) {
        return YES;
    }
    return NO;
}
- (void)clicktapbgwindowview:(UITapGestureRecognizer *)tap{
    
    bgwindowview.hidden = YES;
}
- (void)hhh{
    [text2 resignFirstResponder];
    [text3 resignFirstResponder];
    [text4 resignFirstResponder];
    [text6 resignFirstResponder];
}
- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        self.dataArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray;
}
- (NSMutableArray *)arr1 {
    if (_arr1 == nil) {
        self.arr1 = [NSMutableArray arrayWithCapacity:1];
    }
    return _arr1;
}
- (NSMutableArray *)arr2 {
    if (_arr2 == nil) {
        self.arr2 = [NSMutableArray arrayWithCapacity:1];
    }
    return _arr2;
}
- (NSMutableArray *)arr3 {
    if (_arr3 == nil) {
        self.arr3 = [NSMutableArray arrayWithCapacity:1];
    }
    return _arr3;
}
- (NSMutableArray *)arr4 {
    if (_arr4 == nil) {
        self.arr4 = [NSMutableArray arrayWithCapacity:1];
    }
    return _arr4;
}



@end
