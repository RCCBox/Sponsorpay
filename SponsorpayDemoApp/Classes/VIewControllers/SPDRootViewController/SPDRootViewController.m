
// Header
#import "SPDRootViewController.h"

// App classes
// Model
#import "SPDDataStore.h"
// Viewcontrollers
#import "SPDOffersViewController.h"

// Vendor
// Sponsorpay
#import "SPAPIController.h"

@interface SPDRootViewController () <SPAPIControllerDelegate>

#pragma mark - Private properties

@property (nonatomic, strong, readwrite) SPAPIController *apiController;

#pragma mark - Private properties (IBOutlets)

@property (nonatomic, strong, readwrite) IBOutlet UITextField *uidTextField;
@property (nonatomic, strong, readwrite) IBOutlet UITextField *apiKeyTextField;
@property (nonatomic, strong, readwrite) IBOutlet UITextField *appIDTextField;

@property (nonatomic, strong, readwrite) IBOutlet UILabel *messageLabel;
@property (nonatomic, strong, readwrite) IBOutlet UIActivityIndicatorView *spinnerView;
@property (nonatomic, strong, readwrite) IBOutlet UIButton *fetchButton;

@end

@implementation SPDRootViewController

#pragma mark - Template methods

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  [self SP_setupUI];
}

#pragma mark - IBActions

- (IBAction)didPressFetchOfferButton:(id)sender
{
  [self SP_blockUI];
  [self SP_fetchOffers];
}

- (IBAction)didPressReturnKey:(id)sender
{
  [self.view endEditing:YES];
}

- (IBAction)didPressResetButton:(id)sender
{
  [self SP_setupUI];
}

#pragma mark - Private helpers (UI)

- (void)SP_setupUI
{
  self.uidTextField.text = [SPDDataStore sponsorpayUID];
  self.appIDTextField.text = [SPDDataStore sponsorpayAppID];
  self.apiKeyTextField.text = [SPDDataStore sponsorpayAPIKey];
}

- (void)SP_blockUI
{
  // Clear message
  self.messageLabel.text = @"";
  
  // Show spinner
  [self.spinnerView startAnimating];
  
  // Hide button
  self.fetchButton.userInteractionEnabled = NO;
  __block typeof(self) weakSelf = self;
  [UIView animateWithDuration:1.0 animations:^{
    weakSelf.fetchButton.alpha = 0.0f;
  }];
}

- (void)SP_unblockUIWithErrorMessage:(NSString *)message
{
  // Update message
  if (message) {
    self.messageLabel.text = message;
  } else {
    message = @"No offers available.";
  }
  
  // Show spinner
  [self.spinnerView stopAnimating];
  
  // Show button
  __block typeof(self) weakSelf = self;
  [UIView animateWithDuration:1.0 animations:^{
    weakSelf.fetchButton.alpha = 1.0f;
  } completion:^(BOOL finished) {
    self.fetchButton.userInteractionEnabled = YES;
  }];
}

#pragma mark - Private helpers (Model)

- (void)SP_fetchOffers
{  
  // Setup Sponsorpay API controller
  NSString *uID = self.uidTextField.text;
  NSString *appID = self.appIDTextField.text;
  NSString *APIKey = self.apiKeyTextField.text;
  self.apiController = [[SPAPIController alloc] initWithDelegate:self
                                                             uID:uID
                                                           appID:appID
                                                          APIKey:APIKey];
  
  // Fetch offers
  [self.apiController fetchOffers];
}

#pragma mark - <SPAPIControllerDelegate>

- (void)SPAPIControllerDidFetchOffers:(NSArray *)offers
{
  // Unblock UI
  [self SP_unblockUIWithErrorMessage:nil];
  
  // Present offers viewcontroller
  if (offers) {
    SPDOffersViewController *vc = [[SPDOffersViewController alloc] initWithOffers:offers];
    [self.navigationController pushViewController:vc animated:YES];
  }
}

- (void)SPAPIControllerFetchOffersDidFailWithError:(NSError *)error
{
  [self SP_unblockUIWithErrorMessage:[error localizedDescription]];
}

@end
