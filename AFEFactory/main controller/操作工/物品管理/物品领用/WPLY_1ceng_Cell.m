//
//  WPLY_1ceng_Cell.m
//  AFEFactory
//
//  Created by ilovedxracer on 2017/12/18.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "WPLY_1ceng_Cell.h"
@interface WPLY_1ceng_Cell()

{
    NSString *idstr;
}

//选中按钮
@property (nonatomic,retain) UIButton *selectBtn;
//显示照片
@property (nonatomic,retain) UIImageView *imageView_cell;

@property (nonatomic,retain) UILabel *lab1;
@property (nonatomic,retain) UILabel *lab2;
@property (nonatomic,retain) UILabel *lab3;
@property (nonatomic,retain) UILabel *lab4;
@property (nonatomic,retain) UILabel *lab5;
@property (nonatomic,retain) UILabel *lab6;
@property (nonatomic,retain) UILabel *lab7;
@property (nonatomic,retain) UILabel *lab8;
@end


@implementation WPLY_1ceng_Cell









- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = RGBCOLOR(245, 246, 248);
        
        
        [self setupMainView];
        
    }
    return self;
}
//选中按钮点击事件
-(void)selectBtnClick:(UIButton*)button
{
    button.selected = !button.selected;
    if (self.cartBlock) {
        self.cartBlock(button.selected);
    }
}

// 数量加按钮
-(void)addBtnClick
{
    if (self.numAddBlock) {
        self.numAddBlock();
    }
}

//数量减按钮
-(void)cutBtnClick
{
    if (self.numCutBlock) {
        self.numCutBlock();
    }
}

-(void)reloadDataWith:(PaiDanModel *)model
{
    if (model.goodsItemCode != nil) {
        self.lab1.text = [NSString stringWithFormat:@"编号：%@",model.goodsItemCode];
    }else{
        self.lab1.text = [NSString stringWithFormat:@"编号：%@",model.code];
    }
    
    
    
    self.lab2.text = [NSString stringWithFormat:@"名称：%@",model.name];
    
    self.lab3.text = [NSString stringWithFormat:@"品牌：%@",model.brand];
    
    
    if (model.model_s != nil){
        self.lab4.text = [NSString stringWithFormat:@"型号：%@",model.model_s];
    }else{
        self.lab4.text = [NSString stringWithFormat:@"型号：%@",@"-"];
    }
    
    
    self.lab5.text = [NSString stringWithFormat:@"类型：%@",model.durableType];
    self.lab6.text = [NSString stringWithFormat:@"规格：%@",model.standard];

    self.lab7.text = @"数量：";
    
    if (model.goodsItemId != nil) {
        self.numberLabel.text = [NSString stringWithFormat:@"%@",@"1"];
        model.num = [NSString stringWithFormat:@"%@",@"1"];
    }else{
        if ([model.stock integerValue] > 0){
            self.numberLabel.text = [NSString stringWithFormat:@"%@",model.stock];
            model.num = [NSString stringWithFormat:@"%@",model.stock];
        }
    }
    self.lab8.text = [NSString stringWithFormat:@"单位：%@",model.unit];
   
    
    
//    model.goodsId = @"10";
//    NSLog(@"-------%@",model.goodsId);
//    model.id = nil;
    
    self.selectBtn.selected = self.isSelected;
//    model.num = [model.model1.quantity integerValue];
    
}



