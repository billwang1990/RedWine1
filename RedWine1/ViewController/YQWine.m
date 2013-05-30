//
//  YQWine.m
//  RedWine1
//
//  Created by niko on 13-5-28.
//  Copyright (c) 2013年 billwang. All rights reserved.
//

#import "YQWine.h"
#import "YQCell.h"
#import "GGFullScreenImageViewController.h"
#import "Head_file.h"

@interface YQWine ()

@end

@implementation YQWine

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
 
    
    [self.tableView addParallaxWithImage:[UIImage imageNamed:@"b1bc7.jpg"] andHeight:160];
    
//    self.tableView.separatorColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UIImage *topBg = [UIImage imageNamed:@"bg_nav"];
    [self.navigationController.navigationBar setBackgroundImage:topBg forBarMetrics:UIBarMetricsDefault];
    
    UIButton *leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(0,0,30,30)];
    [leftBtn setImage:[UIImage imageNamed:@"go-home.png"]forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(goHome)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    
    self.navigationItem.leftBarButtonItem= leftItem;
    
    
    UIButton *rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [rightBtn setImage:[UIImage imageNamed:@"prize"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(honour) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)honour
{
    [self performSegueWithIdentifier:@"pushHonour" sender:self];
    
}

-(void)goHome
{
    [[NSNotificationCenter defaultCenter]postNotificationName:GO_HOME object:nil];
}

 
#pragma mark - uitableview delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
 
    return 10;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
 
 
    NSString *cellReuseIdentifier  = @"YQCell";
    
    YQCell *cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:cellReuseIdentifier];
    
    if (cell) {
        cell.CenterImg.image = [UIImage imageNamed:@"b1bc7.jpg"];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapPic:)];
        [cell.CenterImg addGestureRecognizer:tap];
    }
    return cell;
 
}


-(void)tapPic:(UITapGestureRecognizer *)sender
{
    GGFullscreenImageViewController *vc = [[GGFullscreenImageViewController alloc]init];
 
    UIImageView * imageView = (UIImageView*)sender.view;
    
    vc.liftedImageView = imageView;
    [self presentViewController:vc animated:YES completion:nil];
    
}


@end
