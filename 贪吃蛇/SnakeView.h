//
//  SnakeView.h
//  贪吃蛇
//
//  Created by BppleMan‘s Mac on 15/12/28.
//  Copyright © 2015年 BppleMan's Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "myPoint.h"


typedef enum {
    Down = 0,
    Left,
    Right,
    Up
} Orient;

@interface SnakeView : UIView

@property (nonatomic , assign) Orient orient;

- (void) startGameWithScoreLabel:(UILabel*)scorelabel LevelLabel:(UILabel*)levellabel;

@end
