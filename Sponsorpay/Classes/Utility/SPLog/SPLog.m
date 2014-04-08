// Header
#import "SPLog.h"

@implementation SPLog

# pragma mark - Logging (Debug)

+ (void)debug:(NSString *)format, ...
{
  if ([[self class] SP_isSimulator]) {
    
    va_list args;
    va_start(args, format);
    NSString *msg = [[NSString alloc] initWithFormat:format arguments:args];
    va_end(args);
    
    [[self class] SP_logWithPrefix:nil
                      logCallStack:NO
                           message:msg];
  }
}

# pragma mark - Logging (Error)

+ (void)error:(NSString *)format, ...
{
  va_list args;
  va_start(args, format);
  NSString *msg = [[NSString alloc] initWithFormat:format arguments:args];
  va_end(args);
  
  [[self class] SP_logWithPrefix:@"Runtime error"
                    logCallStack:YES
                         message:msg];
}

# pragma mark - Private helpers

+ (void)SP_logWithPrefix:(NSString *)prefix
            logCallStack:(BOOL)logCallStack
                 message:(NSString *)msg
{
  const char *arch = [[[self class] SP_arch] cStringUsingEncoding:NSUTF8StringEncoding];
  printf("Sponsorpay.sdk(%s): ", arch);
  if (prefix) printf("%s: ", [prefix cStringUsingEncoding:NSUTF8StringEncoding]);
  if (msg) printf("%s\n", [msg cStringUsingEncoding:NSUTF8StringEncoding]);
  if (logCallStack) printf("%s\n", [[self class] SP_callStackSymbols]);
}

+ (const char *)SP_callStackSymbols
{
  NSArray *symbols = [NSThread callStackSymbols];
  NSString *str = [symbols description];
  const char *cStr = [str cStringUsingEncoding:NSUTF8StringEncoding];
  return cStr;
}

+ (BOOL)SP_isSimulator
{
  #if TARGET_IPHONE_SIMULATOR
    return YES;
  #else
    return NO;
  #endif
}

+ (NSString *)SP_arch
{
  NSString *arch;
  #if __LP64__
    arch = @"64";
  #else
    arch = @"32";
  #endif
  
  return arch;
}

@end
