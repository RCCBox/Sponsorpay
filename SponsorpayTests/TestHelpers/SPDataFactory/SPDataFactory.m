// Header
#import "SPDataFactory.h"

@implementation SPDataFactory

+ (NSString *)offersJSON
{
  NSString *path = [[NSBundle bundleForClass:[self class]] resourcePath];
  path = [path stringByAppendingPathComponent:@"offersAPIResponseJSON.txt"];
  NSString *json = [NSString stringWithContentsOfFile:path
                                             encoding:NSUTF8StringEncoding
                                                error:NULL];
  return json;
}

+ (NSData *)offersData
{
  NSString *jsonString = [[self class] offersJSON];
  NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
  return jsonData;
}

@end
