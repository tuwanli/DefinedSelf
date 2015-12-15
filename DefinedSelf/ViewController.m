//
//  ViewController.m
//  DefinedSelf
//
//  Created by 涂婉丽 on 15/12/15.
//  Copyright © 2015年 涂婉丽. All rights reserved.
//

#import "ViewController.h"
#import "TWLAlertView.h"
@interface ViewController ()<TWlALertviewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}
- (IBAction)click {
    TWLAlertView *alertView = [[TWLAlertView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    [alertView AlertView:@"确定要创建吗？" minorTitle:@"创建之前要要好好阅读提示，不要做出错误的决定，下面的按钮提示创建或者取消由你自己决定的，github中还有更换头像，单选照片，多选照片的demo" tipString:@"温馨提示"];
    alertView.delegate = self;
    [self.view addSubview: alertView];
    
}

-(void)didClickButtonAtIndex:(NSUInteger)index{
    switch (index) {
        case 0:
            NSLog(@"Click ok");
            break;
        case 1:
            NSLog(@"Click cancle");
            
            break;
        default:
            break;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
