// Header
#import "SPEnvPhoneInfo.h"

// Apple
#import <AdSupport/AdSupport.h>

@implementation SPEnvPhoneInfo

+ (NSString *)idfa
{
  // Get ASIManager
  ASIdentifierManager *manager = [ASIdentifierManager sharedManager];
  SPErrorAssertTrueThrowAndReturnNil(manager, SPErrorMissingExpectedValue);
  
  // Fetch and reformat advertising identifier
  NSUUID *rawIDFA = [manager advertisingIdentifier];
  SPErrorAssertTrueThrowAndReturnNil(rawIDFA, SPErrorMissingExpectedValue);
  NSString *rawIDFAStr = [rawIDFA UUIDString];
  SPErrorAssertTrueThrowAndReturnNil(rawIDFAStr, SPErrorMissingExpectedValue);
  NSString *idfa = [rawIDFAStr stringByReplacingOccurrencesOfString:@"-" withString:@""];
  SPErrorAssertTrueThrowAndReturnNil(idfa, SPErrorMissingExpectedValue);
  NSString *idfaLowercaseString = [idfa lowercaseString];
  SPErrorAssertTrueThrowAndReturnNil(idfaLowercaseString, SPErrorMissingExpectedValue);
  
  return idfaLowercaseString;
}

+ (NSString *)locale
{
  // Get current locale
  NSLocale *locale = [NSLocale currentLocale];
  SPErrorAssertTrueThrowAndReturnNil(locale, SPErrorMissingExpectedValue);
  
  // Get language code
  NSString *language = [locale objectForKey:NSLocaleLanguageCode];
  SPErrorAssertTrueThrowAndReturnNil(language, SPErrorMissingExpectedValue);
  
  // Get country code
  NSString *country = [locale objectForKey:NSLocaleCountryCode];
  SPErrorAssertTrueThrowAndReturnNil(country, SPErrorMissingExpectedValue);
  
  // Build locale identifier string
  NSString *code = [NSString stringWithFormat:@"%@-%@", language, country];
  SPErrorAssertTrueThrowAndReturnNil(code, SPErrorMissingExpectedValue);
  
  return code;
}

+ (NSString *)systemVersion
{
  return @"7.0";
}

@end
