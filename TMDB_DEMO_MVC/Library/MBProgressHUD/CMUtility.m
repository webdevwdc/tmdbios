//
//  CMUtility.m

#import "CMUtility.h"
#import "CMHud.h"

#define degreesToRadian(x)  (M_PI * (x) / 180.0)

@implementation CMUtility

+ (NSString *)getWordAtIndex:(int)index fromString:(NSString *)string {
  if (!string) { return nil; }
  
  return [[string componentsSeparatedByString:@" "] objectAtIndex:index];
}

+ (NSString *) getCountryNameLocalizedFromLocale:(NSString *)locale {
  if (!locale) { return nil; }
  
  NSString *countryCode = [[locale componentsSeparatedByString:@"_"] lastObject];
  
  NSString *identifier = [NSLocale localeIdentifierFromComponents: [NSDictionary dictionaryWithObject: countryCode forKey: NSLocaleCountryCode]];
  NSString *countryName = [[NSLocale currentLocale] displayNameForKey: NSLocaleIdentifier value: identifier];
  
  return countryName;
}

//+ (NSString *)getUserFirstName:(CMUser *)user {
//  if (user.firstName) {
//    return user.firstName;
//  } else {
//    return @"kSomeone".localizedString;
//  }
//}

+ (void)removeFileFromPath:(NSURL *)url {
  [[NSFileManager defaultManager] removeItemAtURL:url error:nil];
  NSLog(@"removeitematURL %@", url);
}

+ (void)setUserInteractionEnable:(BOOL)enable fowView:(NSArray *)views {
  for (UIView *view in views) {
    [view setUserInteractionEnabled:enable];
  }
}

+ (void)setAlpha:(CGFloat)alpha forViews:(NSArray *)views {
  for (UIView *view in views) {
    [view setAlpha:alpha];
  }
}

+ (void)convertVideoToLowQuailtyWithInputURL:(NSURL *)inputURL outputURL:(NSURL *)outputURL handler:(void (^)(AVAssetExportSession *))handler {
  CMHud *hud = [CMHud showHUD];
  [hud setColor:[UIColor clearColor]];
  
  [CMUtility removeFileFromPath:outputURL];
  AVURLAsset *asset = [AVURLAsset URLAssetWithURL:inputURL options:nil];
  AVAssetExportSession *exportSession = [[AVAssetExportSession alloc] initWithAsset:asset
                                                                         presetName:AVAssetExportPresetMediumQuality];

//  exportSession.outputFileType = AVFileTypeQuickTimeMovie;
  exportSession.outputFileType = AVFileTypeMPEG4;
  exportSession.outputURL = outputURL;
  
  [exportSession exportAsynchronouslyWithCompletionHandler:^(void) {
    [hud hide:YES];
    handler(exportSession);
  }];
}

+ (CGAffineTransform)getDeviceAffineTransformRotation {
  
  CGAffineTransform orientationTransform = CGAffineTransformIdentity;
  
  switch ([[UIDevice currentDevice] orientation])
  {
    default:
    case UIImageOrientationUp:
      orientationTransform = CGAffineTransformMakeRotation(degreesToRadian(0));
      break;
      
    case UIImageOrientationDown:
      orientationTransform = CGAffineTransformMakeRotation(degreesToRadian(180));
      break;
      
    case UIImageOrientationLeft:
      orientationTransform = CGAffineTransformMakeRotation(degreesToRadian(-90));
      break;
      
    case UIImageOrientationRight:
      orientationTransform = CGAffineTransformMakeRotation(degreesToRadian(90));
      break;
  }
  
  return orientationTransform;
}

+ (BOOL)isAppInstalledWithUrlScheme:(NSString *)appUrlScheme {
  if (!appUrlScheme) { return NO; }
  
  NSURL *appUrl = [[NSURL alloc] initWithString:appUrlScheme];
  return [[UIApplication sharedApplication] canOpenURL:appUrl];
}
@end
