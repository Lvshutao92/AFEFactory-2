//
//  JRSZ_search_ViewController.m
//  AFEFactory
//
//  Created by ilovedxracer on 2017/12/5.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "JRSZ_search_ViewController.h"
#import "JRSZ_search_list_ViewController.h"
@interface JRSZ_search_ViewController ()<UITextFieldDelegate>

@end

@implementation JRSZ_search_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"检索";
    LRViewBorderRadius(self.btn, 5, 0, [UIColor whiteColor]);
    self.lab1.delegate = self;
    self.lab2.delegate = self;
    // Do any additional setup after loading the view from its nib.
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.lab2 resignFirstResponder];
}




- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if ([textField isEqual:self.lab1]) {
        [self.lab2 resignFirstResponder];
        KSDatePicker* picker = [[KSDatePicker alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 40, 300)];
        picker.appearance.radius = 5;
        picker.appearance.resultCallBack = ^void(KSDatePicker* datePicker,NSDate* currentDate,KSDatePickerButtonType buttonType){
            if (buttonType == KSDatePickerButtonCommit) {
                NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"yyyy-MM-dd"];
                NSString *str = [formatter stringFromDate:currentDate];
                self.lab1.text = str;
            }
        };
        [picker show];
        return NO;
    }
    return YES;
}


- (IBAction)clickbtn:(id)sender {
    if (self.lab1.text.length == 0) {
        self.lab1.text = @"";
    }
    if (self.lab2.text.length == 0) {
        self.lab2.text = @"";
    }
    
    JRSZ_search_list_ViewController *list = [[JRSZ_search_list_ViewController alloc]init];
    list.str1 = self.lab1.text;
    list.str2 = self.lab2.text;
    list.navigationItem.title = @"检索信息";
    [self.navigationController pushViewController:list animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
