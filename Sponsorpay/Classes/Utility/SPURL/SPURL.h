// Apple
@import Foundation;

@interface SPURL : NSObject

+ (NSURL *)signURL:(NSURL *)url
     withQueryDict:(NSDictionary *)dict
         andAPIKey:(NSString *)APIkey;

+ (BOOL)isResponseDataValid:(NSData *)data
                  forAPIKey:(NSString *)apiKey
                    andHash:(NSString *)responseHash;

@end
