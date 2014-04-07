// Apple
@import Foundation;

@interface SPOffer : NSObject

#pragma mark - Public properties (readwrite)

@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, copy, readonly) NSString *teaser;
@property (nonatomic, strong, readonly) NSURL *thumbnailURL;
@property (nonatomic, strong, readonly) NSNumber *payout;

#pragma mark - Designated initializers

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
