//
//  PUDefine.h
//  PUDemo
//
//  Created by JK.Peng on 13-2-22.
//  Copyright (c) 2013年 njut. All rights reserved.
//

#ifndef PUDemo_PUDefine_h
#define PUDemo_PUDefine_h


//安全释放
#define RELEASE_SAFELY(__POINTER) { [__POINTER release]; __POINTER = nil; }
#define INVALIDATE_TIMER(__TIMER) { [__TIMER invalidate];[__TIMER release]; __TIMER = nil; }

//图片资源获取
#define IMGFROMBUNDLE( X )	 [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:X ofType:@"" ]]
#define IMGNAMED( X )	     [UIImage imageNamed:X]

#ifdef DEBUG
#define DBLog(xx, ...)  NSLog(@"%s(%d): " xx, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define DBLog(xx, ...)  ((void)0)
#endif

#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
//定义字号
#define FONT_TITLE(X) [UIFont systemFontOfSize:X]


//解析字典
#define PUGetElemForKeyFromDict(__key, __dict)   [PUUtil getElementForKey:__key fromDict:__dict]
#define PUGetObjFromDict(__key, __dict, __class) [PUUtil getElementForKey:__key fromDict:__dict forClass:__class]
//add by zt 2013.5.28
#define PUGetObjFromDictWithCharaterSet(__key, __dict, __characterSet) \
        [PUUtil getElementForKey:__key fromDict:__dict character:__characterSet]


#define APP_NAME    [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]
#define APP_VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]
#define APP_DEV     @"iphone"


#endif
