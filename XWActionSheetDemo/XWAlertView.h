//
//  XWAlertView.h
//  XWActionSheetDemo
//
//  Created by 谢威 on 16/9/6.
//  Copyright © 2016年 成都卓牛科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XWAlertView : UIView

-(instancetype)initWitTitle:(NSString *)title DesTitle:(NSString *)des btnArray:(NSArray *)btnArray;
- (void)showInView:(UIView *)view animted:(BOOL)animted;
@end
