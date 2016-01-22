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
-(void)didClickButtonAtIndex:(NSUInteger)index password:(NSString *)password;
- (void)successPassword;
@end
@interface TWLAlertView : UIView<UITextFieldDelegate>
@property (nonatomic,strong)UIView *blackView;
@property (strong,nonatomic)UIView * alertview;
@property (strong,nonatomic)NSString * title;
@property (strong,nonatomic)NSString * cancelButtonTitle;
@property (strong,nonatomic)NSString * okButtonTitle;
@property (weak,nonatomic) id<TWlALertviewDelegate> delegate;
@property (nonatomic,assign)NSInteger type;
@property (nonatomic,copy)NSString *password;
@property (nonatomic,retain)UITextField *textF;
@end
