//
//  TIMLaunchViewModel.m
//  TimeIsMoney
//
//  Created by Seba on 9/1/12.
//  Copyright (c) 2012 Cherry Red SRL. All rights reserved.
//

#import "TIMLaunchViewModel.h"
#import "TIMMeeting.h"

@implementation TIMLaunchViewModel
@synthesize numberOfAttendees=_numberOfAttendees;
@synthesize averageSalary=_averageSalary;


- (id)init {
    self = [super init];
    if (self) {
        self.averageSalary = [TIMMeeting instance].averageSalary;
        self.numberOfAttendees = [TIMMeeting instance].attendees;
    }
    return self;
}

- (void) startMeeting {
    [[TIMMeeting instance] startMeetingWithAttendees: self.numberOfAttendees andAnAverageSalary: self.averageSalary];
}

@end
