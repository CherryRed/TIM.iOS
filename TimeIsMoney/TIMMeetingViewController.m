//
//  TIMMeetingViewController.m
//  TimeIsMoney
//
//  Created by Seba on 9/1/12.
//  Copyright (c) 2012 Cherry Red SRL. All rights reserved.
//

#import "TIMMeetingViewController.h"
#import "TIMMeetingViewModel.h"
#import "TIMMeeting.h"


@interface TIMMeetingViewController ()

@end

@implementation TIMMeetingViewController
@synthesize viewModel=_viewModel;
@synthesize salary = _salary;
@synthesize attendee = _attendee;
@synthesize time = _time;
@synthesize cost = _cost;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        TIMMeetingViewModel *viewModel = [[TIMMeetingViewModel alloc] init];
        self.viewModel = viewModel;
        [viewModel release];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    TIMMeeting *meeting = [TIMMeeting instance];
    self.salary.text = [NSString stringWithFormat: @"%d", meeting.averageSalary];
    self.attendee.text = [NSString stringWithFormat: @"%d", meeting.attendees];
    self.cost.text = [NSString stringWithFormat: @"%d", meeting.cost];
    self.time.text = @"00:00";
    
}

- (void)viewDidUnload
{
    [self setViewModel: nil];
    [self setSalary:nil];
    [self setAttendee:nil];
    [self setTime:nil];
    [self setCost:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc
{
    [_viewModel release];
    [_salary release];
    [_attendee release];
    [_time release];
    [_cost release];
    [super dealloc];
}

- (IBAction)finishTapped:(id)sender {
    [self performSegueWithIdentifier: @"gotoResultsSegue" sender: self];
}

@end
