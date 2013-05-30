//
//  YQHonour.m
//  RedWine1
//
//  Created by niko on 13-5-27.
//  Copyright (c) 2013年 billwang. All rights reserved.
//

#import "YQHonour.h"


@interface YQHonour ()

@property (nonatomic) NSMutableArray *photos;
-(void)setup;
@end

@implementation YQHonour

#pragma mark -
#pragma mark Getters


-(NSString*)photosDirectory
{
    return [[[NSBundle mainBundle] resourcePath]stringByAppendingPathComponent:@"resource"];
}

-(NSArray *)photos {
    if(!_photos) {
        _photos = [[NSMutableArray alloc]init];
        
        NSArray *photoarray = [[NSFileManager defaultManager]contentsOfDirectoryAtPath:[self photosDirectory] error:nil];
        
        [photoarray enumerateObjectsUsingBlock:^(id obj, NSUInteger index, BOOL *stop)
         {
             NSString *path = [[self photosDirectory]stringByAppendingPathComponent:obj];
             UIImage *image = [UIImage imageWithContentsOfFile:path];
             [_photos addObject:image];
             
         }];
        
    }
    return _photos;
}

-(PhotoStackView *)photoStack {
    if(!_photoStack) {
        _photoStack = [[PhotoStackView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
        _photoStack.center = CGPointMake(self.view.center.x, 170);
        _photoStack.dataSource = self;
        _photoStack.delegate = self;
    }
    
    return _photoStack;
}

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
    // Do any additional setup after loading the view from its nib.
 
    self.title = @"荣誉";
 
//    [self setup];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Deck DataSource Protocol Methods

-(NSUInteger)numberOfPhotosInPhotoStackView:(PhotoStackView *)photoStack {
    return [self.photos count];
}

-(UIImage *)photoStackView:(PhotoStackView *)photoStack photoForIndex:(NSUInteger)index {
    return [self.photos objectAtIndex:index];
}

#pragma mark -
#pragma mark Deck Delegate Protocol Methods

-(void)photoStackView:(PhotoStackView *)photoStackView willStartMovingPhotoAtIndex:(NSUInteger)index {
    // User started moving a photo
}

-(void)photoStackView:(PhotoStackView *)photoStackView willFlickAwayPhotoAtIndex:(NSUInteger)index {
    // User flicked the photo away, revealing the next one in the stack
}

-(void)photoStackView:(PhotoStackView *)photoStackView didRevealPhotoAtIndex:(NSUInteger)index {
    self.pageControl.currentPage = index;
}

-(void)photoStackView:(PhotoStackView *)photoStackView didSelectPhotoAtIndex:(NSUInteger)index {
    NSLog(@"selected %d", index);
}


#pragma mark -
#pragma mark Setup

-(void)setup {
    [self.view addSubview:self.photoStack];
    self.pageControl.numberOfPages = [self.photos count];
}
- (void)viewDidUnload {
    [self setPageControl:nil];
    [super viewDidUnload];
}


- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait|UIInterfaceOrientationMaskPortraitUpsideDown;
}


@end
