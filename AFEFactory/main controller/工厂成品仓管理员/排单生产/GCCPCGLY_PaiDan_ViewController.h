//
//  GCCPCGLY_PaiDan_ViewController.h
//  AFEFactory
//
//  Created by ilovedxracer on 2018/1/3.
//  Copyright © 2018年 ilovedxracer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GCCPCGLY_PaiDan_ViewController : UIViewController<UIScrollViewDelegate>
{
    NSArray  *_JGVCAry;
    NSArray  *_JGTitleAry;
    UIView   *_JGLineView;
    UIScrollView *_MeScroolView;
}
- (instancetype)initWithAddVCARY:(NSArray*)VCS TitleS:(NSArray*)TitleS;

@end
