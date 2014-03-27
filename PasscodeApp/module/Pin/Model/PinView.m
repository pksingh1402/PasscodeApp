
#import "PinView.h"

@implementation PinView

-(id)init
{
    self=[super init];
    NSString *strNibName=[Utility nibNameAccordingToDevice:@"PinView" TwoNibsForIphone:YES];
    NSArray *arrViews = [[NSBundle mainBundle] loadNibNamed:strNibName owner:self options:nil];
    if ([arrViews count] > 0) {
        self = [arrViews objectAtIndex:0];
    }
    return self;
}

-(void)setLocalizedStrings
{
    // Set variables with default value
    strPIN = @"";
    strOldPIN = @"";
    strTempPIN = @"";
    strConfirmPIN = @"";
    isOldPinScreen = NO;
    isConfirmPinScreen = NO;
    if(self.isChangePINRequest){
        isOldPinScreen = YES;
    }
    if ([[NSUserDefaults standardUserDefaults] valueForKey:kLOGINPIN] && !self.isChangePINRequest)
    {
         [viewDefaultKey setHidden:YES];
         [viewCustomKey setHidden:NO];
     }else{
         [viewDefaultKey setHidden:NO];
         [viewCustomKey setHidden:YES];
     }
    // Hide cancel link from PIN view
    if (self.isChangePINRequest || self.isDisablePINRequest || [[NSUserDefaults standardUserDefaults] boolForKey:kPINENABLE])
    {
         [btnCancel setHidden:NO];
         [self swipeBack];
    }else{
         [btnCancel setHidden:YES];
    }
    [self swipeBack];
    [self resetScreen];
}

-(void)swipeBack
{
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(onTapBack)];
    [swipe setDirection:UISwipeGestureRecognizerDirectionRight];
    [self addGestureRecognizer:swipe];
}

-(void)onTapBack
{
    [[kCOMMONENTITIES navControllerMain] popViewControllerAnimated:YES];
}

-(void)validatePin
{
     if(isOldPinScreen)
     {
        if (![strOldPIN isEqualToString:[[NSUserDefaults standardUserDefaults] valueForKey:kLOGINPIN]])
        {
            [Utility showAlertViewWithMessage:@"Wrong PIN" Color:[UIColor colorWithRed:kMESSAGECOLORRED green:kMESSAGECOLORGREEN blue:kMESSAGECOLORBLUE alpha:1]];
            strOldPIN = @"";
        }else
        {
            isOldPinScreen = NO;
        }
        [self resetScreen];
        return;
    }else if(isConfirmPinScreen)
    {
        if (![strPIN isEqualToString:strConfirmPIN] )
        {
            [Utility showAlertViewWithMessage:@"Confirm PIN not matched." Color:[UIColor colorWithRed:kMESSAGECOLORRED green:kMESSAGECOLORGREEN blue:kMESSAGECOLORBLUE alpha:1]];
            strConfirmPIN = @"";
            [self resetScreen];
            return;
        }else
        {
            isConfirmPinScreen = NO;
        }
    }else
    {
        if (![strPIN isEqualToString:[[NSUserDefaults standardUserDefaults] valueForKey:kLOGINPIN]])
        {
            [Utility showAlertViewWithMessage:@"Wrong PIN" Color:[UIColor colorWithRed:kMESSAGECOLORRED green:kMESSAGECOLORGREEN blue:kMESSAGECOLORBLUE alpha:1]];
            strPIN = @"";
            [self resetScreen];
            return;
        }
    }
    
    if (self.isDisablePINRequest)
    {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:kLOGINPINSTATUS];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:kLOGINPIN];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    else
    {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kLOGINPINSTATUS];
        [[NSUserDefaults standardUserDefaults] setValue:strPIN forKey:kLOGINPIN];
    }

    [kNOTIFICATIONCENTER postNotificationName:PINStateChangeNotification object:nil userInfo:[self getMEssageType]];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self  onTapBack];
}

