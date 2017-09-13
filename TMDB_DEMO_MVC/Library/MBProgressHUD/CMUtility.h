//
//  CMUtility.h
#import <Foundation/Foundation.h>
//#import "CMUser.h"
#import <AVFoundation/AVFoundation.h>

@interface CMUtility : NSObject

+ (NSString *) getWordAtIndex:(int)index fromString:(NSString *)string;

+ (NSString *) getCountryNameLocalizedFromLocale:(NSString *)locale;

//+ (NSString *) getUserFirstName:(CMUser *)user;

+ (void) removeFileFromPath:(NSURL *)url;

+ (void) setUserInteractionEnable:(BOOL)enable fowView:(NSArray *)views;
+ (void) setAlpha:(CGFloat)alpha forViews:(NSArray *)views;

+ (void)convertVideoToLowQuailtyWithInputURL:(NSURL*)inputURL outputURL:(NSURL*)outputURL handler:(void (^)(AVAssetExportSession*))handler;

+ (CGAffineTransform)getDeviceAffineTransformRotation;

+ (BOOL)isAppInstalledWithUrlScheme:(NSString *)appUrlScheme;
@end
