//
//  XWAlertView.m
//  XWActionSheetDemo
//
//  Created by 谢威 on 16/9/6.
//  Copyright © 2016年 成都卓牛科技. All rights reserved.
//

#import "XWAlertView.h"
#define KTitleH 30
#define KBtnH 44
#define KLineH 1
#define KMagin 20

@interface XWAlertView ()

@property (nonatomic,strong)UILabel   *titleLable;
@property (nonatomic,strong)UILabel   *DesLable;
@property (nonatomic,copy)NSString    *title;
@property (nonatomic,copy)NSString    *DesTitle;
@property (nonatomic,copy)NSArray      *btnArray;

@property (nonatomic,strong)UIView  *contaierView;
@end
@implementation XWAlertView
-(instancetype)initWitTitle:(NSString *)title DesTitle:(NSString *)des btnArray:(NSArray *)btnArray{
    if (self = [super init]) {
        self.title = title;
        self.DesTitle = des;
        self.btnArray = btnArray;
        self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.1];
        self.frame = [UIScreen mainScreen].bounds;
        [self config];
    }
    return self;
}
- (void)config{
    CGFloat KscrenW = self.frame.size.width;
    CGFloat KscrenH = self.frame.size.height;
      // 容器
     // 计算描述文字的高度
    CGFloat desMagin = ((KscrenW-KMagin *2)-KMagin*2);
    CGFloat h = [self.DesTitle boundingRectWithSize:CGSizeMake(desMagin, MAXFLOAT) options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil].size.height;
    
    CGFloat contaierH = KTitleH+h+KLineH+KBtnH;
    
    self.contaierView = ({
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(KMagin ,(KscrenH-contaierH)/2,(KscrenW-KMagin*2),contaierH)];
        view.backgroundColor = [UIColor whiteColor];
        [self addSubview:view];
        view;
    });
    
    // 标题
    UILabel *titleLable = ({
        UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0,0,CGRectGetWidth(self.contaierView.frame),KTitleH)];
        lable.text = self.title;
        lable.font = [UIFont systemFontOfSize:15];
        lable.textColor = [UIColor blackColor];
        lable.textAlignment = NSTextAlignmentCenter;
        lable;
    });
    [self.contaierView addSubview:titleLable];
   
    UILabel *DesLable = ({
        UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(KMagin,KTitleH,desMagin,h)];
        lable.text = self.DesTitle;
        lable.font = [UIFont systemFontOfSize:12];
        lable.textColor = [UIColor greenColor];
        lable.textAlignment = NSTextAlignmentLeft;
        lable.numberOfLines = 0;
        lable;
    });
    [self.contaierView addSubview:DesLable];
   
    
    // 线
    UIView *line = ({
        UIView *view =[[UIView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(DesLable.frame),CGRectGetWidth(self.contaierView.frame),KLineH)];
        view.backgroundColor = [UIColor greenColor];
        view;
    });
    [self.contaierView addSubview:line];
    
     // 按钮
    for (int i = 0; i < self.btnArray.count; i ++) {
        // 按钮
        CGFloat btnY = CGRectGetMaxY(line.frame);
        CGFloat btnW = CGRectGetWidth(self.contaierView.frame)/self.btnArray.count;
        CGFloat btnH = KBtnH;
        CGFloat btnX = btnW*i;
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:self.btnArray[i] forState:UIControlStateNormal];
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        [btn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btn:) forControlEvents:UIControlEventTouchUpInside];
        [self.contaierView addSubview:btn];
        if (i != self.btnArray.count-1) {
            UIView *line = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(btn.frame),btnY,1,btnH)];
            line.backgroundColor = [UIColor greenColor];
            [self.contaierView addSubview:line];
            
        }
        
        
    }
    

    
}
- (void)btn:(UIButton *)sender{
    [self dismiss];
}

- (void)showInView:(UIView *)view animted:(BOOL)animted{
    [view addSubview:self];
    // 这里进行动画
    // 先旋转
    CGAffineTransform t1 =  CGAffineTransformMakeRotation(-30*(M_PI/180));
    CGAffineTransform t2 =  CGAffineTransformMakeTranslation(0,-[UIScreen mainScreen].bounds.size.height/2 * 0.6);
    self.contaierView.alpha = 0.3;
    self.contaierView.transform = CGAffineTransformConcat(t1, t2);
    
    
    [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.contaierView.transform = CGAffineTransformIdentity;
        self.contaierView.alpha = 1;
        self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.5];

    } completion:^(BOOL finished) {
        
    }];
    
    
}
- (void)dismiss{
    CGAffineTransform t1 =  CGAffineTransformMakeRotation(30*(M_PI/180));
    CGAffineTransform t2 =  CGAffineTransformMakeTranslation(0,[UIScreen mainScreen].bounds.size.height*0.8);

    [UIView animateWithDuration:0.8 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.contaierView.transform = CGAffineTransformConcat(t1, t2);
        self.contaierView.alpha = 0.1;
        self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.1];

    } completion:^(BOOL finished) {
        [self.contaierView removeFromSuperview];
        [self removeFromSuperview];
        
    }];

    
    
    
}






@end
