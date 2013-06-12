//
//  SNSModel.h
//  iBaby
//
//  Created by  jacob on 13-6-8.
//  Copyright (c) 2013年 Jacob QQ:110773265. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef enum _SNSTYPE
{
    SNSTYPE_WEIBO = 0,
    SNSTYPE_QQ,
    SNSTYPE_RENREN,
}   SNSTYPE;


@interface SNSModel : NSObject

@property (nonatomic)         SNSTYPE type;
@property (nonatomic, strong) NSString *idNumber;
@property (nonatomic, strong) NSString * screen_name;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * province;
@property (nonatomic, strong) NSString * city;
@property (nonatomic, strong) NSString * location;
@property (nonatomic, strong) NSString * profile_image_url;
@property (nonatomic, strong) NSString * gender;
@property (nonatomic, strong) NSString * status;


@end
