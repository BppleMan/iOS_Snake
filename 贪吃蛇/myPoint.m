//
//  myPoint.m
//  贪吃蛇
//
//  Created by BppleMan‘s Mac on 15/12/28.
//  Copyright © 2015年 BppleMan's Mac. All rights reserved.
//

#import "myPoint.h"

@implementation myPoint

- (myPoint*)initWithX:(NSInteger) x Y:(NSInteger) y;
{
    self = [super init];
    if (self) {
        self.x = x;
        self.y = y;
    }
    return self;
}


- (BOOL)isEqual:(myPoint*)other
{
    if(self.x == other.x && self.y == other.y)
        return YES;
    else return NO;
}

- (myPoint*)AssignmentWith:(myPoint*)test
{
    self.x = test.x;
    self.y = test.y;
    return self;
}

@end
