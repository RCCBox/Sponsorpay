// Apple
@import Foundation;

@interface SPURL : NSObject

+ (NSURL *)signURL:(NSURL *)url
     withQueryDict:(NSDictionary *)dict
         andAPIKey:(NSString *)APIkey;

@end
