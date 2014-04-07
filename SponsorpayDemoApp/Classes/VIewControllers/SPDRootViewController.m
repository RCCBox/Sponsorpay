// Header
#import "SPDRootViewController.h"

// App classes
// Model
#import "SPDDataStore.h"

// Vendor
// Sponsorpay
#import "SPAPIController.h"

@interface SPDRootViewController () <SPAPIControllerDelegate>

#pragma mark - Private properties

@property (nonatomic, strong, readwrite) SPAPIController *apiController;

@end

@implementation SPDRootViewController

#pragma mark - Template methods

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  [self SP_setupModel];
}

#pragma mark - Private helpers (Model setup)

- (void)SP_setupModel
{
  // Setup Sponsorpay API controller
  NSString *uID = [SPDDataStore sponsorpayUID];
  NSString *appID = [SPDDataStore sponsorpayAppID];
  self.apiController = [[SPAPIController alloc] initWithDelegate:self
                                                             uID:uID
                                                           appID:appID];
  
  // Fetch offers
  [self.apiController fetchOffers];
}

#pragma mark - <SPAPIControllerDelegate>

- (void)SPAPIControllerDidFetchOffers
{
  
}

@end
