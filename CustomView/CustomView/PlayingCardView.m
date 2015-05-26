//
//  PlayingCardView.m
//  CustomView
//
//  Created by Eleven Chen on 15/5/21.
//  Copyright (c) 2015年 Hunuo. All rights reserved.
//

#import "PlayingCardView.h"

@implementation PlayingCardView

#pragma mark - setter
- (void) setSuit:(NSString *)suit
{
    _suit = suit;
    [self setNeedsDisplay];
}

- (void) setRank:(NSUInteger)rank
{
    _rank = rank;
    [self setNeedsDisplay];
}

- (void) setFaceUp:(BOOL)faceUp
{
    _faceUp = faceUp;
    [self setNeedsDisplay];
}

#pragma mark - initialize
- (void) setup
{
    self.backgroundColor = nil;
    self.opaque = NO;
    self.contentMode = UIViewContentModeRedraw;
}

- (void) awakeFromNib
{
    [super awakeFromNib];
    [self setup];
}

#pragma mark - draw
#define CONNER_FONT_STANDAD_HEIGHT 180.0
#define CONNER_RADIUS 12.0
- (CGFloat) cornerScaleFactor
{
    return self.bounds.size.height / CONNER_FONT_STANDAD_HEIGHT;
}
-(CGFloat) cornerRadius
{
    return CONNER_RADIUS * [self cornerScaleFactor];
}
- (CGFloat) cornerOffset
{
    return [self cornerRadius] / 3.0;
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    UIBezierPath *roundRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:[self cornerRadius]];
    [roundRect addClip];
    
    if (self.faceUp) {
        [[UIColor whiteColor] setFill];
        UIRectFill(self.bounds);
        
        [[UIColor blackColor] setStroke];
        [roundRect stroke];
        
        [self drawCorner];
    } else {
        [[UIImage imageNamed:@"card"]drawInRect:self.bounds];
    }

}


- (void) drawCorner
{
    // 新建一个居中的样式
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = NSTextAlignmentCenter;
    
    //字体
    UIFont *cornerFont = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    cornerFont = [cornerFont fontWithSize:cornerFont.pointSize * [self cornerScaleFactor]];
    
    NSMutableAttributedString *cornerText = [[NSMutableAttributedString alloc] initWithString:@"♤\n3" attributes:@{NSFontAttributeName: cornerFont,NSParagraphStyleAttributeName: paragraphStyle}];
    CGRect textBounds;
    textBounds.origin = CGPointMake([self cornerOffset], [self cornerOffset]);
    textBounds.size = [cornerText size];
    [cornerText drawInRect:textBounds];
    
    // 移到右下角
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, self.bounds.size.width, self.bounds.size.height);
    CGContextRotateCTM(context, M_PI);
    [cornerText drawInRect:textBounds];
}


@end
