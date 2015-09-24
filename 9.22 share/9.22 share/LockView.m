//
//  LockView.m
//  9.22 share
//
//  Created by 张稳 on 15/9/22.
//  Copyright (c) 2015年 nlg. All rights reserved.
//

#import "LockView.h"
#import "LockButton.h"
#define BtnCount 9
#define BtnColCount 3
//延展
@interface LockView()
//已选择按钮数组
@property(nonatomic,strong)NSMutableArray *selectedButtons;
//触摸位置
@property(nonatomic,assign)CGPoint currentTouchLocation;

@end

@implementation LockView
//初始化数组
-(NSMutableArray *)selectedButtons
{
    if(_selectedButtons==nil)
    {
        _selectedButtons=[NSMutableArray array];
    }
    return _selectedButtons;
}
//使用文件初始化
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self _initViews];
    }
    return self;
}
//使用代码初始化
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _initViews];
    }
    return self;
}
//初始化按钮
-(void)_initViews
{
    //设置透明背景
    self.backgroundColor=[[UIColor alloc]initWithRed:1 green:1 blue:1 alpha:0];
    
    for(int i=0;i<BtnCount;i++)
    {
        LockButton *button=[LockButton buttonWithType:UIButtonTypeCustom];
        //设置指标tag，用来记录轨迹
        button.tag=i;
        //加入按钮到lockview
        [self addSubview:button];
    }
}
//设置按钮位置尺寸
-(void)layoutSubviews
{
    [super layoutSubviews];
    //取出所有按钮
    for(int i=0;i<self.subviews.count;i++)
    {
        LockButton*button=self.subviews[i];
        CGFloat btnWidth=74;
        CGFloat btnHeight=74;
        //按钮所在列号
        int col=i%BtnColCount;
        //按钮所在行号
        int row=i/BtnColCount;
        //等分水平多余空间，计算出间隙
        CGFloat marginX=(self.frame.size.width-BtnColCount*btnWidth)/(BtnColCount+1);
        CGFloat marginY=marginX;
        //x坐标
        CGFloat btnX=marginX+col*(btnWidth+marginX);
        CGFloat btnY=marginY +row*(btnHeight+marginY);
        
        button.frame=CGRectMake(btnX, btnY, btnWidth, btnHeight);
    }
}
//触摸事件
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self touchesMoved:touches withEvent:event];
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch=[touches anyObject];
    
    CGPoint touchLocation=[touch locationInView:touch.view];
    
    //检测哪个按钮被点中了
   for(LockButton *button in self.subviews)
   {
       //如果触碰到了此按钮
       if(CGRectContainsPoint(button.touchFrame, touchLocation))
       {
           button.selected=YES;
           //如果此按钮没有被碰到才进行处理
           if(![self.selectedButtons containsObject:button])
           {
               //加入到数组
               [self.selectedButtons addObject:button];
           }
       }
       //当前触摸位置
       self.currentTouchLocation=touchLocation;
   }
    //重绘
    [self setNeedsDisplay];
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    //轨迹序列
    NSMutableString *path=[NSMutableString string];
    //合成轨迹序列
    for(LockButton *button in self.selectedButtons)
    {
        //清除选中状态
        button.selected=NO;
        //添加到轨迹序列
        [path appendFormat:@"%ld",button.tag];
    }
    //调用代理方法
    if([self.delegate respondsToSelector:@selector(LockView:didFinishedWithPath:)])
    {
        [self.delegate LockView:self didFinishedWithPath:path];
    }
    //清除选中状态
    [self.selectedButtons makeObjectsPerformSelector:@selector(setSelected:) withObject:@(NO)];
    //清空数组
    [self.selectedButtons removeAllObjects];
    //重绘
    [self setNeedsDisplay];
}
//绘图方法
-(void)drawRect:(CGRect)rect
{
    UIBezierPath *path=[UIBezierPath bezierPath];
    //遍历已选择按钮数组
    for(int i=0;i<self.selectedButtons.count;i++)
    {
        LockButton *button=self.selectedButtons[i];
        if(i==0)
        {
            [path moveToPoint:button.center];
        }
        else
        {
            [path addLineToPoint:button.center];
        }
    }
    if(self.selectedButtons.count)
    {
        [path addLineToPoint:self.currentTouchLocation];
    }
    //设置画笔
    [[UIColor redColor]set];
    [path setLineWidth:10];
    [path setLineCapStyle:kCGLineCapRound];
    [path setLineJoinStyle:kCGLineJoinBevel];
    
    [path stroke];
    
}
@end
