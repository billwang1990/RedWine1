//
//  YQHonour.h
//  RedWine1
//
//  Created by niko on 13-5-27.
//  Copyright (c) 2013年 billwang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoStackView.h"


@interface YQHonour : UIViewController<PhotoStackViewDataSource, PhotoStackViewDelegate>
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (nonatomic) PhotoStackView *photoStack;
@end
