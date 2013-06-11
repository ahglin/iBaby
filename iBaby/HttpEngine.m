//
//  HttpEngine.m
//  iBaby
//
//  Created by  jacob on 13-6-10.
//  Copyright (c) 2013年 Jacob QQ:110773265. All rights reserved.
//

#import "HttpEngine.h"

@implementation HttpEngine

+(void)httpRequestWithPath:(NSString *)path
                parameters:(NSDictionary *)parameters
                httpMethod:(HttpMethod)httpMethod
                   success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                   failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    if (httpMethod==HttpMethodPost) {
        [[AFAppDotNetAPIClient sharedClient]postPath:path parameters:parameters
        success:^(AFHTTPRequestOperation *operation, id JSON)
        {
             NSLog(@"add globel staff");
             success(operation,JSON);
         }
        failure:^(AFHTTPRequestOperation *operation, NSError *error)
         {
             NSLog(@"failed");
             failure(operation,error);
         }];
    }
    else if (httpMethod==HttpMethodGet)
    {
        [[AFAppDotNetAPIClient sharedClient]getPath:path parameters:parameters
         success:^(AFHTTPRequestOperation *operation, id JSON)
         {
             NSLog(@"add globel staff");
             success(operation,JSON);
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error)
         {
             NSLog(@"failed");
             failure(operation,error);
         }];
    }
}

@end
