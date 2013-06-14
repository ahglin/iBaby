//
//  LoginViewController.m
//  iBaby
//
//  Created by  jacob on 13-6-4.
//  Copyright (c) 2013年 Jacob QQ:110773265. All rights reserved.
//

#import "LoginViewController.h"

#define LOGINCELL_ICONIMG_TAG 1000
#define LOGINCELL_SLIDERVIEW_TAG 1001

#define COLOR_CELLVIEW [UIColor colorWithRed:56/255.0 green:161/255.0 blue:188/255.0 alpha:1.0]
#define COLOR_CELLTEXT [UIColor colorWithRed:116/255.0 green:202/255.0 blue:217/255.0 alpha:1.0]

@interface LoginViewController ()<UITableViewDataSource,UITableViewDelegate>{
    NSArray *_loginTypeNames; //第三方登录名称
    NSArray *_loginTypeIcons; //第三方登录图片
}

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
	// Do any additional setup after loading the view.
    _loginTypeNames = [NSArray arrayWithObjects:@"QQ帐号",@"微博帐号",@"网易帐号", nil];
    _loginTypeIcons = [NSArray arrayWithObjects:@"login_qq",@"login_sina",@"login_163", nil];
//    [self addCustomBackBarItem];
    
    UIImage *bgImg = [UIImage imageNamed:@"login_bg"];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:bgImg]];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f,
                                                                           91.0f,
                                                                           320.0f,
                                                                           CGRectGetHeight(self.view.frame)-91)
                                                          style:UITableViewStyleGrouped];
    [tableView setScrollEnabled:NO];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView setBackgroundColor:[UIColor clearColor]];
    UIView *tmp = [[UIView alloc] init];
    [tableView setBackgroundView:tmp];
    [self.view addSubview:tableView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private methods
- (void)addCustomBackBarItem
{
    UIButton *backBt = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBt setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
    [backBt setFrame:CGRectMake(0, 0, 60, 35)];
    [backBt addTarget:self action:@selector(popSelfViewControler) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backBarItem = [[UIBarButtonItem alloc] initWithCustomView:backBt] ;
    [self.navigationItem setLeftBarButtonItem:backBarItem];
}

- (void)popSelfViewControler
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_loginTypeNames count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"LoginCellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
		cell.backgroundColor = COLOR_CELLVIEW;
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIImageView *iconview = [[UIImageView alloc] initWithFrame:CGRectMake(30, 10, 35, 35)];
        [iconview setBackgroundColor:[UIColor clearColor]];
        [iconview setTag:LOGINCELL_ICONIMG_TAG];
        [cell addSubview:iconview];
        
        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 10, 200, 35)];
        [textLabel setBackgroundColor:[UIColor clearColor]];
        [textLabel setTextColor:COLOR_CELLTEXT];
        [textLabel setFont:[UIFont boldSystemFontOfSize:18]];
        [textLabel setTag:LOGINCELL_SLIDERVIEW_TAG];
        [cell addSubview:textLabel];
    }
    
    UIImageView *iconview = (UIImageView *)[cell viewWithTag:LOGINCELL_ICONIMG_TAG];
    [iconview setImage:[UIImage imageNamed:[_loginTypeIcons objectAtIndex:indexPath.row]]];
    UILabel *textLabel = (UILabel *)[cell viewWithTag:LOGINCELL_SLIDERVIEW_TAG];
    [textLabel setText:[NSString stringWithFormat:@"使用 %@ 登录",[_loginTypeNames objectAtIndex:indexPath.row]]];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

	return 55.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
