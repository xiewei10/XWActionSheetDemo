//
//  XWActionSheet.m
//  XWActionSheetDemo
//
//  Created by 谢威 on 16/9/6.
//  Copyright © 2016年 成都卓牛科技. All rights reserved.
//

#import "XWActionSheet.h"
#define KCellHeight 44
#define KlineHeight 1


@interface XWActionSheet ()
/** 上方标题 */
@property (nonatomic, copy) NSString * title;
/** 中间连续的几个按钮文字 */
@property (nonatomic, copy) NSArray * otherButtonTitles;
/**
 *  下面所有空间的容器view
 */
@property (nonatomic,strong)UIView      *containerView;

@property (nonatomic,strong)NSMutableArray  *btnArray;


@end
@implementation XWActionSheet
-(instancetype)initWithTitle:(NSString *)title otherBtnTitles:(NSArray *)btnTitleArray{
    if (self = [super init]) {
        self.title = title;
        self.otherButtonTitles = btnTitleArray;
        self.btnArray= [NSMutableArray array];
        self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.1];
        self.frame = [UIScreen mainScreen].bounds;
        [self config];
    }
    return self;
}
- (void)config{
    NSInteger conut = self.otherButtonTitles.count;
    CGFloat contaierViewH = (KCellHeight * 2 +4)+(KCellHeight + KlineHeight)*conut;
    UITapGestureRecognizer *pan = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeSheet)];
    [self addGestureRecognizer:pan];
    
    
    // 容器
    self.containerView = [[UIView alloc]initWithFrame:CGRectMake(0,self.frame.size.height-contaierViewH,self.frame.size.width, contaierViewH)];
    self.containerView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.containerView];
    self.containerView.transform = CGAffineTransformMakeTranslation(0,contaierViewH);
    
    // 标题

    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,self.frame.size.width,KCellHeight)];
    titleLabel.tag = 1000;
    titleLabel.text = self.title;
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.textColor = [UIColor grayColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.containerView addSubview:titleLabel];
    
    [self.btnArray addObject:titleLabel];
    
    // 按钮
    CGFloat BtnMaxY = 0.f;
    for (int i = 0; i <conut; i ++) {
        CGFloat LineX = 0;
        CGFloat LineW = self.frame.size.width;
        CGFloat LineH = KlineHeight;
        CGFloat LineY = i *(KCellHeight+KlineHeight)+CGRectGetMaxY(titleLabel.frame);
    
        //线
        UIView *line =[[UIView alloc]initWithFrame:CGRectMake(LineX,LineY,LineW,LineH)];
        line.backgroundColor =[UIColor grayColor];
        [self.containerView addSubview:line];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [btn setTitle:self.otherButtonTitles[i] forState:UIControlStateNormal];
         btn.tag = i;
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
         btn.frame = CGRectMake(0,CGRectGetMaxY(line.frame), LineW,KCellHeight);
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];      [self.containerView addSubview:btn];
         BtnMaxY = CGRectGetMaxY(btn.frame);
        [self.btnArray addObject:btn];
        
    }
    
    // 粗线
    UIView *BigLine = [[UIView alloc] initWithFrame:CGRectMake(0,BtnMaxY,self.frame.size.width,KlineHeight*3)];
    BigLine.backgroundColor =[UIColor lightGrayColor];
    [self.containerView addSubview:BigLine];
    
    // 取消按钮
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    cancelBtn.frame = CGRectMake(0,CGRectGetMaxY(BigLine.frame),self.frame.size.width,KCellHeight);
    [cancelBtn addTarget:self action:@selector(cancle) forControlEvents:UIControlEventTouchUpInside];
     [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.containerView addSubview:cancelBtn];
    [self.btnArray addObject:cancelBtn];
    
}
#pragma mark -- 取消
- (void)cancle{
    [self closeSheet];

}
#pragma mark -- 按钮点击
- (void)btnClick:(UIButton *)sender{
    if (self.xw_delegate && [self.xw_delegate respondsToSelector:@selector(XWActionSheet:clickBtnIndex:)]) {
        [self.xw_delegate XWActionSheet:self clickBtnIndex:sender.tag];
    }
    [self closeSheet];

    
}
- (void)showInView:(UIView *)view animated:(BOOL)animated{
    [view addSubview:self];
    if (animated == NO) {
        [UIView animateWithDuration:0.4 animations:^{
        self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.4];
        self.containerView.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
    
            
        }];

    }else{
        
        [self animationSheet];
    }
    
    
}
#pragma mark  动画显示弹窗
- (void)animationSheet{
    
    self.containerView.transform = CGAffineTransformIdentity;
 
    [self.btnArray enumerateObjectsUsingBlock:^(UIButton * sender, NSUInteger idx, BOOL * _Nonnull stop) {
      
        if ( idx %2==0 && idx != 0) {
            sender.transform = CGAffineTransformMakeTranslation(-self.frame.size.width,0);
        }
        else if (idx %2 == 1 && idx != self.btnArray.count){
            sender.transform = CGAffineTransformMakeTranslation(self.frame.size.width,0);
        }else if(idx == 0){
            sender.transform = CGAffineTransformMakeTranslation(self.frame.size.width,0);

        }
        else if(idx == self.btnArray.count){
            sender.transform = CGAffineTransformMakeTranslation(-self.frame.size.width,0);
            
        }

    }];

    [self.btnArray enumerateObjectsUsingBlock:^(UIButton * obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        [UIView animateWithDuration:self.btnArray.count*0.2 delay:idx *0.2 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            obj.transform = CGAffineTransformIdentity;
            
        } completion:^(BOOL finished) {
            
            
        }];

    }];
    
}






#pragma mark -- 关闭弹窗
- (void)closeSheet{
    NSInteger conut = self.otherButtonTitles.count;
    CGFloat contaierViewH = (KCellHeight * 2 +4)+(KCellHeight + KlineHeight)*conut;

    [UIView animateWithDuration:0.4 animations:^{
        self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.1];
        self.containerView.transform = CGAffineTransformMakeTranslation(0,contaierViewH);
    } completion:^(BOOL finished) {
        [self.containerView removeFromSuperview];
        self.containerView = nil;
        [self removeFromSuperview];
        
    }];

}



@end
