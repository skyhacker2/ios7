//
//  ViewController.m
//  DropBlock
//
//  Created by Eleven Chen on 15/5/24.
//  Copyright (c) 2015年 Hunuo. All rights reserved.
//

#import "ViewController.h"
#import "DopitBehavior.h"
#import "GameView.h"

static const CGSize DROP_SIZE = {40, 40};

@interface ViewController () <UIDynamicAnimatorDelegate, UICollisionBehaviorDelegate>
@property (weak, nonatomic) IBOutlet GameView *gameView;
@property (strong, nonatomic) UIDynamicAnimator *animator;
@property (strong, nonatomic) DopitBehavior *dopitBehavior;
@property (strong, nonatomic) UIAttachmentBehavior *attachment;
@property (strong, nonatomic) UIView *droppingView;

@end

@implementation ViewController

#pragma mark - IBAction
- (IBAction)tap:(id)sender
{
    [self drop];
}

- (IBAction)pan:(UIPanGestureRecognizer *)sender {
    CGPoint gesturePoint = [sender locationInView:self.gameView];
    if (sender.state == UIGestureRecognizerStateBegan) {
        [self attachDroppingViewToPoint:gesturePoint];
    } else if (sender.state == UIGestureRecognizerStateChanged) {
        self.attachment.anchorPoint = gesturePoint;
    } else if (sender.state == UIGestureRecognizerStateEnded) {
        [self.animator removeBehavior:self.attachment];
        self.gameView.path = nil;
    }

}

- (void) attachDroppingViewToPoint:(CGPoint) anchorPoint
{
    if (self.droppingView) {
        self.attachment = [[UIAttachmentBehavior alloc] initWithItem:self.droppingView attachedToAnchor:anchorPoint];
        UIView *droppingView = self.droppingView;
        __weak ViewController *weakSelf = self;
        self.attachment.action = ^{
            UIBezierPath *path = [[UIBezierPath alloc] init];
            [path moveToPoint:weakSelf.attachment.anchorPoint];
            [path addLineToPoint:droppingView.center];
            weakSelf.gameView.path = path;
        };
        
        self.droppingView = nil;
        [self.animator addBehavior:self.attachment];
    }
}

#pragma mark - setter / getter
- (UIDynamicAnimator*) animator
{
    if (!_animator) {
        _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.gameView];
        _animator.delegate = self;
    }
    return _animator;
}

- (DopitBehavior*) dopitBehavior
{
    if (!_dopitBehavior) {
        _dopitBehavior = [[DopitBehavior alloc] init];
        [self.animator addBehavior:_dopitBehavior];
    }
    return _dopitBehavior;
}

#pragma mark - logic

- (void) drop
{
    CGRect frame;
    frame.origin = CGPointZero;
    frame.size = DROP_SIZE;
    int x = (arc4random() % (int)self.gameView.bounds.size.width) / DROP_SIZE.width;
    frame.origin.x = x * DROP_SIZE.width;
    
    UIView* dropView = [[UIView alloc] initWithFrame:frame];
    self.droppingView = dropView;
    dropView.backgroundColor = [self randomColor];
    [[self gameView] addSubview:dropView];
    [self.dopitBehavior addItem:dropView];
}

- (UIColor*) randomColor
{
    switch (arc4random() % 5) {
        case 0:
            return [UIColor blueColor];
        case 1:
            return [UIColor redColor];
        case 2:
            return [UIColor greenColor];
        case 3:
            return [UIColor yellowColor];
        case 4:
            return [UIColor purpleColor];
        default:
            break;
    }
    return [UIColor blackColor];
}

- (BOOL) removeCompleteRow
{
    NSMutableArray *dropsToRemove = [[NSMutableArray alloc] init];
    for (int y = self.gameView.bounds.size.height - DROP_SIZE.height/2; y > 0; y -= DROP_SIZE.height) {
        BOOL rowIsComplete = YES;
        NSMutableArray *dropsFound = [[NSMutableArray alloc] init];
        for (int x = DROP_SIZE.width/2; x <= self.gameView.bounds.size.width - DROP_SIZE.width/2; x+=DROP_SIZE.width) {
            UIView *hitView = [self.gameView hitTest:CGPointMake(x, y) withEvent:NULL];
            if ([hitView superview] == self.gameView) {
                [dropsFound addObject:hitView];
            } else {
                rowIsComplete = NO;
                break;
            }
        }
//        if (![dropsFound count]) {
//            break;
//        }
        if (rowIsComplete) {
            [dropsToRemove addObjectsFromArray:dropsFound];
        }
    }
    
    if ([dropsToRemove count]) {
        for (UIView *view in dropsToRemove) {
            [self.dopitBehavior removeItem:view];
        }
        [self animateRemoveDrops:dropsToRemove];
        return YES;
    }
    return NO;
    
}

- (void) animateRemoveDrops: (NSArray*) drops
{
    [UIView animateWithDuration:1.0
                     animations:^{
                         for (UIView *view in drops)
                         {
                             int x = (arc4random() % (int)self.gameView.bounds.size.width*5) - self.gameView.bounds.size.width*2;
                             int y = self.gameView.bounds.size.height;
                             view.center = CGPointMake(x, -y);
                         }
                     }
                     completion:^(BOOL finish){
                         [drops makeObjectsPerformSelector:@selector(removeFromSuperview)];
                     }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIDynamicAnimatorDelegate
- (void)dynamicAnimatorDidPause:(UIDynamicAnimator *)animator
{
    [self removeCompleteRow];
}

@end
