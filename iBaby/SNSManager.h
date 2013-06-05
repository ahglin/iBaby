//
//  SNSManager.h
//  iBaby
//
//  Created by jacob on 13-6-5.
//  Copyright (c) 2013年 Jacob QQ:110773265. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import "SinaWeibo.h"

#define kAppSinaKey             @"2219428386"
#define kAppSinaSecret          @"7823d74dff7fcb1d3baf154ef7ad9b4e"
#define kAppSinaRedirectURI     @"http://www.sina.com"

#define kAppQQKey               @"100444509"
#define kAppQQSecret            @"c7b703b1ae58ef96ff73508b97132196"
#define kAppQQRedirectURI       @"http://www.qq.com"

typedef enum _SNSTYPE
{
    SNSTYPE_WEIBO = 0,
    SNSTYPE_QQ,
    SNSTYPE_RENREN,
}   SNSTYPE;

@protocol SNSManagerDelegate <NSObject>

@required
-(void)checkingStatus;//告诉uiviewcontroller已经登陆成功，可以去刷新检测状态，譬如sinaweibo isValidate  ; tencentOauth isSessionValid

@end

@interface SNSManager : NSObject <SinaWeiboDelegate,TencentSessionDelegate,QQApiInterfaceDelegate>
{
    SinaWeibo       *_sinaweibo;
    TencentOAuth    *_tencentOAuth;
    NSMutableArray  *_permissions;
    __weak id <SNSManagerDelegate> _delegate;
}

@property (weak ) id<SNSManagerDelegate>  delegate;
@property (readonly,nonatomic) SinaWeibo    *sinaweibo;
@property (readonly,nonatomic) TencentOAuth *tencentOAuth;

+(SNSManager *)sharedInstance;
-(void)initSNSWithType:(SNSTYPE)type;
-(void)loginWithType:(SNSTYPE)type;
-(void)logoutWithType:(SNSTYPE)type;

- (void)removeAuthDataWithType:(SNSTYPE)type;
- (void)storeAuthDataWithType:(SNSTYPE)type;
-(BOOL)checkAuthDataStatusWithType:(SNSTYPE)type;

@end
