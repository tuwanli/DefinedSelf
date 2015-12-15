//
//  TWLAlertView.h
//  DefinedSelf
//
//  Created by 涂婉丽 on 15/12/15.
//  Copyright © 2015年 涂婉丽. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol TWlALertviewDelegate<NSObject>
@optional
-(void)didClickButtonAtIndex:(NSUInteger)index;

@end
@interface TWLAlertView : UIView
@property (nonatomic,strong)UIView *blackView;
@property (strong,nonatomic)UIView * alertview;
@property (strong,nonatomic)NSString * maintitle;
@property (strong,nonatomic)NSString * minorTitle;
@property (strong,nonatomic)NSString * tipStr;
@property (weak,nonatomic) id<TWlALertviewDelegate> delegate;
- (void)AlertView:(NSString *)maintitle minorTitle:(NSString *)minorTitle tipString:(NSString *)tip;
@end
