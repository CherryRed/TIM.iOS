//
//  TIMLaunchViewController.m
//  TimeIsMoney
//
//  Created by Seba on 9/1/12.
//  Copyright (c) 2012 Cherry Red SRL. All rights reserved.
//

#import "TIMLaunchViewController.h"
#import "TIMLaunchViewModel.h"
#import "TIMMeetingViewController.h"
#import "TIMMeeting.h"

@interface TIMLaunchViewController ()

@property (retain, nonatomic) NSTimer *keyboardTimer;

- (void) scheduleTimer: (UITextField *) textField;
- (void) textDidChanged: (id) sender;
- (void) populateAverageSalary;
- (void) populateNumberOfAttendees;

@end

@implementation TIMLaunchViewController
@synthesize attendeesSlider;
@synthesize attendeesTextView;
@synthesize salaryTextView;
@synthesize salarySlider;
@synthesize viewModel=_viewModel;
@synthesize textViewAccessoryView;
@synthesize keyboardTimer=_keyboardTimer;


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    TIMLaunchViewModel *viewModel = [[TIMLaunchViewModel alloc] init];
    self.viewModel = viewModel;
    [viewModel release];
    
    CGAffineTransform trans = CGAffineTransformMakeRotation(-M_PI * 0.5);
    self.attendeesSlider.transform = trans;
    self.salarySlider.transform = trans;

    
    self.salarySlider.maximumValue = MEETING_MAX_AVG_SALARY;
    self.attendeesSlider.maximumValue = MEETING_MAX_ATTENDEE;
    
    [self populateAverageSalary];
    [self populateNumberOfAttendees];
    
    self.attendeesTextView.inputAccessoryView = self.textViewAccessoryView;
    self.salaryTextView.inputAccessoryView = self.textViewAccessoryView;
    

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
    [self setTextViewAccessoryView:nil];
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
    [textViewAccessoryView release];
    [super dealloc];
}

- (IBAction)averageSalaryChanged:(id)sender {
    if (sender == self.salaryTextView) {
        self.viewModel.averageSalary = [self.salaryTextView.text intValue];
    } else if (sender == self.salarySlider) {
        self.viewModel.averageSalary = self.salarySlider.value;
    }
    [self populateAverageSalary];
}

- (IBAction)goTapped:(id)sender {
    [self performSegueWithIdentifier: @"gotoMeetingSegue" sender: self];
}

- (IBAction)dismissKeyboard:(id)sender {
    [self.attendeesTextView resignFirstResponder];
    [self.salaryTextView resignFirstResponder];
}

- (IBAction)numberOfAttendeeChanged:(id)sender {
    if (sender == self.attendeesTextView) {
        self.viewModel.numberOfAttendees = [self.attendeesTextView.text intValue];
    } else if (sender == self.attendeesSlider) {
        self.viewModel.numberOfAttendees = self.attendeesSlider.value;
    }
    [self populateNumberOfAttendees];
}

- (void) populateAverageSalary {
    self.salaryTextView.text = [NSString stringWithFormat: @"%d", self.viewModel.averageSalary];
    self.salarySlider.value = self.viewModel.averageSalary;
}

- (void) populateNumberOfAttendees {
    self.attendeesTextView.text = [NSString stringWithFormat: @"%d", self.viewModel.numberOfAttendees];
    self.attendeesSlider.value = self.viewModel.numberOfAttendees;
}


- (void) scheduleTimer: (UITextView *) textField {
    if (self.keyboardTimer != nil) {
        [self.keyboardTimer invalidate];
    }
    self.keyboardTimer = [NSTimer scheduledTimerWithTimeInterval: .5f target: self selector: @selector(textDidChanged:) userInfo:textField repeats:NO];
}

- (void) textDidChanged: (id) sender {
    UITextField *textField = ((NSTimer *)sender).userInfo;
    if (textField == self.attendeesTextView) {
        [self numberOfAttendeeChanged: textField];
    } else if (textField == self.salaryTextView) {
        [self averageSalaryChanged: textField];
    }
    self.keyboardTimer = nil;
}

- (BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    [self scheduleTimer: textField];
    NSCharacterSet *validCharacterSet = [NSCharacterSet characterSetWithCharactersInString:@".0123456789"];
    
    BOOL shouldChange =
    [string length] == 0 || // deletion
    [string rangeOfCharacterFromSet:validCharacterSet].location != NSNotFound;

    return shouldChange;
}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    [theTextField resignFirstResponder];
    return YES;
}

@end
