//
//  BGGGameBoardViewController.h
//  Colorthesia
//
//  Created by AJ Green on 10/8/14.
//  Copyright (c) 2014 Big Gorilla Games. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BGGShapeGridViewController.h"

@interface BGGGameBoardViewController : UIViewController <BGGShapeGridDelegate>

@property (nonatomic, weak) IBOutlet UILabel *score;
@property (nonatomic, weak) IBOutlet UILabel *highScore;
@property (nonatomic, weak) IBOutlet UILabel *result;


@end
