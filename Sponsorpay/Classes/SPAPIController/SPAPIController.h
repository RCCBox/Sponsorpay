// Apple
@import Foundation;

@protocol SPAPIControllerDelegate <NSObject>

#pragma mark - Delegate methods (Offers)

- (void)SPAPIControllerDidFetchOffers:(NSArray *)offers;
- (void)SPAPIControllerFetchOffersDidFailWithError:(NSError *)error;

@end

@interface SPAPIController : NSObject

#pragma mark - Public properties (readonly)

@property (nonatomic, strong, readonly) NSObject <SPAPIControllerDelegate> *delegate;

#pragma mark - Designated initializer

- (instancetype)initWithDelegate:(NSObject<SPAPIControllerDelegate> *)delegate
                             uID:(NSString *)uID
                           appID:(NSString *)appID
                          APIKey:(NSString *)APIKey;

#pragma mark - API (Offers)

- (void)fetchOffers;

@end
