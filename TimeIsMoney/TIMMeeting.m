//
//  TIMMeeting.m
//  TimeIsMoney
//
//  Created by Seba on 9/1/12.
//  Copyright (c) 2012 Cherry Red SRL. All rights reserved.
//

#import "TIMMeeting.h"

static TIMMeeting *instance = nil;

@interface TIMMeeting ()

@property (assign, nonatomic) NSUInteger attendees;
@property (assign, nonatomic) NSUInteger averageSalary;
@property (assign, nonatomic) float cost;
@property (retain, nonatomic) NSDate *start;
@property (retain, nonatomic) NSDate *end;
@property (retain, nonatomic) NSDateComponents *duration;

@end

@implementation TIMMeeting

@synthesize attendees=_attendees;
@synthesize averageSalary=_averageSalary;
@synthesize cost=_cost;
@synthesize start=_start;
@synthesize end=_end;
@synthesize duration=_duration;

#pragma mark - Singleton

+ (TIMMeeting *) instance {
    @synchronized (self) {
        if (instance == nil) {
            [[self alloc] init];
        }
    }
    return instance;
}

- (void)initialize {
    instance.averageSalary = 3000;
    instance.attendees = 5;
    instance.cost = 0;
    instance.start = [NSDate date];
    instance.end = [NSDate date];
    instance.duration = nil;
}

- (id)init {
    @synchronized(self) {
        [super init];
        [self initialize];
        return self;
    }
}

+ (id)allocWithZone:(NSZone *)zone {
    @synchronized(self) {
        if (instance == nil) {
            instance = [super allocWithZone:zone];
            return instance;
        }
    }
    
    return nil;
}

- (id)copyWithZone:(NSZone *)zone {
    return self;
}

- (oneway void) release {
}

- (id)retain {
    return self;
}

- (id)autorelease {
    return self;
}

- (NSUInteger)retainCount {
    return NSUIntegerMax; // This is sooo not zero
}

#pragma mark - Operations

- (void) startMeetingWithAttendees: (NSUInteger) attendees andAnAverageSalary: (NSUInteger) averageSalary {
    self.attendees = attendees;
    self.averageSalary = averageSalary;
    self.start = [NSDate date];
    self.end = nil;
    self.cost = 0;
    self.duration = nil;
}

- (float) currentCost {
    self.duration = [[NSCalendar currentCalendar] components:NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit fromDate: self.start toDate: [NSDate date] options: 0];

    NSUInteger seconds = [self.duration second] + 60*[self.duration minute] + 3600*[self.duration hour];
    
    self.cost = (seconds * self.attendees * self.averageSalary)/(160*3600.0);
    return self.cost;
}

- (void) finishMeeting {
    self.end = [NSDate date];
    [self currentCost];
}

@end
