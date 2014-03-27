
#import "PinViewViewController.h"

@interface PinViewViewController ()

@end

@implementation PinViewViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)loadView
{
    pinView = [[PinView alloc] init];
    pinView.isChangePINRequest = self.isChangePINRequired;
    pinView.isDisablePINRequest = self.isDisablePINRequired;
    [pinView setLocalizedStrings];
    self.view = pinView;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
