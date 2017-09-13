//
//  ServiceHandler.h
//  TMDB_DEMO_MVC
//
//  Created by webskitters on 12/09/17.
//  Copyright © 2017 webskitters. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^completionService) (NSData *data, NSURLResponse *response, NSError *error);

@interface ServiceHandler : NSObject

+ (ServiceHandler *)sharedInstance;

- (void)sendPostRequest:(NSDictionary *)dictionary withMethod:(NSString*)serviceUrl withCompletion:(completionService) block;
- (void)sendGetWithMethod:(NSString*)serviceUrl withCompletion:(completionService) block;


- (void)loginWithParams:(NSDictionary *)params withCompletion:(completionService) block;
- (void)registerWithParams:(NSDictionary *)params withCompletion:(completionService) block;

@end
