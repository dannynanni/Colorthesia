//
//  BGGViewController.h
//  Colorthesia
//
//  Created by AJ Green on 9/30/14.
//  Copyright (c) 2014 Big Gorilla Games. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BGGViewController : UIViewController <GKGameCenterControllerDelegate>

- (void) startGame;
- (void) showHighScores;

@end
