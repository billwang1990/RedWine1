//
//  YQViewController.m
//  RedWine1
//
//  Created by niko on 13-5-26.
//  Copyright (c) 2013年 billwang. All rights reserved.
//

#import "YQViewController.h"

@interface YQViewController ()

@end

@implementation YQViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self.ScanBtn setBackgroundImage:[UIImage imageNamed:@"camera_button_take.png"] forState:UIControlStateNormal];
    [self.ScanBtn setBackgroundImage:[UIImage imageNamed:@"tabBar_cameraButton_ready_matte.png"] forState:UIControlStateHighlighted];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
