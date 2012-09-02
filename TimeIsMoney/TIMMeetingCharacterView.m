//
//  TIMMeetingCharacterView.m
//  TimeIsMoney
//
//  Created by Hernan on 9/2/12.
//  Copyright (c) 2012 Cherry Red SRL. All rights reserved.
//

#import "TIMMeetingCharacterView.h"

@implementation TIMMeetingCharacterView

@synthesize characterLayer;

- (id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder: aDecoder];
    if (self) {
        [self configure];
    }
    
    return self;
}

- (id) initWithFrame: (CGRect) frame
{
    self = [super initWithFrame: frame];
    if (self) {
        [self configure];
    }
    
    return self;
}

- (void) configure
{
    srand(time(NULL));
    
    self.characterLayer = [TIMMeetingCharacterLayer layerWithImage: [UIImage imageNamed: @"character.png"] sampleSize: CGSizeMake(256, 256)];
    self.characterLayer.position = CGPointMake(1200, 530);
    self.characterLayer.currentAnimation = TIMAnimationTypeWalkLeft;
    
    [self.layer addSublayer: self.characterLayer];
}

- (void) dealloc
{
    [characterLayer release];
    characterLayer = nil;
    
    [super dealloc];
}

@end
