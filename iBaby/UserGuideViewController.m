//
//  UserGuideViewController.m
//  iBaby
//
//  Created by jacob on 13-6-6.
//  Copyright (c) 2013年 Jacob QQ:110773265. All rights reserved.
//

#import "UserGuideViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface UserGuideViewController ()
{

}

@property (nonatomic, strong) UIImageView     *bgImageView;
@property (nonatomic, strong) NSMutableArray  *imageArray;
@property (nonatomic) NSInteger       index;

@end

@implementation UserGuideViewController

@synthesize bgImageView=_bgImageView;
@synthesize imageArray=_imageArray;
@synthesize index=_index;

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
    [self.view addSubview:self.bgImageView];
    self.bgImageView.center = CGPointMake(self.view.center.x, self.view.center.y-20);
    
    self.index = 1;
    UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                                       action:@selector(handleGesture:)];
    swipeGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeGesture];

    
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                                action:@selector(handleGesture:)];
    swipe.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipe];


}

- (void)handleGesture:(UISwipeGestureRecognizer *)recognizer{
    
    NSString *subtype = nil;
    
    if (recognizer.direction == UISwipeGestureRecognizerDirectionLeft) {
        if (self.index == [self.imageArray count]) {
            DBLog(@"看完介绍图进入下一级页面");
            return;
        }
        
        self.index ++;
        subtype = kCATransitionFromRight;
    }else if(recognizer.direction == UISwipeGestureRecognizerDirectionRight) {
        if (self.index == 1)
            return;
        
        self.index --;
        subtype = kCATransitionFromLeft;
    }
    
    NSString  *url = [self.imageArray objectAtIndex:self.index-1];
    self.bgImageView.image = IMGFROMBUNDLE(url);
    
    CATransition *animation = [CATransition animation];
    animation.duration = 0.5f;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = YES;
    animation.type = kCATransitionPush;
    animation.subtype = subtype;
    animation.delegate = self;
    [animation setValue:@"moveAnim" forKey:@"moveAnim"];
    [self.bgImageView.layer addAnimation:animation forKey:@"animation"];
    
}

#pragma mark - getter
- (NSMutableArray *)imageArray{
    if (!_imageArray) {
        _imageArray = [[NSMutableArray alloc] initWithObjects:@"bg_help_01.png",
                       @"bg_help_02.png",
                       @"bg_help_03.png",
                       @"bg_help_04.png",
                       @"bg_help_05.png", nil];
    }
    return _imageArray;
}

- (UIImageView *)bgImageView{
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc] initWithFrame:self.view.frame];
        _bgImageView.backgroundColor = [UIColor clearColor];
        _bgImageView.image = IMGFROMBUNDLE(@"bg_help_01.png");
        _bgImageView.userInteractionEnabled = YES;
    }
    return _bgImageView;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
