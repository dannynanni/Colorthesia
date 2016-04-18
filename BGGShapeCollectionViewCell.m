//
//  BGGShapeCollectionViewCell.m
//  Colorthesia
//
//  Created by AJ Green on 10/5/14.
//  Copyright (c) 2014 Big Gorilla Games. All rights reserved.
//

#import "BGGShapeCollectionViewCell.h"

@implementation BGGShapeCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        // Initialization code
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"BGGShapeCollectionViewCell" owner:self options:nil];
        
        if ([arrayOfViews count] < 1) {
            return nil;
        }
        
        if (![[arrayOfViews objectAtIndex:0] isKindOfClass:[UICollectionViewCell class]]) {
            return nil;
        }
        
        self = [arrayOfViews objectAtIndex:0];
        
    }
    
    return self;
    
}

@end
