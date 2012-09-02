//
//  TIMMeetingCharacterLayer.h
//  TimeIsMoney
//
//  Created by Hernan on 9/2/12.
//  Copyright (c) 2012 Cherry Red SRL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

typedef enum {
    TIMAnimationTypeIdle = 0,
    TIMAnimationTypeWalkRight = 1,
    TIMAnimationTypeWalkLeft = 2,
    TIMAnimationTypeIdle2 = 3
} TIMAnimationType;

typedef enum {
    TIMDirectionLeft,
    TIMDirectionRight
} TIMDirection;

@interface TIMMeetingCharacterLayer : CALayer {
    unsigned int sampleIndex;
    TIMAnimationType currentAnimation;
    TIMDirection direction;
    UIImage *nextState;
}

@property (readwrite, nonatomic) unsigned int sampleIndex;
@property (readwrite, nonatomic) TIMAnimationType currentAnimation;
@property (nonatomic, retain) UIImage *nextState;

+ (id) layerWithImage: (UIImage *) img;
- (id) initWithImage: (UIImage *) img;

+ (id) layerWithImage:(UIImage *) img sampleSize: (CGSize) size;
- (id) initWithImage:(UIImage *) img sampleSize: (CGSize) size;

- (void) setNextState: (UIImage *) nextState;

- (unsigned int) currentSampleIndex;

@end

