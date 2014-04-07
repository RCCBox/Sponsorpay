// Apple
@import Foundation;

@interface SPLog : NSObject

# pragma mark - Logging (Debug)

+ (void)debug:(NSString *)format, ...;

# pragma mark - Logging (Error)

+ (void)error:(NSString *)format, ...;

@end
