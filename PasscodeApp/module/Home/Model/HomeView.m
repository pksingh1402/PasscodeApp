
#import "HomeView.h"

@implementation HomeView

-(id)init
{
    self=[super init];
    NSString *strNibName=[Utility nibNameAccordingToDevice:@"HomeView" TwoNibsForIphone:YES];
    NSArray *arrViews = [[NSBundle mainBundle] loadNibNamed:strNibName owner:self options:nil];
    if ([arrViews count] > 0)
    {
        self = [arrViews objectAtIndex:0];
    }
     
    return self;
}

@end
