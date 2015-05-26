//
//  PlayingCardView.h
//  CustomView
//
//  Created by Eleven Chen on 15/5/21.
//  Copyright (c) 2015年 Hunuo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayingCardView : UIView

@property (nonatomic) NSUInteger rank;
@property (strong, nonatomic) NSString *suit;
@property (nonatomic) BOOL faceUp;

@end
