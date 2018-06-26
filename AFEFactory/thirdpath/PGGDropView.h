//
//  PGGDropView.h
//  PGGdrop-down menu PGGDropdownMenu


#import <UIKit/UIKit.h>
@class PGGDropView;

 

@protocol PGGDropDelegate <NSObject>
@optional

/**
 *点击选中协议方法
 @param DropView <#DropView description#>
 @param index <#index description#>
 */
- (void)PGGDropView:(PGGDropView *)DropView didSelectAtIndex:(NSInteger )index;
@end


@interface PGGDropView : UIView

/**
 *代理 需要点击响应则设置代理
 */
@property (nonatomic, weak) id<PGGDropDelegate> delegate;

/**
 *  设置背景图片
 */
@property(nonatomic,strong)UIImage *image;

/**
 *  构建方法
 *  param array   标题
 */
- (instancetype)initWithFrame:(CGRect)frame withTitleArray:(NSArray<NSString *> *)array;

/**
 *  移除
 */
- (void)dismiss;

/**
 *  添加之后做动画
 */
- (void)beginAnimation;
@end
