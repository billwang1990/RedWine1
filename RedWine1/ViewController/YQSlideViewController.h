//
//  YQSlideViewController.h
//  RedWine
//
//  Created by niko on 13-5-24.
//  Copyright (c) 2013年 billwang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YQSlideViewController : UIViewController<UIScrollViewDelegate>

@property (nonatomic) NSMutableArray *viewControllers;
@property (nonatomic) NSUInteger selectedIndex;
@property (nonatomic) CGFloat scaleFactor;

- (void)nextViewController;
- (void)prevViewController;

@end


@interface UIViewController(YQSlideViewController)

@property (nonatomic) YQSlideViewController *slideViewController;

@end