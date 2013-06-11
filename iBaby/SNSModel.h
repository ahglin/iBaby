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

@property (nonatomic) SNSTYPE type;
@property (nonatomic,strong) NSString *idNumber;

@end
