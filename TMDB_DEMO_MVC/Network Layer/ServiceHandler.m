//
//  ServiceHandler.m
//  TMDB_DEMO_MVC
//
//  Created by webskitters on 12/09/17.
//  Copyright © 2017 webskitters. All rights reserved.
//

#import "ServiceHandler.h"

static const NSString *SERVER_URL = @"http://203.163.248.214:5000/";




@implementation ServiceHandler

#pragma mark - Initialize The Class Ityself

+ (ServiceHandler *)sharedInstance {
    static ServiceHandler *myGlobal = nil;
    
    if (myGlobal == nil) {
        myGlobal = [[[self class] alloc] init];
    }
    return myGlobal;
}


//- (id) init {
//    if (self = [super init]) {
//        
//    }
//    return self;
//}

#pragma mark - POST method call

- (void)sendPostRequest:(NSDictionary *)dictionary withMethod:(NSString*)serviceUrl withCompletion:(completionService) block{
    
    
    
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfig delegate:nil delegateQueue:nil];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:serviceUrl]];
    [request setHTTPMethod:@"POST"];
    
    NSError *jsonError = nil;
    
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    NSData *body = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&jsonError];
    [request setHTTPBody:body];

    
    
    NSURLSessionDataTask *jsonDataTask = [session dataTaskWithRequest:request
                                                    completionHandler:^(NSData *data,
                                                                        NSURLResponse *response,
                                                                        NSError *error) {
                                                        if (block != nil) {
                                                            if (error == nil) {
                                                                block(data, response, error);
                                                            }
                                                            else{
                                                                NSLog(@"inner error block");
                                                                block(data, response, error);
                                                            }
                                                            
                                                        }
                                                        else{
                                                            NSData *data = [NSData new];
                                                            NSURLResponse *response = [NSURLResponse new];
                                                            NSLog(@"error block");
                                                            
                                                            block(data, response, error);

                                                        }
                                                    }];
    [jsonDataTask resume];


}

#pragma mark - GET method call

- (void)sendGetWithMethod:(NSString*)serviceUrl withCompletion:(completionService) block{
    
    
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfig delegate:nil delegateQueue:nil];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:serviceUrl]];
    [request setHTTPMethod:@"GET"];
    
    NSURLSessionDataTask *jsonDataTask = [session dataTaskWithRequest:request
                                                    completionHandler:^(NSData *data,
                                                                        NSURLResponse *response,
                                                                        NSError *error) {
                                                        if (block != nil) {
                                                            if (error == nil) {
                                                                dispatch_async(dispatch_get_main_queue(), ^{
                                                                block(data, response, error);
                                                                });
                                                            }
                                                            else{
                                                                NSLog(@"inner error block");
                                                                dispatch_async(dispatch_get_main_queue(), ^{
                                                                block(data, response, error);
                                                                });
                                                            }
                                                            
                                                        }
                                                        else{
                                                            NSData *data = [NSData new];
                                                            NSURLResponse *response = [NSURLResponse new];
                                                            NSLog(@"error block");
                                                            dispatch_async(dispatch_get_main_queue(), ^{
                                                            block(data, response, error);
                                                            });
                                                            
                                                        }
                                                    }];
    [jsonDataTask resume];

    
}

#pragma mark - Login webservice method call

- (void)loginWithParams:(NSDictionary *)params withCompletion:(completionService) block{
    
    [self sendPostRequest:params withMethod:[SERVER_URL stringByAppendingString:@"login"] withCompletion:block];
    
}

#pragma mark - Register webservice method call

- (void)registerWithParams:(NSDictionary *)params withCompletion:(completionService) block{
    
    [self sendPostRequest:params withMethod:[SERVER_URL stringByAppendingString:@"registerUser"] withCompletion:block];
    
}




@end
