//
//  YQWriteComment.h
//  RedWine1
//
//  Created by niko on 13-5-27.
//  Copyright (c) 2013年 billwang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SZTextView.h"

@protocol WriteCommentDelegate <NSObject>

-(void)SendMsg: (NSString *)input;

@end

@interface YQWriteComment : UIViewController

@property (nonatomic, weak) id<WriteCommentDelegate> delegate;
@property (weak, nonatomic) IBOutlet SZTextView *text;

@end
