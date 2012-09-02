//
//  TIMMeetingViewModelDelegate.h
//  TimeIsMoney
//
//  Created by Seba on 9/2/12.
//  Copyright (c) 2012 Cherry Red SRL. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TIMMeetingViewModel;

@protocol TIMMeetingViewModelDelegate <NSObject>

- (void) meetingViewModelCostDidChanged: (TIMMeetingViewModel*) viewModel;

@end