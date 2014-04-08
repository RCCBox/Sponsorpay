// Vendor
#import "Kiwi.h"

// Tested class
#import "SPAPIController.h"

// Test helpers
#import "SPDataFactory.h"
#import "SPSwizzelingController.h"
#import "SPRndObjFactory.h"

SPEC_BEGIN(SPAPIControllerSpec)

describe(@"SPAPIControllerSpec", ^{
  
  context(@"when initializing", ^{
    
    context(@"with designated initializer", ^{
      
      it(@"returns instance", ^{
        
        NSObject <SPAPIControllerDelegate> *mock =
        [KWMock nullMockForProtocol:@protocol(SPAPIControllerDelegate)];
        
        SPAPIController *controller =
        [[SPAPIController alloc] initWithDelegate:mock
                                              uID:[SPRndObjFactory rndStr]
                                            appID:[SPRndObjFactory rndStr]
                                           APIKey:[SPRndObjFactory rndStr]];
        
        [[controller shouldNot] beNil];
      });
    });
  });
  
  context(@"when initialized", ^{
    
    // Setup SPAPIController
    __block NSString *uID = [SPRndObjFactory rndStr];
    __block NSString *appID = [SPRndObjFactory rndStr];
    __block id delegate = [KWMock mockForProtocol:@protocol(SPAPIControllerDelegate)];
    __block SPAPIController *controller;
    beforeEach(^{
      controller = [[SPAPIController alloc] initWithDelegate:delegate
                                                         uID:uID
                                                       appID:appID
                                                      APIKey:[SPRndObjFactory rndStr]];
    });
    
    context(@"offers API", ^{
      
      context(@"@selector(fetchOffers)", ^{
        
        context(@"when remote host is available", ^{
          
          context(@"when offers are available", ^{
            
            // Make offers available
            // Swizzeling:
            // NSURLConnection: @selector(initWithRequest:delegate:)
            __block SPMethodSwizzleRevertBlock revertNSURLConnection;
            beforeEach(^{
              SEL selector = @selector(initWithRequest:delegate:);
              revertNSURLConnection = SPSwizzleMethodWithBlock
              (NSURLConnection.class, selector, NO,
               ^(NSURLConnection *con, NSURLRequest *req, id delegate) {
                 
                 // Callback delegate
                 NSData *data = [SPDataFactory offersData];
                 [delegate connection:con didReceiveData:data];
                 [delegate connectionDidFinishLoading:con];
               });
            });
            
            it(@"invokes expected delegate method", ^{
              
              SEL sel = @selector(SPAPIControllerDidFetchOffers:);
              [[delegate should] receive:sel];
              [controller fetchOffers];
            });
          });
          
          context(@"when no offers are available", ^{
            
            // Make offers unavailable
            // Swizzeling:
            // NSURLConnection: @selector(initWithRequest:delegate:)
            __block SPMethodSwizzleRevertBlock revertNSURLConnection;
            beforeEach(^{
              SEL selector = @selector(initWithRequest:delegate:);
              revertNSURLConnection = SPSwizzleMethodWithBlock
              (NSURLConnection.class, selector, NO,
               ^(NSURLConnection *con, NSURLRequest *req, id delegate) {
                 
                 // Callback delegate
                 [delegate connectionDidFinishLoading:con];
               });
            });
            
            it(@"invokes expected delegate method", ^{
              
              SEL sel = @selector(SPAPIControllerDidFetchOffers:);
              [[delegate should] receive:sel];
              [controller fetchOffers];
            });
          });
        });
        
        context(@"when remote host is not available", ^{
          
          // Make server unavailable
          // Swizzeling:
          // NSURLConnection: @selector(initWithRequest:delegate:)
          __block SPMethodSwizzleRevertBlock revertNSURLConnection;
          beforeAll(^{
            SEL selector = @selector(initWithRequest:delegate:);
            revertNSURLConnection = SPSwizzleMethodWithBlock
            (NSURLConnection.class, selector, NO,
             ^(NSURLConnection *con, NSURLRequest *req, id delegate) {
               
               // Setup error
               // Imitate Foundation error on failed request
               NSError *error = [NSError errorWithDomain:[SPRndObjFactory rndStr]
                                                    code:-1004
                                                userInfo:[SPRndObjFactory rndDict]];
               
               // Callback delegate
               [delegate connection:con didFailWithError:error];
             });
          });

          it(@"invokes expected delegate method", ^{
            
            SEL sel = @selector(SPAPIControllerFetchOffersDidFailWithError:);
            [[delegate should] receive:sel];
            [controller fetchOffers];
          });
        });
      });
    });
  });
});

SPEC_END
