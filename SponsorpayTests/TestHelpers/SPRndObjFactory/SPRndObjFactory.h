// Apple
#import <Foundation/Foundation.h>

@interface SPRndObjFactory : NSObject

# pragma mark - Object generators

+ (NSInteger)rndNSInt;

+ (NSUInteger)rndNSUInt;

+ (NSUInteger)rndNSUInt:(NSUInteger)max;

+ (NSUInteger)rndNSUInt:(NSUInteger)min :(NSUInteger)max;

+ (NSNumber *)rndBool;

+ (NSNumber *)rndNumberUInt;

+ (NSNumber *)rndNumberUIntMax:(NSUInteger)max;

+ (NSNumber *)rndNumberUInt:(NSUInteger)min :(NSUInteger)max;

+ (NSNumber *)rndNumberDouble;

+ (NSString *)rndStr;

+ (NSURL *)rndURL;

+ (NSString *)rndPath;

+ (NSDate *)rndDate;

+ (NSData *)rndData;

+ (NSDictionary *)rndDict;

+ (NSDictionary *)rndDictSmall;

+ (NSArray *)rndArray;

@end
