//
//  BGGIrregularButton.m
//  Colorthesia
//
//  Created by AJ Green on 9/30/14.
//  Copyright (c) 2014 Big Gorilla Games. All rights reserved.
//

#import "BGGIrregularButton.h"
#import "IQIrregularView.h"

@interface BGGIrregularButton ()


@end

@implementation BGGIrregularButton

- (id) initWithFrame:(CGRect)frame irregularShape:(IQIrregularView*)aShape andShapeOffset:(CGFloat)anOffset
{
    self = [super initWithFrame:frame];
    
    if(self)
    {
        [self setBackgroundColor:[UIColor clearColor]];
        
        self.shape = aShape;
        [self addSubview:self.shape];
    }
    
    return self;
}

@end
