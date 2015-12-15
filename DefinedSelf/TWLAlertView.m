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
        _blackView.alpha = 0.4;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(blackClick)];
        [self.blackView addGestureRecognizer:tap];
        [self addSubview:_blackView];
        //创建alert
        self.alertview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 270, 250)];
        self.alertview.center = self.center;
        self.alertview.layer.cornerRadius = 17;
        self.alertview.clipsToBounds = YES;
        self.alertview.backgroundColor = [UIColor whiteColor];
        [self addSubview:_alertview];
        [self exChangeOut:self.alertview dur:0.6];
       
    }
    return self;
}
- (void)creatViewInAlert
{

    UILabel *tipLable = [[UILabel alloc]initWithFrame:CGRectMake(0,0,270,50)];

    tipLable.textAlignment = NSTextAlignmentCenter;
    tipLable.text = _tipStr;
    tipLable.font = [UIFont boldSystemFontOfSize:16];
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(tipLable.frame), self.alertview.frame.size.width, 0.5)];
    lineView.backgroundColor = [UIColor blackColor];
    
    UILabel *isCreate = [[UILabel alloc]initWithFrame:CGRectMake(20, lineView.frame.origin.y+8, self.alertview.frame.size.width-40, 30)];
    isCreate.text =_maintitle;
    isCreate.font = tipLable.font;
    UILabel *attenL = [[UILabel alloc]initWithFrame:CGRectMake(isCreate.frame.origin.x, isCreate.frame.origin.y+10, self.alertview.frame.size.width-40, 130)];
    attenL.font = [UIFont systemFontOfSize:15];
    attenL.text = _minorTitle;
    attenL.numberOfLines = 0;
    attenL.font = [UIFont systemFontOfSize:14];
    attenL.textColor = [UIColor redColor];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, attenL.frame.origin.y+attenL.frame.size.height-5, self.alertview.frame.size.width, 0.5)];
    line.backgroundColor = [UIColor lightGrayColor];
    
    UIButton *creatBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    creatBtn.frame = CGRectMake(isCreate.frame.origin.x, attenL.frame.origin.y+attenL.frame.size.height, 100, 30);
    creatBtn.tag = 1;
    [creatBtn addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    [creatBtn setTitle:@"取消" forState:UIControlStateNormal];
    [creatBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    creatBtn.layer.cornerRadius = 3;
    UIButton *quitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    quitBtn.frame = CGRectMake(creatBtn.frame.origin.x+creatBtn.frame.size.width+20, creatBtn.frame.origin.y, creatBtn.frame.size.width, 30);
    [quitBtn setTitle:@"创建" forState:UIControlStateNormal];
    [quitBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    quitBtn.layer.cornerRadius = 3;
    quitBtn.tag = 0;
    [quitBtn addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    UIView *lint2 = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(creatBtn.frame)+10, line.frame.origin.y, 0.5, 60)];
    lint2.backgroundColor = [UIColor lightGrayColor];
    [self.alertview addSubview:lint2];
    [self.alertview addSubview:creatBtn];
    [self.alertview addSubview:quitBtn];
    [self.alertview addSubview:lineView];
    [self.alertview addSubview:line];
    [self.alertview addSubview:attenL];
    [self.alertview addSubview:isCreate];
    [self.alertview addSubview:tipLable];
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
    if ([self.delegate respondsToSelector:@selector(didClickButtonAtIndex:)]) {
        [self.delegate didClickButtonAtIndex:(button.tag)];
    }
    [self cancleView];
}
- (void)AlertView:(NSString *)maintitle minorTitle:(NSString *)minorTitle tipString:(NSString *)tip
{
    self.minorTitle = minorTitle;
    self.maintitle = maintitle;
    self.tipStr = tip;
     [self creatViewInAlert];
}


@end
