//
//  BGGAudioPlayerPool.m
//  Colorthesia
//
//  Created by AJ Green on 1/9/15.
//  Copyright (c) 2015 Big Gorilla Games. All rights reserved.
//

#import "BGGAudioPlayerPool.h"

NSMutableArray* _players = nil;

@implementation BGGAudioPlayerPool

+ (NSMutableArray*) players {
    if (_players == nil)
        _players = [[NSMutableArray alloc] init];
    
    return _players;
}

+ (AVAudioPlayer *)playerWithURL:(NSURL *)url {
    NSMutableArray* availablePlayers = [[self players] mutableCopy];
    
    // Try and find a player that can be reused and is not playing
    [availablePlayers filterUsingPredicate:[NSPredicate
                                            predicateWithBlock:^BOOL(AVAudioPlayer* evaluatedObject,NSDictionary *bindings) {
                                                return evaluatedObject.playing == NO && [evaluatedObject.url
                                                                                         isEqual:url];
                                            }]];
    
    // If we found one, return it
    if (availablePlayers.count > 0) {
        return [availablePlayers firstObject];
    }
    
    // Didn't find one? Create a new one
    NSError* error = nil;
    AVAudioPlayer* newPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url
                                                                      error:&error];
    
    if (newPlayer == nil) {
        NSLog(@"Couldn't load %@: %@", url, error);
        return nil;
    }
    
    [[self players] addObject:newPlayer];
    
    return newPlayer;
    
}


@end
