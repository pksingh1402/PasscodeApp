
#import "Utility.h"
#import <SystemConfiguration/SCNetworkReachability.h>
#include <netinet/in.h>
#import <Social/Social.h>

@implementation Utility

+(enum Device)checkDevice
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        UIScreen *screen = [UIScreen mainScreen];
        CGRect fullScreenRect = screen.bounds;
        if (fullScreenRect.size.height==568)
        {
            return Iphone5;
        }
        else{
            return Iphone;
        }
    }
    else{
        return Ipad;
    }
}

+(NSString *)nibNameAccordingToDevice:(NSString *)nibName TwoNibsForIphone:(BOOL)twoNibsForIphone
{
    NSString *strNibName;
    switch ([Utility checkDevice])
    {
        case Iphone:
            if (twoNibsForIphone)
            {
                strNibName=[NSString stringWithFormat:@"%@~iphone4",nibName];
            }
            else
            {
                strNibName=[NSString stringWithFormat:@"%@~iphone",nibName];
            }
            break;
        case Iphone5:
            strNibName=[NSString stringWithFormat:@"%@~iphone",nibName];
            break;
        case Ipad:
            strNibName=[NSString stringWithFormat:@"%@~ipad",nibName];
    }
    return strNibName;
}

+(void)showAlertViewWithMessage:(NSString *)iMessageString Color:(UIColor *)color{
    if (!iMessageString)
    {
        iMessageString= @"";
        return;
    }
    NSString *message = [NSString stringWithFormat:@"%@",iMessageString];
    CustomAlertView *anAlertView = [[CustomAlertView alloc]initWithTitle:@"" message:message timeout:1 Color:color dismissible:YES];
    [anAlertView performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:YES];
    
}

+(NSDictionary *)getLocalizedStrings:(NSString *)className
{
    return [[kCOMMONENTITIES dicLocalizedStrings] valueForKey:className];
}

@end
