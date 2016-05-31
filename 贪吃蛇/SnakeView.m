//
//  SnakeView.m
//  贪吃蛇
//
//  Created by BppleMan‘s Mac on 15/12/28.
//  Copyright © 2015年 BppleMan's Mac. All rights reserved.
//

#import "SnakeView.h"

@implementation SnakeView
{
    CGFloat CELL_SIZE;
    int WIDTH,HEIGHT;
    int Level;
    int Score;
    myPoint *head;
    myPoint *food;
    UILabel *scoreLabel;
    UILabel *levelLabel;
    NSTimeInterval speed;
    NSTimer *timer;
    NSMutableArray *snakeData;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        WIDTH = 15;
        HEIGHT = 20;
        CELL_SIZE = (self.frame.size.width/WIDTH +
                     self.frame.size.height/HEIGHT) / 2;
        //[self startGameWithLevel:_Level];
    }
    return self;
}

- (void) startGameWithScoreLabel:(UILabel*)scorelabel LevelLabel:(UILabel*)levellabel
{
    snakeData = [[NSMutableArray alloc]initWithObjects:[[myPoint alloc]initWithX:0 Y:0], nil];
    _orient = Right;
    Level = 0;
    Score = 0;
    food = nil;
    scoreLabel = scorelabel;
    levelLabel = levellabel;
    speed = 0.5 - 0.1*Level;
    [self ChangeSpeed:speed];
}

- (void)ChangeSpeed:(NSTimeInterval)Speed
{
    [timer invalidate];
    NSLog(@"%lf",speed);
    timer = [NSTimer scheduledTimerWithTimeInterval:Speed target:self selector:@selector(move) userInfo:nil repeats:YES];
}

- (void) move
{
    //选取最后一个节点作为蛇头
    myPoint *temp = [snakeData objectAtIndex:snakeData.count-1];
    head = [[myPoint alloc]initWithX:temp.x Y:temp.y];
    switch (_orient) {
        case Up:
            head.y -= 1;
            break;
        case Down:
            head.y += 1;
            break;
        case Left:
            head.x -= 1;
            break;
        case Right:
            head.x += 1;
            break;
        default:
            break;
    }
    if([head isEqual:food])
    {
        [snakeData addObject:food];
        Score += 10;
        if(Score % 10 == 0)
        {
            Level += 1;
            if(Level < 0.5)
                speed = 0.5 - 0.1*Level;
//            //关闭计时器
//            [timer invalidate];
            //调用ChangeSpeed方法利用改变后的速度新建一个计时器
            [self ChangeSpeed:speed];
        }
        food = nil;
    }
    else
    {
        for (int i = 0; i < snakeData.count - 1; i++) {
            myPoint *temp1 = [snakeData objectAtIndex:i];
            myPoint *temp2 = [snakeData objectAtIndex:i + 1];
            [temp1 AssignmentWith:temp2];
        }
        // 重新设置蛇头坐标
        [snakeData setObject:head atIndexedSubscript:(snakeData.count - 1)];
    }
    
    //更新Label的显示
    scoreLabel.text = [NSString stringWithFormat:@"%d",Score];
    levelLabel.text = [NSString stringWithFormat:@"%d",Level];
    
    //生成新的食物
    if(food == nil)
    {
        while(true)
        {
            myPoint *newFoodPos = [[myPoint alloc]initWithX:arc4random()%WIDTH Y:arc4random() % HEIGHT];
            // 如果新产生的食物点，没有位于蛇身体上
            if(![snakeData containsObject:food])
            {
                food = newFoodPos;
                break; // 成功生成了食物的位置，跳出循环
            }
        }
    }
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    // 获取绘图API
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGRect myCGRect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    
    //设置Clear区域
//    CGContextClearRect(ctx, CGRectMake(0 , 0, WIDTH * CELL_SIZE , HEIGHT * CELL_SIZE));
    CGContextClearRect(ctx, myCGRect);
    
    //填充背景颜色
    CGContextSetFillColorWithColor(ctx, [[UIColor colorWithRed:0.875 green:0.886 blue:0.773 alpha:1.000] CGColor]);
    
    //设置背景位置 并绘制
//    CGContextFillRect(ctx, CGRectMake(0 , 0, WIDTH * CELL_SIZE , HEIGHT * CELL_SIZE));
    CGContextFillRect(ctx, myCGRect);
    
    //在指定区域填充颜色
    CGContextSetRGBFillColor(ctx, 186.0/255.0, 146.0/255.0, 188.0/255.0, 1.000);
    
    for (int i = 0; i < snakeData.count; i++)
    {
        myPoint *temp = [snakeData objectAtIndex:i];
        //利用新的rect_temp绘制蛇
        CGRect rect_temp = CGRectMake(temp.x * CELL_SIZE , temp.y * CELL_SIZE, CELL_SIZE , CELL_SIZE);
        //填充指定矩形中的椭圆
        CGContextFillEllipseInRect(ctx, rect_temp);
    }
    
    //填充食物颜色
    CGContextSetRGBFillColor(ctx, 254.0/255.0, 218.0/255.0, 124.0/255.0, 1);
    
    if (food) {
        CGRect rect_temp = CGRectMake(food.x * CELL_SIZE , food.y * CELL_SIZE, CELL_SIZE , CELL_SIZE);
        CGContextFillEllipseInRect(ctx, rect_temp);
    }
}

@end
