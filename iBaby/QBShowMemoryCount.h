

#import <Foundation/Foundation.h>

@interface QBShowMemoryCount : NSObject

+(QBShowMemoryCount *)shareInstance;
+(void)clearInstance;
-(NSString*)reportMemory;
-(void)showMemory;
-(void)closeMemory;
-(void)refresh;
//断点，在这个地方断点打印出此处内存，后面写出添加得内存值
-(void)breakPoint:(NSString*)thisBreakPoint;
-(void)removeBreakPoint:(NSString*)thisBreakPoint;

@end
