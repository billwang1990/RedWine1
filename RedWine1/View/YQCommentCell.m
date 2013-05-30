//
//  YQCommentCell.m
//  RedWine1
//
//  Created by niko on 13-5-27.
//  Copyright (c) 2013年 billwang. All rights reserved.
//

#import "YQCommentCell.h"

@implementation YQCommentCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.commentLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [self.commentLabel setNumberOfLines:0];
    [self.commentLabel setFont:[UIFont systemFontOfSize:14]];
    [self.commentLabel sizeToFit];
}

@end
