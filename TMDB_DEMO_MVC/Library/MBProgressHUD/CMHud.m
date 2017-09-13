//
//  CMHud.m

#import "CMHud.h"

@implementation CMHud

+ (instancetype)showHUDAddedTo:(UIView *)view {
  CMHud *hud = [super showHUDAddedTo:view animated:YES];
  [hud setRemoveFromSuperViewOnHide:YES];
  [hud setDimBackground:YES];
  return hud;
}

+ (instancetype)showHUD {
  return [CMHud showHUDAddedTo:[[[[UIApplication sharedApplication] delegate] window] rootViewController].view];
}

- (void)setLocalizedLabelText:(NSString *)text {
  [self setLabelText:text];
}

- (void)hide:(BOOL)animated {
  dispatch_async(dispatch_get_main_queue(), ^{
    [super hide:animated];
  });
}

@end
