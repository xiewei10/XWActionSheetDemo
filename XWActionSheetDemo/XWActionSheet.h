//
//  XWActionSheet.h
//  XWActionSheetDemo
//
//  Created by 谢威 on 16/9/6.
//  Copyright © 2016年 成都卓牛科技. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XWActionSheet;
@protocol XWActionSheetDelegate <NSObject>

- (void)XWActionSheet:(XWActionSheet *)sheet clickBtnIndex:(NSInteger)buttonIndex;

@end



@interface XWActionSheet : UIView

-(instancetype)initWithTitle:(NSString *)title otherBtnTitles:(NSArray *)btnTitleArray;

/**
 *  在哪个view上显示
 *
 *  @param view
 *  @param animated 是否动画显示
 */
- (void)showInView:(UIView *)view animated:(BOOL)animated;



@property (nonatomic,weak)id<XWActionSheetDelegate>xw_delegate;

@end
