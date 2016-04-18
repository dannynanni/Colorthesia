//
//  BGGAudioPlayerPool.h
//  Colorthesia
//
//  Created by AJ Green on 1/9/15.
//  Copyright (c) 2015 Big Gorilla Games. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BGGAudioPlayerPool : NSObject

+ (AVAudioPlayer *)playerWithURL:(NSURL *)url;

@end
