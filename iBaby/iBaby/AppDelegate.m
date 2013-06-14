//
//  AppDelegate.m
//  iBaby
//
//  Created by  jacob on 13-6-4.
//  Copyright (c) 2013年 Jacob QQ:110773265. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "SNSManager.h"
#import "LaunchViewController.h"
#import "UserGuideViewController.h"
#import "HttpEngine.h"
#import <QuartzCore/QuartzCore.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    LaunchViewController *launchVC=[[LaunchViewController alloc]init];
    [launchVC.view setFrame:self.window.frame];
    self.window.rootViewController=launchVC;
    [self toDoWhileSpalshing];
    [self.window makeKeyAndVisible];
    return YES;
}

-(void)toDoWhileSpalshing
{
    //执行后台做的事情，做完后弄死launching进下一级
    LoginViewController *loginVC=[[LoginViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginVC ];
    [self resetNavigationBarColor:nav];
    
    [loginVC.view setFrame:self.window.frame];
    self.window.rootViewController=nav;
    
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [[SNSManager sharedInstance].sinaweibo applicationDidBecomeActive];
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    if ([url.absoluteString hasPrefix:@"tencent"]) {
        return [[SNSManager sharedInstance].tencentOAuth handleOpenURL:url] ;
    }
    else if([url.absoluteString hasPrefix:@"weibo"])
    {
        return [[SNSManager sharedInstance].sinaweibo handleOpenURL:url];
    }
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    if ([url.absoluteString hasPrefix:@"tencent"]) {
        return [[SNSManager sharedInstance].tencentOAuth handleOpenURL:url] ;
    }
    else if([url.absoluteString hasPrefix:@"weibo"])
    {
        return [[SNSManager sharedInstance].sinaweibo handleOpenURL:url];
    }
}

#pragma mark - private methods
-(void)resetNavigationBarColor:(UINavigationController *)navigationController
{
    UIImage *image = [UIImage imageNamed:@"nav_bg"];
    Class ios5Class = (NSClassFromString(@"CIImage"));
    if (nil != ios5Class) {
        [navigationController.navigationBar setBackgroundImage:image forBarMetrics:0];
    }else{
        navigationController.navigationBar.layer.contents = (id)image.CGImage;
    }
}

@end
