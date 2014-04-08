// Header
#import "SPURL.h"

// Sponsorpay
// Utility:
#import "SPString.h"

@implementation SPURL

+ (NSURL *)signURL:(NSURL *)url
     withQueryDict:(NSDictionary *)dict
         andAPIKey:(NSString *)APIkey
{
  // Check arguments
  SPErrorAssertTrueThrowAndReturnNil(dict, SPErrorMissingExpectedValue);
  SPErrorAssertTrueThrowAndReturnNil(url, SPErrorMissingExpectedValue);
  
  // Sort dictionary keys
  NSArray *queryKeys = [dict allKeys];
  SPErrorAssertTrueThrowAndReturnNil(queryKeys, SPErrorMissingExpectedValue);
  SEL sel = @selector(localizedCaseInsensitiveCompare:);
  NSArray *sortedQueryKeys = [queryKeys sortedArrayUsingSelector:sel];
  SPErrorAssertTrueThrowAndReturnNil(sortedQueryKeys, SPErrorMissingExpectedValue);
  
  // Setup URL prefix
  NSMutableString *mURLString = [NSMutableString string];
  SPErrorAssertTrueThrowAndReturnNil(mURLString, SPErrorMissingExpectedValue);
  NSString *urlStr = [url absoluteString];
  SPErrorAssertTrueThrowAndReturnNil(urlStr, SPErrorMissingExpectedValue);
  [mURLString appendFormat:@"%@?", urlStr];
  
  // Setup query string
  BOOL isFirst = YES;
  NSMutableString *mQueryString = [NSMutableString string];
  for (NSString *key in sortedQueryKeys) {
    
    // Append query prefix
    if (isFirst) {
      isFirst = NO;
    } else {
      [mQueryString appendString:@"&"];
    }
    
    // Append key & value
    NSString *fragment = [NSString stringWithFormat:@"%@=%@", key, dict[key]];
    SPErrorAssertTrueThrowAndReturnNil(fragment, SPErrorMissingExpectedValue);
    [mQueryString appendString:fragment];
  }
  
  // Calculate quer hash
  NSString *hashURLString = [mQueryString stringByAppendingFormat:@"&%@", APIkey];
  NSString *hash = [SPString sha1:hashURLString];
  
  // Setup query URL
  [mURLString appendString:mQueryString];
  SPErrorAssertTrueThrowAndReturnNil(mURLString, SPErrorMissingExpectedValue);
  [mURLString appendFormat:@"&hashkey=%@", hash];
  NSURL *queryURL = [NSURL URLWithString:mURLString];
  SPErrorAssertTrueThrowAndReturnNil(queryURL, SPErrorMissingExpectedValue);
  
  // Return URL
  return queryURL;
}

+ (BOOL)isResponseDataValid:(NSData *)data
                  forAPIKey:(NSString *)apiKey
                    andHash:(NSString *)responseHash
{
  // Convert data to string
  NSString *string =
  [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
  SPErrorAssertTrueThrowAndReturnNo(string, SPErrorMissingExpectedValue);
  
  // Concatenate API key to response and hash result
  string = [string stringByAppendingString:apiKey];
  SPErrorAssertTrueThrowAndReturnNo(string, SPErrorMissingExpectedValue);
  NSString *hash = [SPString sha1:string];
  
  // Return result
  BOOL isEqual = [hash isEqualToString:responseHash];
  return isEqual;
}

@end
