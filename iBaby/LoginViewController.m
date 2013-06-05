//
//  LoginViewController.m
//  iBaby
//
//  Created by  jacob on 13-6-4.
//  Copyright (c) 2013年 Jacob QQ:110773265. All rights reserved.
//

#import "LoginViewController.h"
#import "SNSManager.h"
@interface LoginViewController ()

@end

@implementation LoginViewController

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
    self.view.backgroundColor=[UIColor whiteColor];
    UIButton *test=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    test.titleLabel.text=@"tes";
    [test addTarget:self action:@selector(test) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:test];
	// Do any additional setup after loading the view.
}

-(void)test
{
    [[SNSManager sharedInstance]loginWithType:SNSTYPE_QQ];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
