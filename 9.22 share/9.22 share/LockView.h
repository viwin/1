//
//  LockView.h
//  9.22 share
//
//  Created by 张稳 on 15/9/22.
//  Copyright (c) 2015年 nlg. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LockView;
@protocol LockViewDelegate <NSObject>//代理

//结束手势解锁代理事件
@optional
- (void) LockView:(LockView *) LockView didFinishedWithPath:(NSString *) path;

@end

@interface LockView : UIView

//代理
@property(nonatomic,strong)id<LockViewDelegate>delegate;

@end
