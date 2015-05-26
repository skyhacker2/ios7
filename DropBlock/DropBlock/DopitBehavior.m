//
//  DopitBehavior.m
//  DropBlock
//
//  Created by Eleven Chen on 15/5/24.
//  Copyright (c) 2015年 Hunuo. All rights reserved.
//

#import "DopitBehavior.h"

@interface DopitBehavior()
@property (strong, nonatomic) UIGravityBehavior *gravity;
@property (strong, nonatomic) UICollisionBehavior *collider;
@property (strong, nonatomic) UIDynamicItemBehavior *animationOptions;
@end

@implementation DopitBehavior

- (UIGravityBehavior*) gravity
{
    if (!_gravity) {
        _gravity = [[UIGravityBehavior alloc] init];
        _gravity.magnitude = 1.0;
    }
    return _gravity;
}

- (UICollisionBehavior*) collider
{
    if (!_collider) {
        _collider = [[UICollisionBehavior alloc] init];
        [_collider setTranslatesReferenceBoundsIntoBoundary:YES];
    }
    return _collider;
}

- (UIDynamicItemBehavior*) animationOptions
{
    if (!_animationOptions) {
        _animationOptions = [[UIDynamicItemBehavior alloc] init];
        _animationOptions.allowsRotation = NO;
    }
    
    return _animationOptions;
}

- (void)setCollisionBehaviorDelegate:(id<UICollisionBehaviorDelegate>)collisionBehaviorDelegate
{
    self.collider.collisionDelegate = collisionBehaviorDelegate;
}

- (void) addItem:(id<UIDynamicItem>) item
{
    [self.gravity addItem:item];
    [self.collider addItem:item];
    [self.animationOptions addItem:item];
}
- (void) removeItem:(id<UIDynamicItem>) item
{
    [self.gravity removeItem:item];
    [self.collider removeItem:item];
    [self.animationOptions removeItem:item];
}

- (instancetype) init
{
    self = [super init];
    if (self) {
        [self addChildBehavior:self.gravity];
        [self addChildBehavior:self.collider];
        [self addChildBehavior:self.animationOptions];
    }
    return self;
}

@end
