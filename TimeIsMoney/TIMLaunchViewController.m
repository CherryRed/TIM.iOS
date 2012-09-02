//
//  TIMLaunchViewController.m
//  TimeIsMoney
//
//  Created by Seba on 9/1/12.
//  Copyright (c) 2012 Cherry Red SRL. All rights reserved.
//

#import "TIMLaunchViewController.h"
#import "TIMLaunchViewModel.h"
#import "TIMMeeting.h"

@interface TIMLaunchViewController ()

@property (retain, nonatomic) NSTimer *keyboardTimer;

- (void) populateAverageSalary;
- (void) populateNumberOfAttendees;
- (void) dismissKeyboard:(id)sender;

@end

@implementation TIMLaunchViewController
@synthesize attendeesSlider;
@synthesize attendeesTextView;
@synthesize salaryTextView;
@synthesize salarySlider;
@synthesize viewModel=_viewModel;

#pragma mark - lifecycle

-(id) initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder: aDecoder];
    if (self) {
        TIMLaunchViewModel *viewModel = [[TIMLaunchViewModel alloc] init];
        self.viewModel = viewModel;
        [viewModel release];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGAffineTransform trans = CGAffineTransformMakeRotation(-M_PI * 0.5);
    self.attendeesSlider.transform = trans;
    self.salarySlider.transform = trans;
    
    self.salarySlider.maximumValue = MEETING_MAX_AVG_SALARY / MEETING_MAX_AVG_SALARY_STEP;
    self.attendeesSlider.maximumValue = MEETING_MAX_ATTENDEE;
    
    [self populateAverageSalary];
    [self populateNumberOfAttendees];

}

- (void)viewDidUnload
{
    [self.keyboardTimer invalidate];
    [self setKeyboardTimer: nil];
    
    [self setSalarySlider:nil];
    [self setAttendeesSlider:nil];
    [self setViewModel:nil];
    
    [self setAttendeesTextView:nil];
    [self setSalaryTextView:nil];
    [super viewDidUnload];
    
    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;    
}

- (void)dealloc {
    
    [self.keyboardTimer invalidate];
    [_keyboardTimer release];
    [_viewModel release];
    [salarySlider release];
    [attendeesSlider release];
    [attendeesTextView release];
    [salaryTextView release];

    [super dealloc];
}

#pragma mark - event handling 

- (IBAction)averageSalaryChanged:(id)sender {
    if (sender == self.salaryTextView) {
        self.viewModel.averageSalary = [self.salaryTextView.text intValue];
    } else if (sender == self.salarySlider) {
        self.viewModel.averageSalary = round(self.salarySlider.value) * MEETING_MAX_AVG_SALARY_STEP;
    }
    [self populateAverageSalary];
}

- (IBAction)goTapped:(id)sender {
    [self.viewModel startMeeting];
    [self performSegueWithIdentifier: @"gotoMeetingSegue" sender: self];
}


- (IBAction)numberOfAttendeeChanged:(id)sender {
    if (sender == self.attendeesTextView) {
        self.viewModel.numberOfAttendees = [self.attendeesTextView.text intValue];
    } else if (sender == self.attendeesSlider) {
        self.viewModel.numberOfAttendees = self.attendeesSlider.value;
    }
    [self populateNumberOfAttendees];
}


#pragma mark - UITextViewDelegate

- (void) textViewDidChange:(UITextView *)textView {
    if (textView == self.attendeesTextView) {
        [self numberOfAttendeeChanged: textView];
    } else if (textView == self.salaryTextView) {
        [self averageSalaryChanged: textView];
    }
    self.keyboardTimer = nil;
}

- (BOOL) textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    NSCharacterSet *validCharacterSet = [NSCharacterSet characterSetWithCharactersInString:@".0123456789"];
    NSCharacterSet *returnCharacterSet = [NSCharacterSet characterSetWithCharactersInString:@"\n"];

    BOOL hasReturn = [text rangeOfCharacterFromSet:returnCharacterSet].location != NSNotFound;
    if (hasReturn) {
        [self dismissKeyboard:textView];
        return NO;
    }
    
    BOOL shouldChange =
    [text length] == 0 || // deletion
    [text rangeOfCharacterFromSet:validCharacterSet].location != NSNotFound;
        
    return shouldChange;
}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    [theTextField resignFirstResponder];
    return YES;
}

#pragma mark - private

- (void)dismissKeyboard:(id)sender {
    [self.attendeesTextView resignFirstResponder];
    [self.salaryTextView resignFirstResponder];
}

- (void) populateAverageSalary {
    self.salaryTextView.text = [NSString stringWithFormat: @"%d", self.viewModel.averageSalary];
    self.salarySlider.value = round(self.viewModel.averageSalary / MEETING_MAX_AVG_SALARY_STEP);
}

- (void) populateNumberOfAttendees {
    self.attendeesTextView.text = [NSString stringWithFormat: @"%d", self.viewModel.numberOfAttendees];
    self.attendeesSlider.value = self.viewModel.numberOfAttendees;
}



@end
