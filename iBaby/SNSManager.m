//
//  SNSManager.m
//  iBaby
//
//  Created by jacob on 13-6-5.
//  Copyright (c) 2013年 Jacob QQ:110773265. All rights reserved.
//

#import "SNSManager.h"

static SNSManager *_snsManagerInstance=nil;

@implementation SNSManager

@synthesize sinaweibo=_sinaweibo;
@synthesize tencentOAuth=_tencentOAuth;
@synthesize delegate=_delegate;

+(SNSManager *)sharedInstance
{
    if (!_snsManagerInstance) {
        _snsManagerInstance=[[SNSManager alloc]init];
    }
    return _snsManagerInstance;
}

-(BOOL)checkAuthDataStatusWithType:(SNSTYPE)type
{
    switch (type) {
        case SNSTYPE_WEIBO:
        {
            
        }
            break;
        case SNSTYPE_QQ:
        {
            
        }
            break;
        case SNSTYPE_RENREN:
        {
            
        }
            break;
        default:
            break;
    }
}

-(void)initSNSWithType:(SNSTYPE)type
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    switch (type) {
        case SNSTYPE_WEIBO:
        {
            _sinaweibo=[[SinaWeibo alloc]initWithAppKey:kAppSinaKey appSecret:kAppSinaSecret appRedirectURI:kAppSinaRedirectURI andDelegate:self];
            NSDictionary *sinaweiboInfo = [defaults objectForKey:@"SinaWeiboAuthData"];
            if ([sinaweiboInfo objectForKey:@"AccessTokenKey"] && [sinaweiboInfo objectForKey:@"ExpirationDateKey"] && [sinaweiboInfo objectForKey:@"UserIDKey"])
            {
                _sinaweibo.accessToken = [sinaweiboInfo objectForKey:@"AccessTokenKey"];
                _sinaweibo.expirationDate = [sinaweiboInfo objectForKey:@"ExpirationDateKey"];
                _sinaweibo.userID = [sinaweiboInfo objectForKey:@"UserIDKey"];
            }
        }
            break;
        case SNSTYPE_QQ:
        {
            _permissions = [NSArray arrayWithObjects:
                             kOPEN_PERMISSION_GET_USER_INFO,
                             kOPEN_PERMISSION_GET_SIMPLE_USER_INFO,
                             kOPEN_PERMISSION_ADD_ALBUM,
                             kOPEN_PERMISSION_ADD_IDOL,
                             kOPEN_PERMISSION_ADD_ONE_BLOG,
                             kOPEN_PERMISSION_ADD_PIC_T,
                             kOPEN_PERMISSION_ADD_SHARE,
                             kOPEN_PERMISSION_ADD_TOPIC,
                             kOPEN_PERMISSION_CHECK_PAGE_FANS,
                             kOPEN_PERMISSION_DEL_IDOL,
                             kOPEN_PERMISSION_DEL_T,
                             kOPEN_PERMISSION_GET_FANSLIST,
                             kOPEN_PERMISSION_GET_IDOLLIST,
                             kOPEN_PERMISSION_GET_INFO,
                             kOPEN_PERMISSION_GET_OTHER_INFO,
                             kOPEN_PERMISSION_GET_REPOST_LIST,
                             kOPEN_PERMISSION_LIST_ALBUM,
                             kOPEN_PERMISSION_UPLOAD_PIC,
                             kOPEN_PERMISSION_GET_VIP_INFO,
                             kOPEN_PERMISSION_GET_VIP_RICH_INFO,
                             kOPEN_PERMISSION_GET_INTIMATE_FRIENDS_WEIBO,
                             kOPEN_PERMISSION_MATCH_NICK_TIPS_WEIBO,
                             nil];

            _tencentOAuth = [[TencentOAuth alloc] initWithAppId:kAppQQKey
                                                    andDelegate:self];
            _tencentOAuth.redirectURI=@"www.qq.com";
            
            NSDictionary *sinaweiboInfo = [defaults objectForKey:@"TencentAuthData"];
            if ([sinaweiboInfo objectForKey:@"AccessTokenKey"] && [sinaweiboInfo objectForKey:@"ExpirationDateKey"] && [sinaweiboInfo objectForKey:@"UserIDKey"])
            {
                _tencentOAuth.accessToken = [sinaweiboInfo objectForKey:@"AccessTokenKey"];
                _tencentOAuth.expirationDate = [sinaweiboInfo objectForKey:@"ExpirationDateKey"];
                _tencentOAuth.openId = [sinaweiboInfo objectForKey:@"UserIDKey"];
            }
        }
            break;
        case SNSTYPE_RENREN:
        {
            
        }
            break;
        default:
            break;
    }
}

- (void)removeAuthDataWithType:(SNSTYPE)type
{
    switch (type) {
        case SNSTYPE_WEIBO:
        {
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"SinaWeiboAuthData"];
        }
            break;
        case SNSTYPE_QQ:
        {
            
        }
            break;
        case SNSTYPE_RENREN:
        {
            
        }
            break;
        default:
            break;
    }
}

