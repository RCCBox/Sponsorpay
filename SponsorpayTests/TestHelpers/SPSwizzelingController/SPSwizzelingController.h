// Apple
#import <Foundation/Foundation.h>

// Framework classes
#import "SPError.h"

typedef void(^SPMethodSwizzleRevertBlock)();
SPMethodSwizzleRevertBlock
  SPSwizzleMethodWithBlock(Class class, SEL selector, BOOL isClassMethod, id block);

@interface SPSwizzelingController : NSObject

@end
