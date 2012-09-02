//
//  TIMMeeting.h
//  TimeIsMoney
//
//  Created by Seba on 9/1/12.
//  Copyright (c) 2012 Cherry Red SRL. All rights reserved.
//

#import <Foundation/Foundation.h>

#define MEETING_MAX_ATTENDEE        25
#define MEETING_MAX_AVG_SALARY      3000
#define MEETING_MAX_AVG_SALARY_STEP 100


@interface TIMMeeting : NSObject {
    NSUInteger _attendees;
    NSUInteger _averageSalary;
    NSUInteger _cost;
}

+ (TIMMeeting *) instance;

- (void) startMeetingWithAttendees: (NSUInteger) attendees andAnAverageSalary: (NSUInteger) averageSalary;
- (void) pause;
- (void) resume;
- (void) finish;

- (NSUInteger) attendees;
- (NSUInteger) averageSalary;
- (NSUInteger) cost;



@end
