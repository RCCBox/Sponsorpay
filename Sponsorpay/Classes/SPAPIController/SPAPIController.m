// Header
#import "SPAPIController.h"

// Sponsorpay classes
// Utility:
#import "SPURL.h"
#import "SPDate.h"
// Requests:
// Env
#import "SPEnvPhoneInfo.h"
#import "SPEnvNetworkInfo.h"
// Responses:
// Domain objects
#import "SPOffer.h"

@interface SPAPIController ()

<
NSURLConnectionDelegate,
NSURLConnectionDataDelegate
>

#pragma mark - Public properties (readwrite)

@property (nonatomic, strong, readwrite) NSObject <SPAPIControllerDelegate> *delegate;

#pragma mark - Private properties (readwrite)

// Arguments
@property (nonatomic, copy, readwrite) NSString *SP_uID;
@property (nonatomic, copy, readwrite) NSString *SP_appID;
@property (nonatomic, copy, readwrite) NSString *SP_APIKey;

// Offers (Data)
@property (nonatomic, strong, readwrite) NSMutableData *SP_data;
@property (nonatomic, strong, readwrite) NSURLResponse *SP_response;

@end

@implementation SPAPIController

#pragma mark - Designated initializer

- (instancetype)initWithDelegate:(NSObject<SPAPIControllerDelegate> *)delegate
                             uID:(NSString *)uID
                           appID:(NSString *)appID
                          APIKey:(NSString *)APIKey
{
  // Check arguments
  NSAssert(delegate, @"Delegate argument is mandatory");
  NSAssert(uID, @"uID argument is mandatory");
  NSAssert(appID, @"appID argument is mandatory");
  NSAssert(appID, @"APIKey argument is mandatory");
  
  self = [super init];
  if (self) {
    
    // Store arguments
    self.delegate = delegate;
    self.SP_uID = uID;
    self.SP_appID = appID;
    self.SP_APIKey = APIKey;
  }
  return self;
}

#pragma mark - Template methods (Disabled)

- (instancetype)init
{
  // This object must not be initialized using @selector(init)
  [self doesNotRecognizeSelector:_cmd];
  return nil;
}

#pragma mark - API (Offers)

- (void)fetchOffers
{
  // Setup URL
  NSURL *url = [NSURL URLWithString:@"http://api.sponsorpay.com/feed/v1/offers.json"];
  SPErrorAssertTrueThrowAndReturn(url, SPErrorMissingExpectedValue);
  
  // Setup query dict
  NSString *idfa = [SPEnvPhoneInfo idfa];
  NSString *ip = [SPEnvNetworkInfo ip];
  NSString *locale = [SPEnvPhoneInfo locale];
  NSString *system = [SPEnvPhoneInfo systemVersion];
  NSNumber *timestamp = [SPDate timeIntervalSince1970];
  NSDictionary *queryDict = @{@"appid": self.SP_appID,
                              @"device_id": idfa,
                              @"ip": ip,
                              @"locale": locale,
                              @"os_version": system,
                              @"ps_time": timestamp,
                              @"timestamp": timestamp,
                              @"uid": self.SP_uID};
  
  // Setup signed URL with query
  url = [SPURL signURL:url withQueryDict:queryDict andAPIKey:self.SP_APIKey];
  SPErrorAssertTrueThrowAndReturn(url, SPErrorMissingExpectedValue);
  
  // Setup request
  NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
  request.URL = url;
  request.HTTPMethod = @"GET";
  request.timeoutInterval = 20;
  request.cachePolicy = NSURLCacheStorageNotAllowed;
  
  // Fetch offers
  NSURLConnection *connection =
    [[NSURLConnection alloc] initWithRequest:request delegate:self];
  SPErrorAssertTrueThrowAndReturn(connection, SPErrorMissingExpectedValue);
}

#pragma mark - Private helpers (Data parsing)

