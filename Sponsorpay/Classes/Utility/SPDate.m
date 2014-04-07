// Header
#import "SPDate.h"

@implementation SPDate

+ (NSNumber *)timeIntervalSince1970;
{
  NSDate *date = [NSDate date];
  SPErrorAssertTrueThrowAndReturnNil(date, SPErrorMissingExpectedValue);
  NSTimeInterval interval = [date timeIntervalSince1970];
  NSNumber *intervalNumber = [NSNumber numberWithDouble:interval];
  SPErrorAssertTrueThrowAndReturnNil(intervalNumber, SPErrorMissingExpectedValue);
  NSUInteger intervalUInt = [intervalNumber unsignedIntegerValue];
  NSNumber *stamp = [NSNumber numberWithUnsignedInteger:intervalUInt];
  SPErrorAssertTrueThrowAndReturnNil(stamp, SPErrorMissingExpectedValue);
  return stamp;
}

@end
