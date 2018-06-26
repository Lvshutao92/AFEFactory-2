//
//  WDWP_ViewController.h
//  AFEFactory
//
//  Created by ilovedxracer on 2017/12/12.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WDWP_ViewController : UIViewController<UIScrollViewDelegate>
{
    NSArray  *_JGVCAry;
    NSArray  *_JGTitleAry;
    UIView   *_JGLineView;
    UIScrollView *_MeScroolView;
}
- (instancetype)initWithAddVCARY:(NSArray*)VCS TitleS:(NSArray*)TitleS;


@end
