//
//  TIMAppDelegate.h
//  TimeIsMoney
//
//  Created by Seba on 9/1/12.
//  Copyright (c) 2012 Cherry Red SRL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TIMLaunchViewController.h"

@interface TIMAppDelegate : UIResponder <UIApplicationDelegate> {
    TIMLaunchViewController *_launchViewController;
}

@property (retain, nonatomic) UIWindow *window;
@property (retain, nonatomic) TIMLaunchViewController *launchViewController;

@end
