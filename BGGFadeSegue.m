//
//  BGGFadeSegue.m
//  Colorthesia
//
//  Created by AJ Green on 10/11/14.
//  Copyright (c) 2014 Big Gorilla Games. All rights reserved.
//

#import "BGGFadeSegue.h"

@implementation BGGFadeSegue

- (void) perform
{
    CATransition* transition = [CATransition animation];
    
    transition.duration = 0.6f;
    transition.type = kCATransitionFade;
    
    [[self.sourceViewController navigationController].view.layer addAnimation:transition forKey:kCATransition];
    [[self.sourceViewController navigationController] pushViewController:[self destinationViewController] animated:NO];
}

@end
