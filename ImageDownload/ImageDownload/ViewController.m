//
//  ViewController.m
//  ImageDownload
//
//  Created by Eleven Chen on 15/5/25.
//  Copyright (c) 2015年 Eleven. All rights reserved.
//

#import "ViewController.h"
#import "ImageViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[ImageViewController class]]) {
        ImageViewController *imageController = (ImageViewController*)segue.destinationViewController;
        imageController.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://ww1.sinaimg.cn/mw690/%@.jpg", segue.identifier]];
        imageController.title = segue.identifier;
    }
}

@end