-(NSDictionary *)getMEssageType
{
    NSDictionary *dicStatus;
    if (self.isChangePINRequest || self.isDisablePINRequest || [[NSUserDefaults standardUserDefaults] boolForKey:kPINENABLE])
    {
        if (self.isChangePINRequest)
        {
            dicStatus  =     [NSDictionary dictionaryWithObjectsAndKeys:@"PINChange",kPINSETTINGSTATUS, nil];
        }
        
        if (self.isDisablePINRequest)
        {
            dicStatus  =     [NSDictionary dictionaryWithObjectsAndKeys:@"PINDisable",kPINSETTINGSTATUS, nil];
        }
        
        if ([[NSUserDefaults standardUserDefaults] boolForKey:kPINENABLE])
        {
            dicStatus  =     [NSDictionary dictionaryWithObjectsAndKeys:@"PINEnable",kPINSETTINGSTATUS, nil];
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:kPINENABLE];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    }
    return dicStatus;
}
-(IBAction)onTapKeys:(id)sender
{
    UIButton *btnKeys = (UIButton *) sender;
    if(isOldPinScreen)
    {
        strOldPIN = [self displayPin:[NSString stringWithFormat:@"%ld",(long)btnKeys.tag]];
    }else if(isConfirmPinScreen)
    {
        strConfirmPIN = [self displayPin:[NSString stringWithFormat:@"%ld",(long)btnKeys.tag]];
    }else
    {
        strPIN = [self displayPin:[NSString stringWithFormat:@"%ld",(long)btnKeys.tag]];
    }
    aTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(onTapFourthPIN) userInfo:nil repeats:NO];
}

-(void)onTapFourthPIN
{
    if(isOldPinScreen)
    {
        if (strOldPIN.length == 4)
        {
            [self validatePin];
            [aTimer invalidate];
        }
    }
    else if(isConfirmPinScreen)
    {
        if (strConfirmPIN.length == 4 && strPIN.length == 4)
        {
            [self validatePin];
            [aTimer invalidate];
        }
    }
    else
    {
        if (strPIN.length == 4)
        {
            if ([[NSUserDefaults standardUserDefaults] valueForKey:kLOGINPIN] && !self.isChangePINRequest)
            {
                [self validatePin];
                [aTimer invalidate];
            }
            else
            {
                isConfirmPinScreen = YES;
                [self resetScreen];
            }
        }
    }
}

-(void)resetScreen
{
    strTempPIN = @"";
    if (isOldPinScreen)
    {
        [self.lblPin setText:[[Utility getLocalizedStrings:@"PinView"] valueForKey:@"OldPin"]];
    }else if(isConfirmPinScreen)
    {
        [self.lblPin setText:[[Utility getLocalizedStrings:@"PinView"] valueForKey:@"ConfirmPin"]];
    }
    else
    {
        [self.lblPin setText:[[Utility getLocalizedStrings:@"PinView"] valueForKey:@"Pin"]];
    }
    [img1 setImage:[UIImage imageNamed:kPINCOUNTCLEARIMAGE]];
    [img2 setImage:[UIImage imageNamed:kPINCOUNTCLEARIMAGE]];
    [img3 setImage:[UIImage imageNamed:kPINCOUNTCLEARIMAGE]];
    [img4 setImage:[UIImage imageNamed:kPINCOUNTCLEARIMAGE]];
}

-(NSString *)displayPin:(NSString *)key
{
    strTempPIN = [NSString stringWithFormat:@"%@%@",strTempPIN,key];
    switch (strTempPIN.length)
    {
        case 1:
            [img1 setImage:[UIImage imageNamed:kPINCOUNTIMAGE]];
            break;
        case 2:
            [img2 setImage:[UIImage imageNamed:kPINCOUNTIMAGE]];
            break;
        case 3:
            [img3 setImage:[UIImage imageNamed:kPINCOUNTIMAGE]];
            break;
        case 4:
            [img4 setImage:[UIImage imageNamed:kPINCOUNTIMAGE]];
            break;
        default:
            break;
    }
    if (strTempPIN.length > 4)
    {
        strTempPIN = [strTempPIN substringToIndex:4];
    }
    return strTempPIN;
}

-(IBAction)onTapClear:(id)sender
{
    switch (strTempPIN.length)
    {
        case 1:
            [img1 setImage:[UIImage imageNamed:kPINCOUNTCLEARIMAGE]];
            break;
        case 2:
            [img2 setImage:[UIImage imageNamed:kPINCOUNTCLEARIMAGE]];
            break;
        case 3:
            [img3 setImage:[UIImage imageNamed:kPINCOUNTCLEARIMAGE]];
            break;
        case 4:
            [img4 setImage:[UIImage imageNamed:kPINCOUNTCLEARIMAGE]];
            break;
        default:
            break;
    }
    if (strTempPIN.length>0)
    {
        strTempPIN = [strTempPIN substringToIndex:[strTempPIN length]-1];
    }
}

-(IBAction)onTapCancel:(id)sender
{
    [kNOTIFICATIONCENTER postNotificationName:PINStateCancelNotification object:nil userInfo:nil];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:kPINENABLE];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[kCOMMONENTITIES navControllerHome] popViewControllerAnimated:YES];
}

@end