- (void)SP_callbackDelegateWithData:(NSData *)data
                        andResponse:(NSURLResponse *)response
{
  // No offers - callback delegate without offers
  if ((!data) || (![data length])) {
    [self SP_callbackDelegateWithOffers:nil];
    return;
  }
  
  // Convert JSON to dictionary
  NSError *error;
  NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data
                                                           options:0
                                                             error:&error];
  
  // Convert dictionary to domain objects
  NSMutableArray *mOffersArray = [NSMutableArray array];
  NSArray *jsonOffers = jsonDict[@"offers"];
  SPErrorAssertTrueThrowAndReturn(mOffersArray, SPErrorMissingExpectedValue);
  for (NSDictionary *offerDict in jsonOffers) {
    SPOffer *offer = [[SPOffer alloc] initWithDictionary:offerDict];
    if (offer) [mOffersArray addObject:offer];
  }
  
  // No offers found - create error object if possible
  if (![mOffersArray count]) {
    
    // Proceed if server did send error message
    NSString *message = jsonDict[@"message"];
    if (message) {
      SPError *err = [SPError errorWithCode:SPErrorMissingExpectedValue
                                       info:@{NSLocalizedDescriptionKey: message}];
      
      // Callback delegate
      [self SP_callbackDelegateWithError:err];
      return;
    }
  }
  
  // Callback delegate
  if (error) {
    
    // Convert data to JSON string
    NSString *jsonString =
      [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    SPErrorAssertTrueThrowAndReturn(jsonString, SPErrorMissingExpectedValue);
    
    // Setup error
    SPError *err =
      [SPError errorWithCode:SPErrorMissingExpectedValue
                        info:@{@"underlying error" : error,
                               @"response" : jsonString}];
    
    // Callback delegate
    [self SP_callbackDelegateWithError:err];
    
  } else {
    
    // Check if response is valid
    NSDictionary *headers = [(NSHTTPURLResponse *)response allHeaderFields];
    NSString *signature = headers[@"X-Sponsorpay-Response-Signature"];
    BOOL isValid = [SPURL isResponseDataValid:data
                                    forAPIKey:self.SP_APIKey
                                      andHash:signature];
    
    // Response is invalid
    if (!isValid) {
      NSString *message = @"Response contains invalid signature.";
      SPError *err = [SPError errorWithCode:SPErrorMissingExpectedValue
                                       info:@{NSLocalizedDescriptionKey: message}];
      
      // Callback delegate
      [self SP_callbackDelegateWithError:err];
      return;
    }
    
    // Callback delegate with offers
    NSArray *offersArray = [mOffersArray copy];
    SPErrorAssertTrueThrowAndReturn(offersArray, SPErrorMissingExpectedValue);
    [self SP_callbackDelegateWithOffers:offersArray];
  }
}

#pragma mark - Private helpers (Delegate callbacks)

- (void)SP_callbackDelegateWithOffers:(NSArray *)offers
{
  SEL sel = @selector(SPAPIControllerDidFetchOffers:);
  if ([self.delegate respondsToSelector:sel]) {
    [self.delegate SPAPIControllerDidFetchOffers:offers];
  }
}

- (void)SP_callbackDelegateWithError:(NSError *)error
{
  SEL sel = @selector(SPAPIControllerFetchOffersDidFailWithError:);
  if ([self.delegate respondsToSelector:sel]) {
    [self.delegate SPAPIControllerFetchOffersDidFailWithError:error];
  }
}

#pragma mark - <NSURLConnectionDelegate>

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
  // Callback delegate with error
  [self SP_callbackDelegateWithError:error];
}

- (void)connection:(NSURLConnection *)connection
  didReceiveResponse:(NSURLResponse *)response
{
  // Store response data for later evaluation
  self.SP_response = response;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
  // Callback delegate with offers
  [self SP_callbackDelegateWithData:self.SP_data andResponse:self.SP_response];
  
  // Erase stored request data
  self.SP_data = nil;
  self.SP_response = nil;
}

#pragma mark - <NSURLConnectionDataDelegate>

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
  // Incremental store data
  if (!self.SP_data) self.SP_data = [NSMutableData data];
  [self.SP_data appendData:data];
}

@end
