//
//  ViewController.m
//  CustomView
//
//  Created by Eleven Chen on 15/5/21.
//  Copyright (c) 2015年 Hunuo. All rights reserved.
//

#import "ViewController.h"
#import "PlayingCardView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet PlayingCardView *playCard;

@end

@implementation ViewController
- (IBAction)swipe:(UISwipeGestureRecognizer *)sender {
    self.playCard.faceUp = !self.playCard.faceUp;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
