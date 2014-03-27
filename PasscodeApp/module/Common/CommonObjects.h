#import <Foundation/Foundation.h>

@interface CommonObjects : NSObject

+ (CommonObjects*)sharedInstance;

@property (strong,nonatomic)NSArray *rightsBookMarks;
@property (strong,nonatomic)NSArray *benefitsBookMarks;
@property (strong,nonatomic)NSDictionary *dicLocalizedStrings;
@property (weak,nonatomic)UINavigationController *navControllerMain;
@property (weak,nonatomic)UINavigationController *navControllerHome;

@end