- (void)storeAuthDataWithType:(SNSTYPE)type
{
    switch (type) {
        case SNSTYPE_WEIBO:
        {
            NSDictionary *authData = [NSDictionary dictionaryWithObjectsAndKeys:
                                      _sinaweibo.accessToken, @"AccessTokenKey",
                                      _sinaweibo.expirationDate, @"ExpirationDateKey",
                                      _sinaweibo.userID, @"UserIDKey",
                                      _sinaweibo.refreshToken, @"refresh_token", nil];
            [[NSUserDefaults standardUserDefaults] setObject:authData forKey:@"SinaWeiboAuthData"];
        }
            break;
        case SNSTYPE_QQ:
        {
            NSDictionary *authData = [NSDictionary dictionaryWithObjectsAndKeys:
                                      _tencentOAuth.accessToken, @"AccessTokenKey",
                                      _tencentOAuth.expirationDate, @"ExpirationDateKey",
                                      _tencentOAuth.openId, @"UserIDKey", nil];
            [[NSUserDefaults standardUserDefaults] setObject:authData forKey:@"TencentAuthData"];
        }
            break;
        case SNSTYPE_RENREN:
        {
            
        }
            break;
        default:
            break;
    }
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    [_delegate checkingStatus];
}

-(void)loginWithType:(SNSTYPE)type
{
    switch (type) {
        case SNSTYPE_WEIBO:
        {
            [_sinaweibo logIn];
        }
            break;
        case SNSTYPE_QQ:
        {
            if ( _tencentOAuth.openId && _tencentOAuth.expirationDate &&_tencentOAuth.accessToken ) {
                NSDate *now = [NSDate date];
                if ([now compare:_tencentOAuth.expirationDate] == NSOrderedDescending) {
                    [_tencentOAuth authorize:_permissions inSafari:NO];
                    return;
                }
                else
                {
                    [self tencentDidLogin];
                }
            }
            else
                [_tencentOAuth authorize:_permissions inSafari:NO];
        }
            break;
        case SNSTYPE_RENREN:
        {
            
        }
            break;
        default:
            break;
    }
}

-(void)logoutWithType:(SNSTYPE)type
{
    switch (type) {
        case SNSTYPE_WEIBO:
        {
            [_sinaweibo logOut];
        }
            break;
        case SNSTYPE_QQ:
        {
            
        }
            break;
        case SNSTYPE_RENREN:
        {
            
        }
            break;
        default:
            break;
    }
}


#pragma mark - SinaWeibo Delegate

- (void)sinaweiboDidLogIn:(SinaWeibo *)sinaweibo
{
    NSLog(@"sinaweiboDidLogIn userID = %@ accesstoken = %@ expirationDate = %@ refresh_token = %@", sinaweibo.userID, sinaweibo.accessToken, sinaweibo.expirationDate,sinaweibo.refreshToken);
    
    [self storeAuthDataWithType:SNSTYPE_WEIBO];
}

- (void)sinaweiboDidLogOut:(SinaWeibo *)sinaweibo
{
    NSLog(@"sinaweiboDidLogOut");
    [self removeAuthDataWithType:SNSTYPE_WEIBO];
}

- (void)sinaweiboLogInDidCancel:(SinaWeibo *)sinaweibo
{
    NSLog(@"sinaweiboLogInDidCancel");
}

- (void)sinaweibo:(SinaWeibo *)sinaweibo logInDidFailWithError:(NSError *)error
{
    NSLog(@"sinaweibo logInDidFailWithError %@", error);
}

- (void)sinaweibo:(SinaWeibo *)sinaweibo accessTokenInvalidOrExpired:(NSError *)error
{
    NSLog(@"sinaweiboAccessTokenInvalidOrExpired %@", error);
    [self removeAuthDataWithType:SNSTYPE_WEIBO];
    [_sinaweibo logIn];
}

#pragma mark - SinaWeiboRequest Delegate

- (void)request:(SinaWeiboRequest *)request didFailWithError:(NSError *)error
{
    
}

- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result
{

}

#pragma mark - TencentSession Delegate
- (void)tencentDidLogin
{
    NSLog(@"tencentDidLogin");
    if (_tencentOAuth.accessToken
        && 0 != [_tencentOAuth.accessToken length])
    {
        [self storeAuthDataWithType:SNSTYPE_QQ];
    }
    else
    {
        NSLog(@"tencentDidLogin but length not enough");
    }
}

-(void)tencentDidNotLogin:(BOOL)cancelled
{
    if (cancelled) {
        NSLog(@"tencentDidNotLogin user canceled");
    }
    else
        NSLog(@"tencentDidNotLogin failed");
}

-(void)tencentDidNotNetWork
{
	 NSLog(@"tencentDidNotNetWork");
}

- (void)onReq:(QQBaseReq *)req
{
    switch (req.type)
    {
        case EGETMESSAGEFROMQQREQTYPE:
        {
            break;
        }
        default:
        {
            break;
        }
    }
}

- (void)onResp:(QQBaseResp *)resp
{
    switch (resp.type)
    {
        case ESENDMESSAGETOQQRESPTYPE:
        {
            break;
        }
        default:
        {
            break;
        }
    }
}

@end
