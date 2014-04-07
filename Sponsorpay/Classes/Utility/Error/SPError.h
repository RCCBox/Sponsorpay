// Apple
#import <Foundation/Foundation.h>

@interface SPError : NSError

# pragma mark - Constants

// Error codes
// Each code equates the error names hash value clipped to 8 devimal places

typedef NS_ENUM(NSInteger, SPErrorCode) {
  
  // Unknown
  SPErrorUnknown                   = 0,
  
  // Initialization
  SPErrorInvalidInitializer        = 13798704,
  SPErrorInvalidClass              = 21322901,
  // Method arguments
  SPErrorMissingArgument           = 27631290,
  SPErrorInvalidArgument           = 25576245,
  // Expressions
  SPErrorFailedExpectedExpression  = 38898289,
  SPErrorMissingExpectedValue      = 12074001,
  // Values
  SPErrorInvalidZeroLengthValue    = 13471225,
  SPErrorInvalidValue              = 36351788,
  // Selectors
  SPErrorMissingSelector           = 21252041,
  // Exceptions
  SPErrorExceptionRaised           = 42671139,
  // Remote connections
  SPErrorBadRequest                = 40818449,
  SPErrorServerError               = 72238803,
  SPErrorConnection                = 89578465,
  // Serialization
  SPErrorSerializationFailed       = 40443032,
  SPErrorStringSerializationFailed = 58135647,
  SPErrorNumberSerializationFailed = 11182126
};

# pragma mark - Initialization

+ (instancetype)errorWithCode:(SPErrorCode)code info:(NSDictionary *)info;

# pragma mark - Utility

- (void)throw;

@end
