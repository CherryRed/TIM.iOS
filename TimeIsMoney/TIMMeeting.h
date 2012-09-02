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
    NSDate *_start;
    NSDate *_end;
    NSDateComponents *_duration;
}

+ (TIMMeeting *) instance;

- (void) startMeetingWithAttendees: (NSUInteger) attendees andAnAverageSalary: (NSUInteger) averageSalary;
- (void) finishMeeting;

- (NSUInteger) attendees;
- (NSUInteger) averageSalary;
- (NSUInteger) cost;
- (NSDate*) start;
- (NSDate*) end;
- (NSDateComponents*) duration;

- (NSUInteger) currentCost;

@end
