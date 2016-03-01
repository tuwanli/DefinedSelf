//
//  TWLAlertView.m
//  DefinedSelf
//
//  Created by 涂婉丽 on 15/12/15.
//  Copyright © 2015年 涂婉丽. All rights reserved.
//eregfg

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
        self.alertview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 270, 190)];
        self.alertview.center = self.center;
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
    
    _tipLable = [[UILabel alloc]initWithFrame:CGRectMake(0,0,270,43)];
    _tipLable.textAlignment = NSTextAlignmentCenter;
    [_tipLable setBackgroundColor:[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0]];
    _tipLable.text = _title;
    [_tipLable setFont:[UIFont systemFontOfSize:18]];
    [_tipLable setTextColor:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]];
    
    [self.alertview addSubview:_tipLable];
    
    switch (_type) {
        case 10:
            self.alertview.frame = CGRectMake(0, 0, 270, 250);

            [self creatViewInAlert];
            break;
        case 11:
            self.alertview.frame = CGRectMake(0, 0, 270, 170);
            
            [self creatViewWithAlert];
            break;
        case 12:
            [self creatViewWithPidAlert];

        default:
            break;
    }
    self.alertview.center = CGPointMake(self.center.x, self.center.y);
    
    [self createBtnTitle:_btnTitleArr];
}

- (void)creatViewInAlert
{
    
    UILabel *isCreate = [[UILabel alloc]initWithFrame:CGRectMake(20, _tipLable.frame.origin.y+8+ _tipLable.frame.size.height, self.alertview.frame.size.width-40, 30)];
    isCreate.text = @"是否创建一个就诊号？";
    isCreate.font = [UIFont boldSystemFontOfSize:16];
    UILabel *attenL = [[UILabel alloc]initWithFrame:CGRectMake(isCreate.frame.origin.x, isCreate.frame.origin.y+20, self.alertview.frame.size.width-40, 130)];
    attenL.font = [UIFont systemFontOfSize:15];
    attenL.text = _contentStr;
    
    attenL.numberOfLines = 0;
    attenL.font = [UIFont systemFontOfSize:14];
    attenL.textColor = [UIColor redColor];
    [self.alertview addSubview:attenL];
    [self.alertview addSubview:isCreate];
}
- (void)creatViewWithAlert
{
    _textF =[[UITextField alloc]initWithFrame:CGRectMake(15, _tipLable.frame.origin.y+20+ _tipLable.frame.size.height, self.alertview.frame.size.width-30, 40)];
    _textF.placeholder = @"登录密码";
    _textF.secureTextEntry = YES;
    _textF.borderStyle = UITextBorderStyleRoundedRect;
    _textF.returnKeyType = UIReturnKeyDone;
    _textF.delegate = self;
    [_textF becomeFirstResponder];
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_textF.frame)+20, self.alertview.frame.size.width, 0.5)];
    line.backgroundColor = [UIColor lightGrayColor];
    [self.alertview addSubview:_textF];
    
}

- (void)creatViewWithPidAlert
{
    UILabel *showL = [[UILabel alloc]initWithFrame:CGRectMake(20, _tipLable.frame.origin.y+_tipLable.frame.size.height, self.alertview.frame.size.width-40, self.alertview.frame.size.height-43-48)];
    [showL setTextColor:[UIColor colorWithRed:149/255.0 green:149/255.0 blue:149/255.0 alpha:1.0]];
    showL.numberOfLines = 0;
    [showL setFont:[UIFont systemFontOfSize:18]];
    [showL setText:_contentStr];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:showL.text];;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:9];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, showL.text.length)];
    
    showL.attributedText = attributedString;
    showL.textAlignment = NSTextAlignmentCenter;
    
    
    [self.alertview addSubview:showL];
    
}
- (void)createBtnTitle:(NSArray *)titleArr
{
    
    CGFloat m = self.alertview.frame.size.width;
    
    for (int i=0; i<_numBtn; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        if (_numBtn == 1) {
            btn.frame = CGRectMake(20, self.alertview.frame.size.height-48,(m-40), 33);
        }else{
            
            btn.frame = CGRectMake(20+i*(20+(m-60)/2), self.alertview.frame.size.height-48, (m-60)/2, 33);
        }
        
        [btn setTitle:titleArr[i] forState:UIControlStateNormal];
        btn.tag = 100+i;
        btn.layer.cornerRadius = 5;
        btn.clipsToBounds = YES;
        [btn addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:18]];
        if ([titleArr[i] isEqualToString:@"确定"]||[titleArr[i] isEqualToString:@"退出页面"]) {
//            [btn setBackgroundColor:[UIColor colorWithHexString:[ThemeSingleton sharedInstance].UINavgationBar alpha:1]];
            [btn setBackgroundColor:[UIColor colorWithRed:46/255.0 green:149/255.0 blue:250/255.0 alpha:1.0]];
        }else{
            
            [btn setBackgroundColor:[UIColor colorWithRed:255/255.0 green:102/255.0 blue:102/255.0 alpha:1.0]];
        }
        [self.alertview addSubview:btn];
    }
}
- (void)blackClick
{
    [self cancleView];
}
- (void)cancleView
{
    
    [UIView animateWithDuration:0.3 animations:^{
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
//    DLog(@"%ld",button.tag);
    if ([self.delegate respondsToSelector:@selector(didClickButtonAtIndex:password:)]) {
        if (_password == nil) {
            [self textFieldShouldEndEditing:_textF];
            [_textF resignFirstResponder];
        }
        if ([button.titleLabel.text isEqualToString:@"退出页面"]) {
            button.tag = 101;
        }
        [self.delegate didClickButtonAtIndex:button.tag password:_password];
    }
    [self cancleView];
}
-(void)initWithTitle:(NSString *) title contentStr:(NSString *)content type:(NSInteger)type btnNum:(NSInteger)btnNum btntitleArr:(NSArray *)btnTitleArr

{
    _title = title;
    _type = type;
    _numBtn = btnNum;
    _btnTitleArr = btnTitleArr;
    _contentStr = content;
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    
//    DLog(@"%@",textField.text);
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
