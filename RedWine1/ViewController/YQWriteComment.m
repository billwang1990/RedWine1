//
//  YQWriteComment.m
//  RedWine1
//
//  Created by niko on 13-5-27.
//  Copyright (c) 2013年 billwang. All rights reserved.
//

#import "YQWriteComment.h"

@interface YQWriteComment ()<UITextViewDelegate>


@end

@implementation YQWriteComment

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(sendMsg)];
 
    
    [[SZTextView appearance] setPlaceholderTextColor:[UIColor lightGrayColor]];
    
    self.text.placeholder = @"写下你的评论，140字以内";
    //    self.textView.placeholderTextColor = [UIColor redColor];
    self.text.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18.0];
    
    self.text.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)sendMsg
{
    NSString *input = self.text.text;
    NSLog(@"%@", input);
    
    [self.delegate SendMsg:input];
    
    [self.navigationController popViewControllerAnimated:YES];
}

//限制字数为140字
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    NSString* newText = [textView.text stringByReplacingCharactersInRange:range withString:text];
    
    if (newText.length > 140 ) {
        return NO;
    }
    return YES;

}



@end
