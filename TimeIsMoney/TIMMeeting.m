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
@property (assign, nonatomic) NSUInteger cost;

@end

@implementation TIMMeeting
@synthesize attendees=_attendees;
@synthesize averageSalary=_averageSalary;
@synthesize cost=_cost;


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
    self.cost = 0;
    
}

- (void) pause  {
    
}

- (void) resume {
    
}

- (void) finish {
    
}

@end
