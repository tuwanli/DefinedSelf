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
    [self loadAlertView:@"创建一个就诊号" contentStr:@"注：新建就诊号，以前的就诊信息无法查询，第一次在手机挂号到医院分诊台分诊时需要出示身份证，如果挂号填写的就诊人信息和身份证信息不符，医院有权利拒绝提供就诊服务，挂号费用不退" btnNum:2 btnStrArr:[NSArray arrayWithObjects:@"取消",@"确定", nil]type:10];
    
}

- (IBAction)clicktwo {
    [self loadAlertView:@"请输入密码" contentStr:nil btnNum:2 btnStrArr:[NSArray arrayWithObjects:@"取消",@"确定", nil] type:11];

}

- (IBAction)clickThree {
    [self loadAlertView:@"常用就诊人" contentStr:@"是否删除就诊人" btnNum:1 btnStrArr:[NSArray arrayWithObject:@"退出页面"] type:12];
}
- (void)loadAlertView:(NSString *)title contentStr:(NSString *)content btnNum:(NSInteger)num btnStrArr:(NSArray *)array type:(NSInteger)typeStr
{

    TWLAlertView *alertView = [[TWLAlertView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    [alertView initWithTitle:title contentStr:content type:typeStr btnNum:num btntitleArr:array];
    alertView.delegate = self;
    UIView * keywindow = [[UIApplication sharedApplication] keyWindow];
    [keywindow addSubview: alertView];
    
}
-(void)didClickButtonAtIndex:(NSUInteger)index password:(NSString *)password{
    switch (index) {
        case 101:
            NSLog(@"Click ok");
            break;
        case 100:
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
