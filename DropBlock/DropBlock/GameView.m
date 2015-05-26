//
//  GameView.m
//  DropBlock
//
//  Created by Eleven Chen on 15/5/24.
//  Copyright (c) 2015年 Hunuo. All rights reserved.
//

#import "GameView.h"

@implementation GameView

- (void) setPath:(UIBezierPath *)path
{
    _path = path;
    [self setNeedsDisplay];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [self.path stroke];
}


@end
