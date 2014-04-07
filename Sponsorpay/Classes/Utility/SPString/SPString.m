// Header
#import "SPString.h"

// Apple
#import <CommonCrypto/CommonDigest.h>

@implementation SPString

# pragma mark - SHA1 encoding

+ (NSString *)sha1:(NSString *)string
{
  // Invalid str
  SPErrorAssertTrueThrowAndReturnNil([string length], SPErrorInvalidZeroLengthValue);
  
  // Convert string to NSData
  NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
  SPErrorAssertTrueThrowAndReturnNil(data, SPErrorMissingExpectedValue);
  
  // Convert data to SHA1
  unsigned char res[CC_SHA1_DIGEST_LENGTH];
  CC_SHA1([data bytes], (CC_LONG)[data length], res);
  
  // Get hash of SHA1 digest
  NSMutableString *hash = [[NSMutableString alloc] init];
  for (int i = 0; i < CC_SHA1_DIGEST_LENGTH; ++i) {
    [hash appendFormat:@"%02x", res[i]];
  }
  // Check validity of generated SHA1 hash
  BOOL isValid = YES;
  for (int c = 0; c < [hash length]; ++c) {
    if (![hash characterAtIndex:c]) {
      isValid = NO;
      continue;
    }
  }
  SPErrorAssertTrueThrowAndReturnNil(isValid, SPErrorMissingExpectedValue);
  
  // Return immutable copy
  return [hash copy];
}

@end
