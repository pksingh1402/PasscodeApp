

#import <UIKit/UIKit.h>

@interface PinView : UIView<UITextFieldDelegate>{
    IBOutlet UIView *viewDefaultKey;
    IBOutlet UIView *viewCustomKey;
    IBOutlet UIImageView *img1;
    IBOutlet UIImageView *img2;
    IBOutlet UIImageView *img3;
    IBOutlet UIImageView *img4;
    IBOutlet UIButton *btnCancel;

    NSTimer *aTimer;
    NSString *strPIN;
    NSString *strOldPIN;
    NSString *strTempPIN;
    NSString *strConfirmPIN;
    BOOL isOldPinScreen;
    BOOL isConfirmPinScreen;
}

@property (nonatomic,retain) IBOutlet UILabel *lblPin;
@property (nonatomic,assign)BOOL isChangePINRequest;
@property (nonatomic,assign)BOOL isDisablePINRequest;

-(void)validatePin;
-(IBAction)onTapKeys:(id)sender;
-(IBAction)onTapClear:(id)sender;
-(IBAction)onTapCancel:(id)sender;
-(void)setLocalizedStrings;

@end
