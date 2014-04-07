// Header
#import "SPOffer.h"

@interface SPOffer ()

#pragma mark - Public properties (readwrite)

@property (nonatomic, copy, readwrite) NSString *title;
@property (nonatomic, copy, readwrite) NSString *teaser;
@property (nonatomic, strong, readwrite) NSURL *thumbnailURL;
@property (nonatomic, strong, readwrite) NSNumber *payout;

@end

@implementation SPOffer

#pragma mark - Designated initializer

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
  // Check arguments
  SPErrorAssertTrueThrowAndReturnNil(dictionary, SPErrorMissingArgument);
  
  // Extract mandatory values
  // Title
  NSString *title = dictionary[@"title"];
  // Teaser
  NSString *teaser = dictionary[@"teaser"];
  // Thumnail URL
  NSDictionary *thumbnailDict = dictionary[@"thumbnail"];
  NSURL *thumbnailURL = [NSURL URLWithString:thumbnailDict[@"hires"]];
  // Payout
  NSNumber *payout = dictionary[@"payout"];
  
  // All mandatory value available
  BOOL hasMandatoryValues = (title && teaser && thumbnailDict && payout);
  if (hasMandatoryValues) {
    
    // Init object
    Class c = [self class];
    return [[c alloc] initWithTitle:title
                             teaser:teaser
                       thumbnailURL:thumbnailURL
                             payout:payout];
  }
  
  // Initialization failed
  return nil;
}

- (instancetype)initWithTitle:(NSString *)title
                       teaser:(NSString *)teaser
                 thumbnailURL:(NSURL *)thumbnailURL
                       payout:(NSNumber *)payout
{
  // Check arguments
  SPErrorAssertTrueThrowAndReturnNil(title, SPErrorMissingArgument);
  SPErrorAssertTrueThrowAndReturnNil(teaser, SPErrorMissingArgument);
  SPErrorAssertTrueThrowAndReturnNil(thumbnailURL, SPErrorMissingArgument);
  SPErrorAssertTrueThrowAndReturnNil(payout, SPErrorMissingArgument);
  
  self = [super init];
  if (self) {
    
    // Store arguments
    self.title = title;
    self.teaser = teaser;
    self.thumbnailURL = thumbnailURL;
    self.payout = payout;
  }
  return self;
}

- (instancetype)init
{
  // This object must not be initialized using @selector(init)
  [self doesNotRecognizeSelector:_cmd];
  return nil;
}

#pragma mark - Template methods

- (NSString *)description
{
  NSMutableString *mStr = [NSMutableString string];
  [mStr appendFormat:@"title      : %@\n", self.title];
  [mStr appendFormat:@"teaser     : %@\n", self.teaser];
  [mStr appendFormat:@"thubnailURL: %@\n", [self.thumbnailURL absoluteString]];
  [mStr appendFormat:@"payout     : %@\n", self.payout];
  return [mStr copy];
}

@end
