//
//  TIMLaunchViewModel.h
//  TimeIsMoney
//
//  Created by Seba on 9/1/12.
//  Copyright (c) 2012 Cherry Red SRL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TIMLaunchViewModel : NSObject {
        
}

@property (assign, nonatomic) NSInteger numberOfAttendees;
@property (assign, nonatomic) NSInteger averageSalary;

- (void) startMeeting;

@end
