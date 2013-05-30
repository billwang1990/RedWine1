//
//  SZTextView.h
//  RedWineDemo
//
//  Created by niko on 13-5-23.
//  Copyright (c) 2013年 bill wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SZTextView : UITextView
@property (copy, nonatomic) NSString *placeholder;
@property (retain, nonatomic) UIColor *placeholderTextColor UI_APPEARANCE_SELECTOR;
@end
