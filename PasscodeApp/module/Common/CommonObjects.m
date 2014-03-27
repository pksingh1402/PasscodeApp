
#import "CommonObjects.h"

@implementation CommonObjects
@synthesize navControllerMain;
@synthesize navControllerHome;
@synthesize dicLocalizedStrings;
@synthesize rightsBookMarks;
@synthesize benefitsBookMarks;

static CommonObjects *sharedObject;

+ (CommonObjects*)sharedInstance
{
    if (sharedObject == nil) {
        sharedObject = [[super allocWithZone:NULL] init];
    }
    return sharedObject;
}

@end
