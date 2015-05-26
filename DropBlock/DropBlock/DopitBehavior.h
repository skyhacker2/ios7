//
//  DopitBehavior.h
//  DropBlock
//
//  Created by Eleven Chen on 15/5/24.
//  Copyright (c) 2015年 Hunuo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DopitBehavior : UIDynamicBehavior
@property id<UICollisionBehaviorDelegate> collisionBehaviorDelegate;
- (void) addItem:(id<UIDynamicItem>) item;
- (void) removeItem:(id<UIDynamicItem>) item;
@end
