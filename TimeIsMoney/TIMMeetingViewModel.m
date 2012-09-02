//
//  TIMMeetingViewModel.m
//  TimeIsMoney
//
//  Created by Seba on 9/1/12.
//  Copyright (c) 2012 Cherry Red SRL. All rights reserved.
//

#import "TIMMeetingViewModel.h"
#import "TIMMeeting.h"
#import "TIMMeetingViewModelDelegate.h"

#define TIC 1

@interface TIMMeetingViewModel ()

@property (retain, nonatomic) NSTimer *timer;

- (void)tic: (id) sender;

@end

@implementation TIMMeetingViewModel

@synthesize timer;
@synthesize attendees;
@synthesize salary;
@synthesize cost;
@synthesize duration;
@synthesize delegate;

- (id)init
{
    self = [super init];
    if (self) {
        TIMMeeting *meeting = [TIMMeeting instance];
        self.salary = meeting.averageSalary;
        self.attendees = meeting.attendees;
        self.cost = meeting.cost;
    }
    return self;
}

- (void)dealloc
{
    [self.timer release];
    [self.duration release];
    [super dealloc];
}

- (void)start {
    self.timer = [NSTimer scheduledTimerWithTimeInterval: TIC target: self selector: @selector(tic:) userInfo: nil repeats: YES];
}

- (void)finish {
    [self.timer invalidate];
    [[TIMMeeting instance] finishMeeting];
}

- (void)tic: (id) sender {
    self.cost = [[TIMMeeting instance] currentCost];
    self.duration = [TIMMeeting instance].duration;
    
    [self.delegate meetingViewModelCostDidChanged: self];
}

@end
