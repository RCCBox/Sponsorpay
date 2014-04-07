// Apple
@import Foundation;

@protocol SPAPIControllerDelegate <NSObject>

- (void)SPAPIControllerDidFetchOffers;

@end

@interface SPAPIController : NSObject

#pragma mark - Public properties (readonly)

@property (nonatomic, strong, readonly) NSObject <SPAPIControllerDelegate> *delegate;

#pragma mark - Designated initializer

- (instancetype)initWithDelegate:(NSObject<SPAPIControllerDelegate> *)delegate
                             uID:(NSString *)uID
                           appID:(NSString *)appID;

#pragma mark - Offers

- (void)fetchOffers;

@end
