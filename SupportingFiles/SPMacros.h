#import "SPError.h"

#pragma mark - Error (Logging)

// SPErrorDomain
#define SPErrorDomain() @"com.sponsorpay.sdk"

// SPErrorDict
#define SPErrorDict(obj) \
  [NSMutableDictionary dictionaryWithObjectsAndKeys: \
  [NSString stringWithCString:__FILE__ encoding:NSUTF8StringEncoding], @"file", \
  [NSString stringWithFormat:@"%i", __LINE__], @"line", \
  [NSString stringWithCString:__PRETTY_FUNCTION__ encoding:NSUTF8StringEncoding], @"function", \
  [NSString stringWithCString:#obj encoding:NSUTF8StringEncoding], @"obj", nil]

#pragma mark - Error (Exceptions)

// SPErrorAssertTrueThrowAndReturn
#define SPErrorAssertTrueThrowAndReturn(obj, code) \
  do{ \
    if (!obj) { \
      [[SPError errorWithCode:code info: SPErrorDict(obj)] throw]; \
      return; \
    } \
  }while(0)

// SPErrorAssertTrueThrowAndReturnNil
#define SPErrorAssertTrueThrowAndReturnNil(obj, code) \
  do{ \
    if (!obj) { \
      [[SPError errorWithCode:code info: SPErrorDict(obj)] throw]; \
      return nil; \
    } \
  }while(0)

# pragma mark - Error (Exceptions)

// SPErrorThrow
#define SPErrorThrow(code, _) [[SPError errorWithCode:code info:_] throw];

// SPInvalidInitializer
#define SPInvalidInitializer \
  SPErrorThrow(SPErrorInvalidInitializer, nil); \
  self = [super init]; \
  return nil;