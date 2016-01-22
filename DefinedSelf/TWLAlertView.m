//
//  TWLAlertView.m
//  DefinedSelf
//
//  Created by 涂婉丽 on 15/12/15.
//  Copyright © 2015年 涂婉丽. All rights reserved.
//

#import "TWLAlertView.h"
#define k_w [UIScreen mainScreen].bounds.size.width
#define k_h [UIScreen mainScreen].bounds.size.height
@implementation TWLAlertView

- (id)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self) {
        //创建遮罩
        _blackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, k_w, k_h)];
        _blackView.backgroundColor = [UIColor blackColor];
        _blackView.alpha = 0.5;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(blackClick)];
        [self.blackView addGestureRecognizer:tap];
        [self addSubview:_blackView];
        //创建alert
        self.alertview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 270, 250)];
        self.alertview.center = self.center;
        //        UIView * keywindow = [[UIApplication sharedApplication] keyWindow];
        //        self.alertview.center = CGPointMake(CGRectGetMidX(keywindow.frame), -CGRectGetMidY(keywindow.frame));
        
        
        self.alertview.layer.cornerRadius = 17;
        self.alertview.clipsToBounds = YES;
        self.alertview.backgroundColor = [UIColor whiteColor];
        [self addSubview:_alertview];
        [self exChangeOut:self.alertview dur:0.6];
        
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    UILabel *tipLable = [[UILabel alloc]initWithFrame:CGRectMake(0,0,270,50)];
    tipLable.textAlignment = NSTextAlignmentCenter;
    tipLable.font = [UIFont boldSystemFontOfSize:16];
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(tipLable.frame), self.alertview.frame.size.width, 0.5)];
    lineView.backgroundColor = [UIColor blackColor];
    [self.alertview addSubview:lineView];
    [self.alertview addSubview:tipLable];
    switch (_type) {
        case 10:
            tipLable.text = @"温馨提示";
            [self creatViewInAlert:lineView.frame];
            break;
        case 11:
            self.alertview.frame = CGRectMake(0, 0, 270, 170);
            tipLable.text = @"请输入登录密码";
            [self creatViewWithAlert:lineView.frame];
        default:
            break;
    }
    self.alertview.center = CGPointMake(self.center.x, self.center.y);
}

