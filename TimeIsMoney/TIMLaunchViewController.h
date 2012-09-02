//
//  TIMLaunchViewController.h
//  TimeIsMoney
//
//  Created by Seba on 9/1/12.
//  Copyright (c) 2012 Cherry Red SRL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TIMViewController.h"

@class TIMLaunchViewModel;

@interface TIMLaunchViewController : TIMViewController<UITextViewDelegate> {
    TIMLaunchViewModel *_viewModel;
    NSTimer *_keyboardTimer;
}

@property (retain, nonatomic) TIMLaunchViewModel *viewModel;
@property (retain, nonatomic) IBOutlet UISlider *attendeesSlider;
@property (retain, nonatomic) IBOutlet UITextView *attendeesTextView;
@property (retain, nonatomic) IBOutlet UITextView *salaryTextView;
@property (retain, nonatomic) IBOutlet UISlider *salarySlider;

- (IBAction) numberOfAttendeeChanged:(id)sender;
- (IBAction) averageSalaryChanged:(id)sender;

- (IBAction) goTapped:(id)sender;

@end
