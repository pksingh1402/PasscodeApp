
#import <UIKit/UIKit.h>
#import "PinView.h"

@interface PinViewViewController : UIViewController
{
    PinView *pinView ;
}

@property(nonatomic,assign)BOOL isChangePINRequired ;
@property(nonatomic,assign)BOOL isDisablePINRequired ;

@end
