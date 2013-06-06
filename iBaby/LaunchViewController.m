//
//  LaunchViewController.m
//  iBaby
//
//  Created by  jacob on 13-6-4.
//  Copyright (c) 2013年 Jacob QQ:110773265. All rights reserved.
//

#import "LaunchViewController.h"

@interface LaunchViewController ()

@property (nonatomic, strong) UIImageView     *splashImageView;

@end

@implementation LaunchViewController

@synthesize splashImageView=_splashImageView;

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
    [self.view addSubview:self.bgImageView];
    self.bgImageView.center = CGPointMake(self.view.center.x, self.view.center.y);
	// Do any additional setup after loading the view.
}

- (UIImageView *)bgImageView{
    if (!_splashImageView) {
        
        //先检测doc目录是否有更新的loading画面，这里注意，统一命名，动态下载不同的屏幕的尺寸，但是命名是一样的
        NSString *docPath = NSHomeDirectory();
        NSString *docFilePath=[docPath stringByAppendingFormat:@"loading.png"];
        
        NSString *filePath;
        if ([[NSFileManager defaultManager]fileExistsAtPath:docFilePath]) {
            filePath=docFilePath;
        }
        else
        {
            //本地没有，就加载程序内置的，判定下尺寸
            if (iPhone5) {
                filePath=[[NSBundle mainBundle]pathForResource:@"loading-568h@2x" ofType:@"png"];
            }
            else
            filePath=[[NSBundle mainBundle]pathForResource:@"loading" ofType:@"png"];
        }
        DBLog(@"launching image path is %@",filePath);
        
        _splashImageView = [[UIImageView alloc] initWithFrame:self.view.frame];
        _splashImageView.backgroundColor = [UIColor clearColor];
        _splashImageView.image = [UIImage imageWithContentsOfFile:filePath];
        _splashImageView.userInteractionEnabled = YES;
    }
    return _splashImageView;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
