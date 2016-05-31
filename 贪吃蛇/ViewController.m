//
//  ViewController.m
//  贪吃蛇
//
//  Created by BppleMan‘s Mac on 15/12/28.
//  Copyright © 2015年 BppleMan's Mac. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

SnakeView *snake;

- (void)viewDidLoad {
    [super viewDidLoad];
    //A Challenge Test
    CGRect rect = [[UIScreen mainScreen] bounds];
    CGFloat boundary_x = rect.size.width;
    CGFloat boundary_y = rect.size.height;
    NSLog(@"%lf %lf",boundary_x,boundary_y);
    self.view.backgroundColor = [UIColor colorWithRed:137.0f/255.0f green:203.0f/255.0f blue:193.0f/255.0f alpha:1];
    snake = [[SnakeView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width*1/20, 40, self.view.bounds.size.width*9/10, self.view.bounds.size.height*2/3)];
    [snake startGameWithScoreLabel:self.scoreLabel LevelLabel:self.levelLabel];
//    NSLog(@"%d",[snake Fun]);
    snake.layer.cornerRadius = 10;
    snake.layer.masksToBounds = YES;
    // 设置self.view控件支持用户交互
    self.view.userInteractionEnabled = YES;
    // 设置self.view控件支持多点触碰
    self.view.multipleTouchEnabled = YES;

    for (int i = 0 ; i < 4 ; i++)
    {
        // 创建手势处理器，指定使用该控制器的handleSwipe:方法处理轻扫手势
        UISwipeGestureRecognizer* gesture = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipe:)];
        // 设置该点击手势处理器只处理i个手指的轻扫手势
        gesture.numberOfTouchesRequired = 1;
        // 指定该手势处理器只处理1 << i方向的轻扫手势
        gesture.direction = 1 << i;
        // 为self.view控件添加手势处理器。
        [self.view addGestureRecognizer:gesture];
    }
    
    [self.view addSubview:snake];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 实现手势处理器的方法，该方法应该声明一个形参。
// 当该方法被激发时，手势处理器会作为参数传给该方法的参数。
- (void) handleSwipe:(UISwipeGestureRecognizer*)gesture
{
    // 获取轻扫手势的方向
    NSUInteger direction = gesture.direction;
    switch (direction)
    {
        case UISwipeGestureRecognizerDirectionLeft:
            if(snake.orient != Right) // 只要不是向右，即可改变方向
                snake.orient = Left;
            break;
        case UISwipeGestureRecognizerDirectionUp:
            if(snake.orient != Down) // 只要不是向下，即可改变方向
                snake.orient = Up;
            break;
        case UISwipeGestureRecognizerDirectionDown:
            if(snake.orient != Up) // 只要不是向上，即可改变方向
                snake.orient = Down;
            break;
        case UISwipeGestureRecognizerDirectionRight:
            if(snake.orient != Left) // 只要不是向左，即可改变方向
                snake.orient = Right;
            break;
    }
}

@end
