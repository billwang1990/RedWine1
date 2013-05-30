//
//  YQSlideViewController.m
//  RedWine
//
//  Created by niko on 13-5-24.
//  Copyright (c) 2013年 billwang. All rights reserved.
//

#import "YQSlideViewController.h"
#import "YQSlideViewController.h"
#import "Head_file.h"
#import <QuartzCore/QuartzCore.h>
#import <objc/runtime.h>

@interface YQSlideViewController ()
{
    UIScrollView *viewContainer;
}

@property (nonatomic) UIButton *menuBtn;

@end

@implementation YQSlideViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (id)init{
    self = [super init];
    if (self) {
        _selectedIndex = 0;
        _scaleFactor = 0.8;
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    [self setupViews];
    [self setupViewControllers];
 
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(dismiss) name:GO_HOME object:nil];
}

- (void)dismiss
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//添加scrollview
-(void) setupViews
{
    viewContainer = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    viewContainer.delegate = self;
    viewContainer.showsHorizontalScrollIndicator = NO;
    viewContainer.pagingEnabled = YES;
    [viewContainer setAutoresizingMask:(UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth)];
    [self.view addSubview:viewContainer];
    
//    
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    UIImage *image = [UIImage imageNamed:@"go-home.png"];
//    button.frame = CGRectMake((self.view.bounds.size.width-48)/2,self.view.frame.size.height - 45, 48,48);
//    [button setBackgroundImage:image forState:UIControlStateNormal];
//    [button addTarget:self action:@selector(backHome:) forControlEvents:UIControlEventTouchDown];
//    button.tag = 111;
//    [self.view addSubview:button];
    
}


-(void)backHome:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)setupViewControllers
{
	NSUInteger i = 0;
	for (UIViewController *viewController in self.viewControllers) {
		[self addViewController:viewController atIndex:i];
		i++;
	}
}

- (void)setViewControllers:(NSMutableArray *)controllers
{
	for (UIViewController *viewController in _viewControllers)
	{
		[viewController.view removeFromSuperview];
	}
	
	_viewControllers = controllers;
	_selectedIndex = 0;
	
	
	if (self.isViewLoaded)
	{
		[self setupViewControllers];
	}
}

- (void)addViewController:(UIViewController *)viewController atIndex:(int)index;
{
	viewController.view.frame = CGRectMake(self.view.bounds.size.width * index, 0, self.view.frame.size.width, self.view.frame.size.height);
//	 viewController.view.backgroundColor = [UIColor colorWithWhite:(index + 1) * 0.2 alpha:1.0];
	[viewContainer addSubview:viewController.view];
	if ([viewController respondsToSelector:@selector(setSlideViewController:)]) {
		[viewController performSelector:@selector(setSlideViewController:) withObject:self];
	}
	
	UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(changeViewController:)];
	[swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
	[viewController.view addGestureRecognizer:swipeLeft];
	
	UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(changeViewController:)];
	[swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
	[viewController.view addGestureRecognizer:swipeRight];

}

- (void)changeViewController:(UISwipeGestureRecognizer *)gesture
{
	NSUInteger nextIndex = _selectedIndex;
	
	if (gesture.direction == UISwipeGestureRecognizerDirectionLeft)
		nextIndex++;
	else if (gesture.direction ==  UISwipeGestureRecognizerDirectionRight)
		nextIndex--;
	
	if (nextIndex >= _viewControllers.count || nextIndex == -1)
		return;
	
	[self slideToViewControllerAtIndex:nextIndex];
}

- (UIViewController *)viewControllerWithIndex:(NSUInteger)index
{
	UIViewController *viewController = nil;
	
	if (_viewControllers.count > index)
	{
		viewController = [_viewControllers objectAtIndex:index];
	}
	
	return viewController;
}


- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
	for (int i = 0; i < _viewControllers.count; i++)
	{
		UIViewController *viewController = [_viewControllers objectAtIndex:i];
		viewController.view.frame = CGRectMake(self.view.bounds.size.width * i,
                                               0,
                                               self.view.bounds.size.width,
                                               self.view.bounds.size.height);
		
		//Recalulate shadow
		viewController.view.layer.shadowPath = [UIBezierPath bezierPathWithRect:viewController.view.bounds].CGPath;
	}
	
	viewContainer.contentOffset = CGPointMake(_selectedIndex * self.view.bounds.size.width, viewContainer.contentOffset.y);
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

