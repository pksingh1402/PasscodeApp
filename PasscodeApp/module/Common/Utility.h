
#import <Foundation/Foundation.h>

@interface Utility : NSObject

+(NSString *)nibNameAccordingToDevice:(NSString *)nibName TwoNibsForIphone:(BOOL)twoNibsForIphone;

+(void)showAlertViewWithMessage:(NSString *)iMessageString Color:(UIColor *)color;

+(NSDictionary *)getLocalizedStrings:(NSString *)className;


@end
