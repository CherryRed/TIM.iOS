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
@synthesize viewModel = _viewModel;
@synthesize salary;
@synthesize attendee;
@synthesize time;
@synthesize cost;

-(id) initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder: aDecoder];
    if (self) {
        TIMMeetingViewModel *viewModel = [[TIMMeetingViewModel alloc] init];
        viewModel.delegate = self;
        self.viewModel = viewModel;
        [viewModel release];
    }
    return self;
}

# pragma mark - Life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.salary.text = [NSString stringWithFormat: @"%d", self.viewModel.salary];
    self.attendee.text = [NSString stringWithFormat: @"%d", self.viewModel.attendees];
    self.cost.text = [NSString stringWithFormat: @"$ %d", self.viewModel.cost];
    self.time.text = @"00:00:00";
    
    [self.viewModel start];
}

- (void)viewDidUnload
{
    [self setViewModel: nil];
    [self setSalary:nil];
    [self setAttendee:nil];
    [self setTime:nil];
    [self setCost:nil];
    [super viewDidUnload];
}

- (void)dealloc
{
    [_viewModel release];
    [self.salary release];
    [self.attendee release];
    [self.time release];
    [self.cost release];
    [super dealloc];
}

# pragma mark - Events

- (IBAction)finishTapped:(id)sender {
    [self.viewModel finish];
    [self performSegueWithIdentifier: @"gotoResultsSegue" sender: self];
}

# pragma mark - View Model delegate

- (void) meetingViewModelCostDidChanged:(id<TIMMeetingViewModelDelegate>)viewModel {
    self.cost.text = [NSString stringWithFormat: @"$ %d", [self.viewModel cost]];
    
    NSDateComponents *comps = [self.viewModel duration];
    self.time.text = [NSString stringWithFormat: @"%@%d:%@%d:%@%d", [comps hour] < 10 ? @"0" : @"", [comps hour], [comps minute] < 10 ? @"0" : @"", [comps minute], [comps second] < 10 ? @"0" : @"", [comps second]];
}

@end
