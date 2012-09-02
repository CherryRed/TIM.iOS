//
//  TIMMeetingViewModel.h
//  TimeIsMoney
//
//  Created by Seba on 9/1/12.
//  Copyright (c) 2012 Cherry Red SRL. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TIMMeetingViewModelDelegate;

@interface TIMMeetingViewModel : NSObject

@property (assign, nonatomic) id<TIMMeetingViewModelDelegate> delegate;
@property (assign, nonatomic) NSUInteger attendees;
@property (assign, nonatomic) NSUInteger salary;
@property (assign, nonatomic) NSUInteger cost;
@property (retain, nonatomic) NSDateComponents *duration;

- (NSUInteger) cost;
- (NSDateComponents*) duration;

- (void)start;
- (void)finish;

@end