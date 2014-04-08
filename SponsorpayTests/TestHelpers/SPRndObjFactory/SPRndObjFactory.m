// Header
#import "SPRndObjFactory.h"

@implementation SPRndObjFactory

# pragma mark - Object generators (Public)

+ (NSInteger)rndNSInt
{
  return (NSInteger)floor(arc4random_uniform([[self class] SP_UInt32Max]));
}

+ (NSUInteger)rndNSUInt
{
  return (NSUInteger)floor(arc4random_uniform([[self class] SP_UInt32Max]));
}

+ (NSUInteger)rndNSUInt:(NSUInteger)max
{
  return (NSUInteger)floor(arc4random_uniform([@(max) unsignedIntValue]));
}

+ (NSUInteger)rndNSUInt:(NSUInteger)min :(NSUInteger)max
{
  return
  (NSUInteger)floor(arc4random_uniform([@(max) unsignedIntValue]+1-[@(min) unsignedIntValue])+[@(min) unsignedIntValue]);
}

+ (NSNumber *)rndBool
{
  return [NSNumber numberWithBool:((BOOL)floor(arc4random_uniform(1)))];
}

+ (NSNumber *)rndNumberUInt
{
  u_int32_t max = floor(arc4random_uniform([[self class] SP_UInt32Max]));
  return [NSNumber numberWithUnsignedInteger:max];
}

+ (NSNumber *)rndNumberUIntMax:(NSUInteger)max
{
  return [NSNumber numberWithUnsignedInteger:
          (floor(arc4random_uniform([@(max) unsignedIntValue])))];
}

+ (NSNumber *)rndNumberUInt:(NSUInteger)min :(NSUInteger)max
{
  return @([[self class] rndNSUInt:min :max]);
}

+ (NSNumber *)rndNumberDouble
{
  return [NSNumber numberWithDouble:[[self class] SP_rndDouble]];
}

+ (NSString *)rndStr
{
  NSString *uuid = [[NSUUID UUID] UUIDString];
  return [uuid stringByReplacingOccurrencesOfString:@"-" withString:@""];
}

+ (NSURL *)rndURL
{
  NSString *str = [[self class] rndStr];
  return [NSURL URLWithString:[NSString stringWithFormat:@"http://%@", str]];
}

+ (NSString *)rndPath
{
  NSString *str = [[self class] rndStr];
  return [NSString stringWithFormat:@"/%@", str];
}

+ (NSDate *)rndDate
{
  return [NSDate dateWithTimeIntervalSince1970:[[self class] SP_rndDouble]];
}

+ (NSData *)rndData
{
  NSString *str = [[self class] rndStr];
  return [str dataUsingEncoding:NSUTF8StringEncoding];
}

+ (NSDictionary *)rndDict
{
  return @{[[self class] rndStr]: [[self class] rndBool],
           [[self class] rndStr]: [[self class] rndNumberUInt],
           [[self class] rndStr]: [NSDecimalNumber notANumber],
           [[self class] rndStr]: [[self class] rndNumberDouble],
           [[self class] rndStr]: [[self class] rndStr],
           [[self class] rndStr]: [[self class] rndDate],
           [[self class] rndStr]: [[self class] rndData],
           [[self class] rndStr]: @[
               [[self class] rndBool],
               [[self class] rndNumberUInt],
               [[self class] rndStr],
               [[self class] rndDate],
               [[self class] rndData]],
           [[self class] rndStr]: @[
               [[self class] rndBool],
               [[self class] rndNumberUInt],
               [[self class] rndStr],
               [[self class] rndDate],
               [[self class] rndData]]};
}

+ (NSDictionary *)rndDictSmall
{
  return @{[[self class] rndStr]: [[self class] rndStr],
           [[self class] rndStr]: [[self class] rndNumberUInt]};
}

+ (NSArray *)rndArray
{
  return @[[[self class] rndBool],
           [[self class] rndNumberUInt],
           [NSDecimalNumber notANumber],
           [[self class] rndNumberDouble],
           [[self class] rndStr],
           [[self class] rndURL],
           [[self class] rndDate],
           [[self class] rndData],
           @[[[self class] rndBool],
             [[self class] rndNumberUInt],
             [[self class] rndStr],
             [[self class] rndURL],
             [[self class] rndDate],
             [[self class] rndData]],
           @{[[self class] rndStr]: [[self class] rndBool],
             [[self class] rndStr]: [[self class] rndNumberUInt],
             [[self class] rndStr]: [[self class] rndStr],
             [[self class] rndStr]: [[self class] rndURL],
             [[self class] rndStr]: [[self class] rndDate],
             [[self class] rndStr]: [[self class] rndData],
             [[self class] rndStr]: @[
                 [[self class] rndBool],
                 [[self class] rndNumberUInt],
                 [[self class] rndStr],
                 [[self class] rndURL],
                 [[self class] rndDate],
                 [[self class] rndData]]
             }];
}

# pragma mark - Private helpers

+ (u_int32_t)SP_UInt32Max
{
  return 4294967295;
}

# pragma mark - Object generators (Private)

+ (double)SP_rndDouble
{
  return floorf((double)arc4random_uniform(DBL_MAX) * 100.0);
}

@end