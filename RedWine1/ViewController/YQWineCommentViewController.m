//
//  YQWineCommentViewController.m
//  RedWine1
//
//  Created by niko on 13-5-27.
//  Copyright (c) 2013年 billwang. All rights reserved.
//

#import "YQWineCommentViewController.h"
#import "YQWriteComment.h"
#import "YQCommentCell.h"
#import "Head_file.h"
#import "GGFullScreenImageViewController.h"
#import "Comment.h"

@interface YQWineCommentViewController ()<UITableViewDataSource, UITableViewDelegate, WriteCommentDelegate>

@end

@implementation YQWineCommentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    UIImage *topBg = [UIImage imageNamed:@"bg_nav"];
    [self.navigationController.navigationBar setBackgroundImage:topBg forBarMetrics:UIBarMetricsDefault];
    
    UIButton *leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(0,0,30,30)];
    [leftBtn setImage:[UIImage imageNamed:@"go-home.png"]forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(goHome)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    
    self.navigationItem.leftBarButtonItem= leftItem;
    
    UIButton *rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [rightBtn setImage:[UIImage imageNamed:@"comment-add.png"] forState:UIControlStateNormal];
    
    [rightBtn addTarget:self action:@selector(writeComment) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.wantsFullScreenLayout = YES;
     
    self.dataArray = [[NSMutableArray alloc]init];
    
    Comment *c1 = [[Comment alloc]init];
    c1.comment = @"这款酒的味道不错";
    [self.dataArray addObject:c1];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)goHome
{
    [[NSNotificationCenter defaultCenter]postNotificationName:GO_HOME object:nil];
}


-(void)SendMsg:(NSString *)input
{
    Comment *comment = [[Comment alloc]init];
    comment.comment = input;
    NSDate *date = [NSDate date];
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc]init];
    [dateformatter setDateFormat:@"HH:mm"];
    
    comment.dateString = [dateformatter stringFromDate:date];

    [self.dataArray addObject:comment];
    [self.commentTable reloadData];
}

-(void)writeComment
{
    
    YQWriteComment *writeComment = [self.storyboard instantiateViewControllerWithIdentifier:@"YQWriteComment"];
    writeComment.delegate = self;
    
    [self.navigationController pushViewController:writeComment animated:YES];
}
#pragma mark -UITableView delegate

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [[UIView alloc]init];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Comment * c = [self.dataArray objectAtIndex:[indexPath row]];
    
    
    NSString *text = c.comment;
    
    CGSize constraint = CGSizeMake(220, MAXFLOAT);
    
    CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
    
    CGFloat height = MAX(size.height, 44.0f);
    
    return height + 40;
 
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
 
    return self.dataArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"CommentCell";
    YQCommentCell *cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell) {
        
        Comment *comment = [self.dataArray objectAtIndex:indexPath.row];
        cell.commentLabel.text = comment.comment;
        [cell.commentLabel sizeToFit];
        cell.timeLabel.text = comment.dateString;
 
        cell.peopleImg.image = [UIImage imageNamed:@"people"];
    }
    //    if (!cell) {
    //
    //        cell = [[CommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellReuseIdentifier];
    //    }
    //    cell.timeLabel.text = @"2013-5-23";
    //    cell.peopleImg.image = [UIImage imageNamed:@"image-1"];
    //    cell.comment.text = [self.dataArray objectAtIndex:indexPath.row];
    

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];   

}

@end
