
#import <UIKit/UIKit.h>

@interface CustomAlertView : UIView

- (id)initWithTitle:(NSString *)title message:(NSString *)message timeout:(NSTimeInterval)timeout Color:(UIColor *)color dismissible:(BOOL)dismissible;
- (void)show;

@end



