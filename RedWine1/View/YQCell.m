//
//  YQCell.m
//  RedWine1
//
//  Created by niko on 13-5-26.
//  Copyright (c) 2013年 billwang. All rights reserved.
//

#import "YQCell.h"

@implementation YQCell

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


-(void)layoutSubviews{
    self.CenterImg.userInteractionEnabled = YES;
    
}
@end