- (void)slideToViewControllerAtIndex:(NSUInteger)toIndex
{
	UIViewController *currentViewController = [self viewControllerWithIndex:_selectedIndex];
	UIViewController *nextViewController = [self viewControllerWithIndex:toIndex];
	
	if (nextViewController == nil)
		return;
	
	CGPoint toPoint = viewContainer.contentOffset;
	toPoint.x = toIndex * viewContainer.bounds.size.width;
	
	//Start positions
	nextViewController.view.transform = CGAffineTransformMakeScale(_scaleFactor, _scaleFactor);
	
	currentViewController.view.layer.masksToBounds = NO;
	currentViewController.view.layer.shadowRadius = 10;
	currentViewController.view.layer.shadowOpacity = 0.5;
	currentViewController.view.layer.shadowPath = [UIBezierPath bezierPathWithRect:currentViewController.view.bounds].CGPath;
	currentViewController.view.layer.shadowOffset = CGSizeMake(5.0, 5.0);
	
	[currentViewController viewWillDisappear:YES];
    
    [UIView animateWithDuration:0.5 animations:^{
        						 currentViewController.view.transform = CGAffineTransformMakeScale(_scaleFactor, _scaleFactor);
    }completion:^(BOOL completed){
        
        //Add shadow to next view controller
        nextViewController.view.layer.masksToBounds = NO;
        nextViewController.view.layer.shadowRadius = 10;
        nextViewController.view.layer.shadowOpacity = 0.5;
        nextViewController.view.layer.shadowPath = [UIBezierPath bezierPathWithRect:nextViewController.view.bounds].CGPath;
        nextViewController.view.layer.shadowOffset = CGSizeMake(5.0, 5.0);
        
        [nextViewController viewWillAppear:YES];
    }];
	
	//Slide animation
	[UIView animateWithDuration:0.5
					 animations:^{
						 [viewContainer setContentOffset:toPoint];
					 }
					 completion:^(BOOL completed){
						 
						 //remove current view controller
						 currentViewController.view.layer.masksToBounds = YES;
						 currentViewController.view.layer.shadowRadius = 10;
						 currentViewController.view.layer.shadowOpacity = 0.0;
						 currentViewController.view.layer.shadowPath = [UIBezierPath bezierPathWithRect:currentViewController.view.bounds].CGPath;
						 currentViewController.view.layer.shadowOffset = CGSizeMake(0.0, 0.0);
						 
						 [self calculateSelectedIndex];
						 
						 [currentViewController viewDidDisappear:YES];
					 }];
	
	//Zoom in animation
	[UIView animateWithDuration:0.5 animations:^{
						 nextViewController.view.transform = CGAffineTransformMakeScale(1.0, 1.0);
					 }
					 completion:^(BOOL completed){
						 currentViewController.view.transform = CGAffineTransformMakeScale(1.0, 1.0);
						 
						 //remove shadow next view controller
						 nextViewController.view.layer.masksToBounds = YES;
						 nextViewController.view.layer.shadowRadius = 0.0;
						 nextViewController.view.layer.shadowOpacity = 0.0;
						 nextViewController.view.layer.shadowPath = [UIBezierPath bezierPathWithRect:nextViewController.view.bounds].CGPath;
						 nextViewController.view.layer.shadowOffset = CGSizeMake(0.0, 0.0);
						 
						 [nextViewController viewDidAppear:YES];
					 }];
}
- (void)nextViewController
{
	[self slideToViewControllerAtIndex:_selectedIndex + 1];
}

- (void)prevViewController
{
	[self slideToViewControllerAtIndex:_selectedIndex - 1];
}

#pragma mark - UIScrollView Delegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
	[self calculateSelectedIndex];
}

- (void)calculateSelectedIndex
{
	_selectedIndex = floor((viewContainer.contentOffset.x - self.view.bounds.size.width / 2) / self.view.bounds.size.width) + 1;
}

@end

#pragma mark - UViewController+DVSlideViewController


@implementation UIViewController (YQSlideViewController)

NSString const * kSlideViewController = @"slideViewController";

- (YQSlideViewController *)slideViewController {
    return (YQSlideViewController *)objc_getAssociatedObject(self, (__bridge const void *)(kSlideViewController));
}

- (void)setSlideViewController:(YQSlideViewController *)slideViewController {
    objc_setAssociatedObject(self, (__bridge const void *)(kSlideViewController), slideViewController, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


@end