- (void)creatViewInAlert:(CGRect)lineF
{
    
    UILabel *isCreate = [[UILabel alloc]initWithFrame:CGRectMake(20, lineF.origin.y+8, self.alertview.frame.size.width-40, 30)];
    isCreate.text = @"是否创建一个就诊号？";
    isCreate.font = [UIFont boldSystemFontOfSize:16];
    UILabel *attenL = [[UILabel alloc]initWithFrame:CGRectMake(isCreate.frame.origin.x, isCreate.frame.origin.y+20, self.alertview.frame.size.width-40, 130)];
    attenL.font = [UIFont systemFontOfSize:15];
    attenL.text = @"注：新建就诊号，以前的就诊信息无法查询，第一次在手机挂号到医院分诊台分诊时需要出示身份证，如果挂号填写的就诊人信息和身份证信息不符，医院有权利拒绝提供就诊服务，挂号费用不退";
    attenL.numberOfLines = 0;
    attenL.font = [UIFont systemFontOfSize:14];
    attenL.textColor = [UIColor redColor];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, attenL.frame.origin.y+attenL.frame.size.height-5, self.alertview.frame.size.width, 0.5)];
    line.backgroundColor = [UIColor lightGrayColor];
    
    
    UIButton *creatBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    creatBtn.frame = CGRectMake(isCreate.frame.origin.x, attenL.frame.origin.y+attenL.frame.size.height, 100, 30);
    creatBtn.tag = 101;
    [creatBtn addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    [creatBtn setTitle:@"取消" forState:UIControlStateNormal];
    [creatBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    creatBtn.layer.cornerRadius = 3;
    UIButton *quitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    quitBtn.frame = CGRectMake(creatBtn.frame.origin.x+creatBtn.frame.size.width+20, creatBtn.frame.origin.y, creatBtn.frame.size.width, 30);
    [quitBtn setTitle:@"创建" forState:UIControlStateNormal];
    [quitBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    quitBtn.layer.cornerRadius = 3;
    quitBtn.tag = 100;
    [quitBtn addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    UIView *lint2 = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(creatBtn.frame)+10, line.frame.origin.y, 0.5, 60)];
    lint2.backgroundColor = [UIColor lightGrayColor];
    [self.alertview addSubview:lint2];
    [self.alertview addSubview:creatBtn];
    [self.alertview addSubview:quitBtn];
    
    [self.alertview addSubview:line];
    [self.alertview addSubview:attenL];
    [self.alertview addSubview:isCreate];
}
- (void)creatViewWithAlert:(CGRect)lineF
{
    
    _textF =[[UITextField alloc]initWithFrame:CGRectMake(15,lineF.origin.y+20, self.alertview.frame.size.width-30, 40)];
    _textF.placeholder = @"登录密码";
    _textF.secureTextEntry = YES;
    _textF.borderStyle = UITextBorderStyleRoundedRect;
    _textF.returnKeyType = UIReturnKeyDone;
    _textF.delegate = self;
    [_textF becomeFirstResponder];
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_textF.frame)+20, self.alertview.frame.size.width, 0.5)];
    line.backgroundColor = [UIColor lightGrayColor];
    
    UIButton *creatBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    creatBtn.frame = CGRectMake(_textF.frame.origin.x, line.frame.origin.y+5, 100, 30);
    creatBtn.tag = 101;
    [creatBtn addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    [creatBtn setTitle:@"取消" forState:UIControlStateNormal];
    [creatBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    creatBtn.layer.cornerRadius = 3;
    UIButton *quitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    quitBtn.frame = CGRectMake(creatBtn.frame.origin.x+creatBtn.frame.size.width+20, creatBtn.frame.origin.y, creatBtn.frame.size.width, 30);
    [quitBtn setTitle:@"确定" forState:UIControlStateNormal];
    [quitBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    quitBtn.layer.cornerRadius = 3;
    quitBtn.tag = 100;
    [quitBtn addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    UIView *lint2 = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(creatBtn.frame)+10, line.frame.origin.y, 0.5, 40)];
    lint2.backgroundColor = [UIColor lightGrayColor];
    [self.alertview addSubview:lint2];
    [self.alertview addSubview:creatBtn];
    [self.alertview addSubview:quitBtn];
    [self.alertview addSubview:line];
    [self.alertview addSubview:_textF];
    
}
- (void)blackClick
{
    [self cancleView];
}
- (void)cancleView
{
    
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        self.alertview = nil;
    }];
    
}
-(void)exChangeOut:(UIView *)changeOutView dur:(CFTimeInterval)dur{
    
    CAKeyframeAnimation * animation;
    
    animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    
    animation.duration = dur;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 0.9)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    animation.timingFunction = [CAMediaTimingFunction functionWithName: @"easeInEaseOut"];
    [changeOutView.layer addAnimation:animation forKey:nil];
}

-(void)clickButton:(UIButton *)button{
    if ([self.delegate respondsToSelector:@selector(didClickButtonAtIndex:password:)]) {
        if (_password == nil) {
            [self textFieldShouldEndEditing:_textF];
            [_textF resignFirstResponder];
        }
        [self.delegate didClickButtonAtIndex:button.tag password:_password];
    }
    [self cancleView];
}
-(void)initWithTitle:(NSString *) title Image:(UIImage *)image CancelButton:(NSString *)cancelButton OkButton:(NSString *)okButton
{
    
    self.title = title;
    self.cancelButtonTitle = cancelButton;
    self.okButtonTitle = okButton;
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    _password = textField.text;
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
    return YES;
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
