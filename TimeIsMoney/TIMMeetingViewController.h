//
//  TIMMeetingViewController.h
//  TimeIsMoney
//
//  Created by Seba on 9/1/12.
//  Copyright (c) 2012 Cherry Red SRL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TIMViewController.h"

@class TIMMeetingViewModel;

@interface TIMMeetingViewController : TIMViewController {
    TIMMeetingViewModel *_viewModel;
}

@property (retain, nonatomic) TIMMeetingViewModel *viewModel;
@property (retain, nonatomic) IBOutlet UILabel *salary;
@property (retain, nonatomic) IBOutlet UILabel *attendee;
@property (retain, nonatomic) IBOutlet UILabel *time;
@property (retain, nonatomic) IBOutlet UILabel *cost;

- (IBAction)finishTapped:(id)sender;

@end
