//
//  ViewController.m
//  XWActionSheetDemo
//
//  Created by 谢威 on 16/9/6.
//  Copyright © 2016年 成都卓牛科技. All rights reserved.
//

#import "ViewController.h"
#import "XWActionSheet.h"
#import "XWAlertView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)clcik:(UIButton *)sender {
    
    XWActionSheet *sheet = [[XWActionSheet alloc] initWithTitle:@"这是标题" otherBtnTitles:@[@"UI",@"java",@"iOS",@"python"]];
    
    [sheet showInView:self.view animated:YES];

}

- (IBAction)alertView:(UIButton *)sender {
    XWAlertView *view = [[XWAlertView alloc] initWitTitle:@"z这是标题" DesTitle:@"这份的撒打算大神大神大神大神大神大叔大叔大飒飒飒大飒飒飒飒大叔大叔大飒飒飒大飒飒飒飒大叔大叔大飒飒飒大飒飒飒飒大叔大叔大飒飒飒大飒飒飒飒大叔大叔大飒飒飒大飒飒飒飒大叔大叔大飒飒飒飒大叔大叔大飒飒飒飒啊上abc" btnArray:@[@"1",@"2",@"3"]];
    

    [view showInView:self.view animted:YES];

}

@end
