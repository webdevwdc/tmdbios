//
//  CMHud.h

#import "MBProgressHUD.h"

@interface CMHud : MBProgressHUD

+ (instancetype)showHUDAddedTo:(UIView *)view;
+ (instancetype)showHUD;

- (void)setLocalizedLabelText:(NSString *)text;

- (void)hide:(BOOL)animated;

@end
