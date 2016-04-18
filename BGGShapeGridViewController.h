//
//  BGGShapeGridViewController.h
//  Colorthesia
//
//  Created by AJ Green on 10/5/14.
//  Copyright (c) 2014 Big Gorilla Games. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BGGShapeGridDelegate <NSObject>

- (void) touchedShape:(BOOL)isCorrect;

@end

@interface BGGShapeGridViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic, assign) id<BGGShapeGridDelegate> gridDelegate;

@end
