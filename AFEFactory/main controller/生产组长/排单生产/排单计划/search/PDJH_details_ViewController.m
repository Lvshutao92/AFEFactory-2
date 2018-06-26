//
//  PDJH_details_ViewController.m
//  Factory
//
//  Created by ilovedxracer on 2017/11/22.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "PDJH_details_ViewController.h"

@interface PDJH_details_ViewController ()
{
    CGFloat height1;
    CGFloat height2;
}
@end

@implementation PDJH_details_ViewController
- (void)viewWillDisappear:(BOOL)animated {
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewWillAppear:(BOOL)animated {
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    self.navigationItem.title = @"排单计划";
    
}



-(instancetype)initWithAddVCARY:(NSArray *)VCS TitleS:(NSArray *)TitleS{
    if (self = [super init]) {
        
        CGFloat height;
        if ([[[Manager sharedManager] iphoneType] isEqualToString:@"iPhone X"]) {
            height = 88;
        }else{
            height = 64;
        }
        
        _JGVCAry = VCS;
        _JGTitleAry = TitleS;
        //        self.edgesForExtendedLayout = UIRectEdgeNone;
        
        //先初始化各个界面
        UIView *BJView  = [[UIView alloc] initWithFrame:CGRectMake(0, height, SCREEN_WIDTH, 40)];
        BJView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:BJView];
        
        for (int i = 0 ; i<_JGVCAry.count; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(i*(SCREEN_WIDTH/_JGVCAry.count), 0, SCREEN_WIDTH/_JGVCAry.count, BJView.frame.size.height-2);
            
            [btn setTitle:_JGTitleAry[i] forState:UIControlStateNormal];
            
            [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [btn setTitleColor:RGBACOLOR(32, 157, 149, 1.0) forState:UIControlStateSelected];
            
            if (i==0) {
                btn.selected = YES;
            }
            
            btn.tag = 1000+i;
            [btn addTarget:self action:@selector(SeleScrollBtn:) forControlEvents:UIControlEventTouchUpInside];
            [BJView addSubview:btn];
        }
        
        UILabel *labe = [[UILabel alloc]initWithFrame:CGRectMake(0, 39, SCREEN_WIDTH, 1)];
        labe.backgroundColor = [UIColor colorWithWhite:.75 alpha:.3];
        [BJView addSubview:labe];
        
        _JGLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 38, SCREEN_WIDTH/_JGVCAry.count, 2)];
        _JGLineView.backgroundColor = RGBACOLOR(32, 157, 149, 1.0);
        [BJView addSubview:_JGLineView];
        
        
        _MeScroolView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, BJView.frame.size.height+height, SCREEN_WIDTH, SCREEN_HEIGHT-BJView.frame.size.height)];
        _MeScroolView.backgroundColor = [UIColor whiteColor];
        _MeScroolView.showsHorizontalScrollIndicator = NO;
        _MeScroolView.pagingEnabled = YES;
        _MeScroolView.delegate = self;
        
        _MeScroolView.scrollEnabled = YES;
        
        [self.view addSubview:_MeScroolView];
        
        
        
        
        for (int i2 = 0; i2<_JGVCAry.count; i2++) {
            UIView *view = [[_JGVCAry objectAtIndex:i2] view];
            view.frame = CGRectMake(i2*SCREEN_WIDTH, 0, SCREEN_WIDTH, _MeScroolView.frame.size.height);
            [_MeScroolView addSubview:view];
            
            [self addChildViewController:[_JGVCAry objectAtIndex:i2]];
            
            [_MeScroolView bringSubviewToFront:view];
        }
        
        [_MeScroolView setContentSize:CGSizeMake(SCREEN_WIDTH*_JGVCAry.count, _MeScroolView.frame.size.height)];
        
    }
    
    
    
    
    return self;
}

/**
 *  滚动停止调用
 *
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    int index = scrollView.contentOffset.x/scrollView.frame.size.width;
    //        NSLog(@"当前第几页====%d",index);
    //    if (index == 1) {
    //        [Manager sharedManager].searchIndex = 1001;
    //    }else {
    //        [Manager sharedManager].searchIndex = 1000;
    //    }
    /**
     *  此方法用于改变x轴
     */
    [UIView animateWithDuration:0.3 animations:^{
        CGRect f = _JGLineView.frame;
        f.origin.x = index*(SCREEN_WIDTH/_JGVCAry.count);
        _JGLineView.frame = f;
        
        
    }];
    
    UIButton *btn = [self.view viewWithTag:1000+index];
    for (UIButton *b in btn.superview.subviews) {
        if ([b isKindOfClass:[UIButton class]]) {
            b.selected = (b==btn) ? YES : NO;
        }
    }
    
}

//点击每个按钮然后选中对应的scroolview页面及选中按钮
-(void)SeleScrollBtn:(UIButton*)btn{
    
    if (btn.tag == 1000) {
        //[Manager sharedManager].searchIndex = 1000;
    }
    if (btn.tag == 1001) {
        //[Manager sharedManager].searchIndex = 1001;
    }
    
    
    for (UIButton *button in btn.superview.subviews)
    {
        if ([button isKindOfClass:[UIButton class]]) {
            button.selected = (button != btn) ? NO : YES;
        }
    }
    [UIView animateWithDuration:0.3 animations:^{
        CGRect f = _JGLineView.frame;
        f.origin.x = (btn.tag-1000)*(SCREEN_WIDTH/_JGVCAry.count);
        _JGLineView.frame = f;
        _MeScroolView.contentOffset = CGPointMake((btn.tag-1000)*SCREEN_WIDTH, 0);
    }];
}

@end
