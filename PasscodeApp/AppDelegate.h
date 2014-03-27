//
//  AppDelegate.h
//  PasscodeApp
//
//  Created by Nawal Panday on 07/03/14.
//  Copyright (c) 2014 Icreon Communication Pvt. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HomeViewController;
@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    HomeViewController *homeViewController;
}

@property (strong, nonatomic) UIWindow *window;
-(void)setPinView;
@end
