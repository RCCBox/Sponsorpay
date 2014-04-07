// Header
#import "SPError.h"

@interface SPError ()

@property NSArray *stackTrace;

@end

@implementation SPError

# pragma mark - Initialization

- (instancetype)init
{
  SPInvalidInitializer;
}

+ (instancetype)errorWithCode:(SPErrorCode)code info:(NSDictionary *)info
{
  SPError *error = [super errorWithDomain:SPErrorDomain() code:code userInfo:info];
  error.stackTrace = [NSThread callStackSymbols];
  return error;
}

# pragma mark - Utility

- (void)throw
{
  // Log error
  [SPLog error:@"Sponsorpay crashed!"];
}

@end