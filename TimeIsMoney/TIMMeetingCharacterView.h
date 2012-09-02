//
//  TIMMeetingCharacterView.h
//  TimeIsMoney
//
//  Created by Hernan on 9/2/12.
//  Copyright (c) 2012 Cherry Red SRL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TIMMeetingCharacterLayer.h"

@interface TIMMeetingCharacterView : UIView {
    TIMMeetingCharacterLayer *characterLayer;
}

@property (nonatomic, retain) TIMMeetingCharacterLayer *characterLayer;

@end
