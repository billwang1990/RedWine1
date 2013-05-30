//
//  YQViewController.m
//  RedWine1
//
//  Created by niko on 13-5-26.
//  Copyright (c) 2013年 billwang. All rights reserved.
//

#import "YQViewController.h"
#import "YQSlideViewController.h"
#import "YQWineCommentViewController.h"
#import <ZBarReaderViewController.h>
#import <ZBarImageScanner.h>

@interface YQViewController ()<ZBarReaderDelegate>

@property (nonatomic) ZBarReaderViewController *reader;
@end

@implementation YQViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
//    [self.ScanBtn setBackgroundImage:[UIImage imageNamed:@"camera_button_take.png"] forState:UIControlStateNormal];
//    [self.ScanBtn setBackgroundImage:[UIImage imageNamed:@"tabBar_cameraButton_ready_matte.png"] forState:UIControlStateHighlighted];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
 
- (IBAction)ScanClick:(id)sender {
    
//    [self scanBar];
    [self scanSuccess];
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskPortraitUpsideDown;
}

#pragma mark Abour ZBar

- (void)scanSuccess
{
    
    UINavigationController *firstNav = [self.storyboard instantiateViewControllerWithIdentifier:@"firstNav"];
//
    UINavigationController *secondNav = [self.storyboard instantiateViewControllerWithIdentifier:@"secondNav"];
    
    NSMutableArray *viewControllers = [NSMutableArray arrayWithObjects: firstNav, secondNav,nil];
    
    YQSlideViewController  *vsiewController = [[YQSlideViewController alloc] init];
    vsiewController.viewControllers = viewControllers;
    [self presentViewController:vsiewController animated:YES completion:nil];
    
}


-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    id<NSFastEnumeration> results =
    [info objectForKey: ZBarReaderControllerResults];
    
    //UIImage *image = [info objectForKey: UIImagePickerControllerOriginalImage];
    
    ZBarSymbol *symbol = nil;
    for(symbol in results)
        break;
    NSLog(@"扫描信息%@",symbol.data);
    
    
    [self.reader dismissViewControllerAnimated:YES completion:^{
        
        [self scanSuccess];
    }];
}

-(void)dismissOverlayView
{
    
    [self.reader dismissViewControllerAnimated:YES completion:nil];
}

- (void)scanBar
{
    self.reader = [[ZBarReaderViewController alloc]init];
    self.reader.readerDelegate = self;
    
    //非全屏
    self.reader.wantsFullScreenLayout = NO;
    
    //隐藏底部控制按钮
    self.reader.showsZBarControls = NO;
    
    [self setOverlayPickerView:self.reader];
    
    [self.reader.scanner setSymbology: ZBAR_I25
                               config: ZBAR_CFG_ENABLE
                                   to: 0];
    
    [self presentViewController:self.reader animated:YES completion:nil];
     
}


//自定义扫描界面
- (void)setOverlayPickerView:(ZBarReaderViewController *)reader
{
    //清除原有控件
    for (UIView *temp in [reader.view subviews]) {
        for (UIButton *button in [temp subviews]) {
            if ([button isKindOfClass:[UIButton class]]) {
                [button removeFromSuperview];
            }
        }
        for (UIToolbar *toolbar in [temp subviews]) {
            if ([toolbar isKindOfClass:[UIToolbar class]]) {
                [toolbar setHidden:YES];
                [toolbar removeFromSuperview];
            }
        }
    }
    /*
     //画中间的基准线
     UIView* line = [[UIView alloc] initWithFrame:CGRectMake(40, 220, 240, 1)];
     line.backgroundColor = [UIColor blueColor];
     [reader.view addSubview:line];
     */
    //最上部view
    UIView* upView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 80)];
    upView.alpha = 0.3;
    upView.backgroundColor = [UIColor blackColor];
    
    [reader.view addSubview:upView];
    
    //用于说明的label
    UILabel * labIntroudction= [[UILabel alloc] init];
    labIntroudction.backgroundColor = [UIColor clearColor];
    labIntroudction.frame=CGRectMake(15, 20, 290, 50);
    labIntroudction.numberOfLines=2;
    labIntroudction.textColor=[UIColor whiteColor];
    labIntroudction.text=@"置二维码图像于矩形方框内，系统会自动识别，轻触可对焦";
    [upView addSubview:labIntroudction];
    
    
    //左侧的view
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 80, 20, 280)];
    leftView.alpha = 0.3;
    leftView.backgroundColor = [UIColor blackColor];
    [reader.view addSubview:leftView];
    
    //右侧的view
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(300, 80, 20, 280)];
    rightView.alpha = 0.3;
    rightView.backgroundColor = [UIColor blackColor];
    [reader.view addSubview:rightView];
    
    
    //底部view
    UIView * downView = [[UIView alloc] initWithFrame:CGRectMake(0, 360, 320, self.view.frame.size.height - 360)];
    downView.alpha = 0.3;
    downView.backgroundColor = [UIColor blackColor];
    [reader.view addSubview:downView];
    
    //用于取消操作的button
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    cancelButton.alpha = 0.4;
    [cancelButton setFrame:CGRectMake(20, 390, 280, 40)];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton.titleLabel setFont:[UIFont boldSystemFontOfSize:20]];
    [cancelButton addTarget:self action:@selector(dismissOverlayView)forControlEvents:UIControlEventTouchUpInside];
    
    [reader.view addSubview:cancelButton];
}

@end