-(void)setupMainView
{
    //白色背景
    UIView *bgView = [[UIView alloc]init];
    bgView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 135);
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.layer.borderColor = kUIColorFromRGB(0xEEEEEE).CGColor;
    bgView.layer.borderWidth = 1;
    [self addSubview:bgView];
    
    //选中按钮
    self.selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.selectBtn.frame = CGRectMake(5, 107/2, 28, 28);
    self.selectBtn.selected = self.isSelected;
    [self.selectBtn setImage:[UIImage imageNamed:@"cart_unSelect_btn"] forState:UIControlStateNormal];
    
    
    UIImage *theImage = [UIImage imageNamed:@"cart_selected_btn"];
    theImage = [theImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [self.selectBtn setImage:theImage forState:UIControlStateSelected];
    [self.selectBtn setTintColor:[UIColor redColor]];


    [self.selectBtn addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:self.selectBtn];
//
//    //照片背景
//    UIView *imageBgView = [[UIView alloc]init];
//    imageBgView.frame = CGRectMake(40, 10, 100, 100);
//    imageBgView.backgroundColor = [UIColor whiteColor];
//    [bgView addSubview:imageBgView];
//
//    //显示照片
//    self.imageView_cell = [[UIImageView alloc]init];
//    self.imageView_cell.frame = CGRectMake(40, 10, 100, 100);
//    self.imageView_cell.contentMode = UIViewContentModeScaleAspectFit;
//    self.imageView_cell.layer.borderColor = [UIColor colorWithWhite:.85 alpha:.5].CGColor;
//    self.imageView_cell.layer.borderWidth = 1.0;
//    [bgView addSubview:self.imageView_cell];
    
    
    
    
    //商品名
    self.lab1 = [[UILabel alloc]init];
    self.lab1.frame = CGRectMake(40, 5, (SCREEN_WIDTH-55)/2, 20);
    self.lab1.font = [UIFont systemFontOfSize:16];
    [bgView addSubview:self.lab1];
    
    self.lab2 = [[UILabel alloc]init];
    self.lab2.frame = CGRectMake(40+(SCREEN_WIDTH-55)/2, 5, (SCREEN_WIDTH-55)/2, 20);
    self.lab2.font = [UIFont systemFontOfSize:16];
    [bgView addSubview:self.lab2];
    
    
    
    self.lab3 = [[UILabel alloc]init];
    self.lab3.frame = CGRectMake(40, 40, (SCREEN_WIDTH-55)/2, 20);
    self.lab3.font = [UIFont systemFontOfSize:16];
    [bgView addSubview:self.lab3];
    
    self.lab4 = [[UILabel alloc]init];
    self.lab4.frame = CGRectMake(40+(SCREEN_WIDTH-55)/2, 40, (SCREEN_WIDTH-55)/2, 20);
    self.lab4.font = [UIFont systemFontOfSize:16];
    [bgView addSubview:self.lab4];
    
    
    
    
    
    self.lab5 = [[UILabel alloc]init];
    self.lab5.frame = CGRectMake(40, 75, (SCREEN_WIDTH-55)/2, 20);
    self.lab5.font = [UIFont systemFontOfSize:16];
    [bgView addSubview:self.lab5];

    self.lab6 = [[UILabel alloc]init];
    self.lab6.frame = CGRectMake(40+(SCREEN_WIDTH-55)/2, 75, (SCREEN_WIDTH-55)/2, 20);
    self.lab6.font = [UIFont systemFontOfSize:16];
    [bgView addSubview:self.lab6];

    
    
    
    self.lab7 = [[UILabel alloc]init];
    self.lab7.frame = CGRectMake(40, 110, 50, 20);
    self.lab7.font = [UIFont systemFontOfSize:16];
    [bgView addSubview:self.lab7];

    self.lab8 = [[UILabel alloc]init];
    self.lab8.frame = CGRectMake(40+(SCREEN_WIDTH-55)/2, 110, (SCREEN_WIDTH-55)/2, 20);
    self.lab8.font = [UIFont systemFontOfSize:16];
    [bgView addSubview:self.lab8];
    
    
   
    
//    //数量加按钮
//    self.addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    self.addBtn.frame = CGRectMake(SCREEN_WIDTH-36, 87, 26, 26);
//    [self.addBtn setImage:[UIImage imageNamed:@"cart_addBtn_nomal"] forState:UIControlStateNormal];
//    [self.addBtn setImage:[UIImage imageNamed:@"cart_addBtn_highlight"] forState:UIControlStateHighlighted];
//    [self.addBtn addTarget:self action:@selector(addBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    [bgView addSubview:self.addBtn];
//
//    //数量减按钮
//    self.cutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    self.cutBtn.frame = CGRectMake(SCREEN_WIDTH-112, 87, 26, 26);
//    [self.cutBtn setImage:[UIImage imageNamed:@"cart_cutBtn_nomal"] forState:UIControlStateNormal];
//    [self.cutBtn setImage:[UIImage imageNamed:@"cart_cutBtn_highlight"] forState:UIControlStateHighlighted];
//    [self.cutBtn addTarget:self action:@selector(cutBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    [bgView addSubview:self.cutBtn];
//
//
    //数量显示
    self.numberLabel = [[UILabel alloc]init];
    self.numberLabel.frame = CGRectMake(90, 110, 50, 20);
    self.numberLabel.textAlignment = NSTextAlignmentCenter;
    self.numberLabel.font = [UIFont systemFontOfSize:15];
    
    LRViewBorderRadius(self.numberLabel, 0, .5, [UIColor grayColor]);
    
    [bgView addSubview:self.numberLabel];
    
//    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-86, 87, 50, 1)];
//    line.backgroundColor = [UIColor colorWithWhite:.55 alpha:.5];
//    [bgView addSubview:line];
//
//    UILabel *line1 = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-86, 112, 50, 1)];
//    line1.backgroundColor = [UIColor colorWithWhite:.55 alpha:.5];
//    [bgView addSubview:line1];
    
}







@end
