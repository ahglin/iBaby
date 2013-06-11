//
//  HttpEngine.h
//  iBaby
//
//  Created by  jacob on 13-6-10.
//  Copyright (c) 2013年 Jacob QQ:110773265. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AFAppDotNetAPIClient.h"

@interface HttpEngine : NSObject

+(void)httpRequestWithPath:(NSString *)path
                parameters:(NSDictionary *)parameters
                httpMethod:(HttpMethod)httpMethod
                   success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                   failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;


@end
