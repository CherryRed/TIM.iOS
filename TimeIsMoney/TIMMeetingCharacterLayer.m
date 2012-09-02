//
//  TIMMeetingCharacterLayer.m
//  TimeIsMoney
//
//  Created by Hernan on 9/2/12.
//  Copyright (c) 2012 Cherry Red SRL. All rights reserved.
//

#import "TIMMeetingCharacterLayer.h"

@implementation TIMMeetingCharacterLayer

@synthesize sampleIndex;
@synthesize currentAnimation;
@synthesize nextState;

- (void) dealloc
{
    [nextState release];
    nextState = nil;
    
    [super dealloc];
}

#pragma mark - Initialization with an image

+ (id) layerWithImage: (UIImage *) img
{
    return [[[TIMMeetingCharacterLayer alloc] initWithImage: img] autorelease];
}

- (id) initWithImage: (UIImage *) img
{
    self = [super init];
    if (self != nil) {
        self.contents = (id) img.CGImage;
        sampleIndex = 1;
        currentAnimation = TIMAnimationTypeIdle;
        direction = TIMDirectionLeft;
        
        CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath: @"sampleIndex"];
        anim.fromValue = [NSNumber numberWithInt: 1];
        anim.toValue = [NSNumber numberWithInt: 5];
        anim.duration = 1.0f;
        anim.repeatCount = HUGE_VALF;
        [self addAnimation: anim forKey: nil];
    }
    
    return self;
}

#pragma mark - Initialization with an image and a size

+ (id) layerWithImage: (UIImage *) img sampleSize: (CGSize) size
{
    return [[[TIMMeetingCharacterLayer alloc] initWithImage: img sampleSize: size] autorelease];
}

- (id) initWithImage: (UIImage *) img sampleSize: (CGSize) size
{
    self = [self initWithImage: img];
    if (self != nil) {
        CGSize sampleSizeNormalized = CGSizeMake(size.width / CGImageGetWidth(img.CGImage), size.height / CGImageGetHeight(img.CGImage));
        self.bounds = CGRectMake(0, 0, size.width, size.height);
        self.contentsRect = CGRectMake(0, 0, sampleSizeNormalized.width, sampleSizeNormalized.height);
    }
    
    return self;
}

#pragma mark - Configuration

- (void) switchContents: (UIImage *) img
{
    self.contents = (id) img.CGImage;
}

#pragma mark - Frame by frame animation

// redraw the layer only when the sampleIndex or the position properties change
+ (BOOL) needsDisplayForKey: (NSString *) key
{
    return [key isEqualToString: @"sampleIndex"] || [key isEqualToString: @"position"];
}

// avoid default actions for animated properties
+ (id<CAAction>) defaultActionForKey: (NSString *) aKey
{
    if ([aKey isEqualToString: @"contentsRect"] || [aKey isEqualToString: @"bounds"] || [aKey isEqualToString: @"position"]) {
        return (id<CAAction>)[NSNull null];
    }
    
    return [super defaultActionForKey: aKey];
}

- (unsigned int) currentSampleIndex
{
    return ((TIMMeetingCharacterLayer *) [self presentationLayer]).sampleIndex;
}

- (void) display
{
    if ([self.delegate respondsToSelector: @selector(displayLayer:)]) {
        [self.delegate displayLayer: self];
        return;
    }
    
    unsigned int currentSampleIndex = [self currentSampleIndex];
    if (!currentSampleIndex) {
        return;
    }
    
    CGSize sampleSize = self.contentsRect.size;
    
    float offsetX = ((currentSampleIndex - 1) % (int)(1.0 / sampleSize.width)) * sampleSize.width;
    float offsetY = ((currentAnimation) % (int)(1.0 / sampleSize.height)) * sampleSize.height;
    
    self.contentsRect = CGRectMake(offsetX, offsetY, sampleSize.width, sampleSize.height);
}

#pragma mark - Animation control

- (void) setCurrentAnimation: (TIMAnimationType) animationType
{
    currentAnimation = animationType;
    sampleIndex = 1;    // reset the loop
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath: @"position"];
    animation.fromValue = [self valueForKey: @"position"];
    switch (animationType) {
        case TIMAnimationTypeIdle:
            animation.toValue = [NSValue valueWithCGPoint: self.position];
            animation.duration = 2.0f;
            animation.repeatCount = 0;
            break;
            
        case TIMAnimationTypeWalkRight:
            animation.toValue = [NSValue valueWithCGPoint: CGPointMake(720, self.position.y)];
            animation.duration = 4.0f;
            animation.repeatCount = 0;
            direction = TIMDirectionRight;
            
            // update the layer's position so that the layer doesn't snap
            // back to the origin whenthe animation completes
            self.position = CGPointMake(720, self.position.y);
            break;
            
        case TIMAnimationTypeWalkLeft:
            animation.toValue = [NSValue valueWithCGPoint: CGPointMake(480, self.position.y)];
            animation.duration = 4.0f;
            animation.repeatCount = 0;
            direction = TIMDirectionLeft;
            
            // update the layer's position so that the layer doesn't snap
            // back to the origin whenthe animation completes
            self.position = CGPointMake(480, self.position.y);
            break;
            
        case TIMAnimationTypeIdle2:
            animation.toValue = [NSValue valueWithCGPoint: self.position];
            animation.duration = 2.0f;
            animation.repeatCount = 0;
            break;
            
        default:
            break;
    }
    
    [animation setDelegate: self];
    [self addAnimation: animation forKey: @"position"];
}

- (void) animationDidStop: (CAAnimation *) anim finished: (BOOL) flag
{
    int chance = rand() % 100;
    
    if (self.nextState) {
        // there is a new texture. replace the current one
        // before switching animations
        self.contents = (id) self.nextState.CGImage;
        self.nextState = nil;
        self.currentAnimation = TIMAnimationTypeIdle;
    }
    else {
        switch (self.currentAnimation) {
            case TIMAnimationTypeIdle:
                if (chance < 40) {
                    self.currentAnimation = direction == TIMDirectionLeft ? TIMAnimationTypeWalkRight : TIMAnimationTypeWalkLeft;
                }
                else {
                    self.currentAnimation = TIMAnimationTypeIdle2;
                }
                break;
                
            case TIMAnimationTypeIdle2:
                if (chance < 80) {
                    self.currentAnimation = direction == TIMDirectionLeft ? TIMAnimationTypeWalkRight : TIMAnimationTypeWalkLeft;
                }
                else {
                    self.currentAnimation = TIMAnimationTypeIdle;
                }
                break;
                
            case TIMAnimationTypeWalkRight:
            case TIMAnimationTypeWalkLeft:
                self.currentAnimation = chance > 60 ? TIMAnimationTypeIdle : TIMAnimationTypeIdle2;
                break;
                
            default:
                break;
        }
    }
}

@end

