// Header
#import "SPAPIController.h"

@interface SPAPIController ()

#pragma mark - Public properties (readwrite)

@property (nonatomic, strong, readwrite) NSObject <SPAPIControllerDelegate> *delegate;

#pragma mark - Public properties (readwrite)

@property (nonatomic, strong, readwrite) NSString *TM_uID;
@property (nonatomic, strong, readwrite) NSString *TM_appID;

@end

@implementation SPAPIController

#pragma mark - Designated initializer

- (instancetype)initWithDelegate:(NSObject<SPAPIControllerDelegate> *)delegate
                             uID:(NSString *)uID
                           appID:(NSString *)appID
{
  // Check arguments
  NSAssert(delegate, @"Delegate argument is mandatory");
  NSAssert(uID, @"uID argument is mandatory");
  NSAssert(appID, @"appID argument is mandatory");
  
  self = [super init];
  if (self) {
    
    // Store arguments
    self.delegate = delegate;
    self.TM_uID = uID;
    self.TM_appID = appID;
  }
  return self;
}

#pragma mark - Offers

- (void)fetchOffers
{
  
}

#pragma mark - Template methods

- (instancetype)init
{
  // This object must not be initialized using @selector(init)
  [self doesNotRecognizeSelector:_cmd];
  return nil;
}

@end
