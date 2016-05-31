//
//  myPoint.h
//  贪吃蛇
//
//  Created by BppleMan‘s Mac on 15/12/28.
//  Copyright © 2015年 BppleMan's Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface myPoint : NSObject

@property (nonatomic, assign) NSInteger x;
@property (nonatomic, assign) NSInteger y;

- (id)initWithX:(NSInteger)_x Y:(NSInteger) _y;
- (BOOL)isEqual:(id)other;
- (id)AssignmentWith:(id)test;


@end
