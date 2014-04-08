// Header
#import "SPSwizzelingController.h"

// Apple
#import <objc/message.h>

SPMethodSwizzleRevertBlock
  SPSwizzleMethodWithBlock(Class class, SEL selector, BOOL isClassMethod, id block)
{
  Method method = nil;
  if (isClassMethod) {
    method = class_getClassMethod(class, selector);
  } else {
    method = class_getInstanceMethod(class, selector);
  }
  IMP origImp = method_getImplementation(method);
  IMP testImp = imp_implementationWithBlock(block);
  method_setImplementation(method, testImp);
  return ^{ method_setImplementation(method, origImp); };
};

@implementation SPSwizzelingController

@end
