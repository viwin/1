//
//  LockButton.m
//  9.22 share
//
//  Created by 张稳 on 15/9/22.
//  Copyright (c) 2015年 nlg. All rights reserved.
//

#import "LockButton.h"

@implementation LockButton
//使用文件创建会调用
- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self _initButton];
    }
    return self;
}
//使用代码创建会调用
-(instancetype)initWithFrame:(CGRect)frame
{
    if(self=[super initWithFrame:frame])
    {
        [self _initButton];
    }
    return self;
}
-(void)_initButton
{
    //取消交互事件（点击）
    self.userInteractionEnabled=NO;
    //设置普通状态图片
    [self setBackgroundImage:[UIImage imageNamed:@"gesture_node_normal"] forState:UIControlStateNormal ];
    //设置选中状态图片
    [self setBackgroundImage:[UIImage imageNamed:@"gesture_node_highlighted"] forState:UIControlStateSelected];
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    //可触碰范围
    CGFloat touchWidth=24;
    CGFloat touchHeight=24;
    CGFloat touchX=self.center.x-touchWidth/2;
    CGFloat touchY=self.center.y-touchHeight/2;
    self.touchFrame=CGRectMake(touchX, touchY, 24, 24);
}
@end
