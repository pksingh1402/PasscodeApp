
enum  Device{
    Iphone=0,
    Iphone5=1,
    Ipad=2
};  

#define kLOGINPIN           @"LOGINPIN"
#define kLOGINPINSTATUS     @"LOGINPINSTATUS"
#define kPINENABLE          @"PINENABLE"
#define  kPINSETTINGSTATUS  @"PINSETTINGSTATUS"

#define kALERTCOLORRED      255.0/255.0f
#define kALERTCOLORGREEN    0.0/255.0f
#define kALERTCOLORBLUE     0.0/255.0f

#define kMESSAGECOLORRED    90.0/255.0f
#define kMESSAGECOLORGREEN  255.0/255.0f
#define kMESSAGECOLORBLUE   190.0/255.0f

#define kPOPUPCOLORRED      0.0/255.0f
#define kPOPUPCOLORGREEN    0.0/255.0f
#define kPOPUPCOLORBLUE     255.0/255.0f

#define kTIMEOUTPERIOD      2.0
#define kANIMATIONDURATION  0.5

#define kPINCOUNTIMAGE      @"dot_solid.png"
#define kPINCOUNTCLEARIMAGE @"dot_outline.png"

#define PINStateChangeNotification @"PinStateChangeNotification"
#define PINStateCancelNotification @"PinStateCancelNotification"

#define kSTANDARDUSERDEFAULT [NSUserDefaults standardUserDefaults]
#define kUIAPPDELEGATE      (AppDelegate *)[[UIApplication sharedApplication] delegate]
#define kCOMMONENTITIES     (CommonObjects *)[CommonObjects sharedInstance]
#define kNOTIFICATIONCENTER [NSNotificationCenter defaultCenter]