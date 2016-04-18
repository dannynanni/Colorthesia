//
//  BGGShapeGridViewController.m
//  Colorthesia
//
//  Created by AJ Green on 10/5/14.
//  Copyright (c) 2014 Big Gorilla Games. All rights reserved.
//

#import "BGGShapeGridViewController.h"
#import "BGGShapeCollectionViewCell.h"
#import "BGGApplicationManager.h"
#import "IQIrregularView.h"
#import "UIColor+Matching.h"

#define COLUMN_LENGTH 3
#define ROW_LENGTH 3

@interface BGGShapeGridViewController ()

@property (nonatomic, strong) NSArray *shapes;

@property (nonatomic, strong) NSMutableArray *randomShapes;
@property (nonatomic, strong) NSMutableArray *randomColors;

- (void) randomNumberZeroToTenForArray:(NSMutableArray*)anArray;
- (void) shuffleArray:(NSMutableArray*)anArray;

@end

@implementation BGGShapeGridViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.shapes = [self generateShapeGrid];
    
    [self.collectionView setDelegate:self];
    [self.collectionView setDataSource:self];
    
    [self.collectionView registerClass:[BGGShapeCollectionViewCell class] forCellWithReuseIdentifier:@"Shape"];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake(86.0f, 86.0f)];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    [self.collectionView setCollectionViewLayout:flowLayout];
    
    double delayInSeconds = 1.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self animateInCollectionViewCells];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (void) animateInCollectionViewCells
{
    [self.collectionView setUserInteractionEnabled:NO];
    
    CGFloat delay = 0.2f;
    
    // Animate fade out
    for(int i=0;i<self.collectionView.visibleCells.count;i++)
    {
        double delayInSeconds = 0.5f+(delay*i);
        
        NSInteger random = [[self.randomShapes objectAtIndex:i] integerValue];
        BGGShapeCollectionViewCell *cell = [self.collectionView.visibleCells objectAtIndex:random];
        

        
        [UIView animateWithDuration:1.0f
                              delay:delayInSeconds
                            options:UIViewAnimationOptionAllowUserInteraction
                         animations:^{
                             // Fade in with delay
                             [cell setAlpha:1.0f];
                         } completion:^(BOOL finished)
                            {
                            [[BGGApplicationManager sharedInstance] playPopSoundEffect];
                             if (i==(self.collectionView.visibleCells.count-1))
                             {
                                 [self.collectionView setUserInteractionEnabled:YES];
                             }
                         }];
    }
}

- (NSArray*) generateShapeGrid
{
    self.randomShapes = [[NSMutableArray alloc] initWithArray:@[@0,@1,@2,@3,@4,@5,@6,@7,@8]];
    self.randomColors = [[NSMutableArray alloc] initWithArray:@[@0,@1,@2,@3,@4,@5,@6,@7,@8]];
    
    [self shuffleArray:self.randomShapes];
    [self shuffleArray:self.randomColors];
    
    NSInteger shape = 0;
    
    NSMutableArray *toReturn = [[NSMutableArray alloc] initWithObjects:nil];
    
    for(int i=0;i<COLUMN_LENGTH;i++)
    {
        NSMutableArray *columnArray = [[NSMutableArray alloc] initWithObjects:nil];
        
        for(int j=0;j<ROW_LENGTH;j++)
        {
            BGGIrregularButton *newButton = [BGGUtilities createShape:[[self.randomShapes objectAtIndex:shape] intValue]
                                                       withColorIndex:[[self.randomColors objectAtIndex:shape] intValue]
                                                         andBaseColor:[[BGGApplicationManager sharedInstance] color]];
            
            CGAffineTransform transform = IS_IPHONE_4 ? CGAffineTransformMakeScale(0.65f, 0.65f) :
            CGAffineTransformMakeScale(0.75f, 0.75f);
            
            [newButton setTransform:transform];
            
            [newButton setUserInteractionEnabled:NO];
            
            [columnArray addObject:newButton];
            shape++;
        }
        
        [toReturn addObject:columnArray];
    }
    
    return toReturn;
}

#pragma mark -
#pragma mark - Randomizers
-(void) randomNumberZeroToTenForArray:(NSMutableArray*)anArray
{
    NSInteger randomNumber = (NSInteger) arc4random_uniform(10); // picks between 0 and n-1 where n is 9 in this case, so it will return a result between 0 and 10
    if ([anArray containsObject: [NSNumber numberWithInteger:randomNumber]])
    {
        [self randomNumberZeroToTenForArray:anArray]; // call the method again and get a new object
    }
    else
    {
        if([anArray count] < 9)
        {
            [anArray addObject:[NSNumber numberWithInteger:randomNumber]];
            [self randomNumberZeroToTenForArray:anArray];
        }
    }
}

- (void) shuffleArray:(NSMutableArray*)anArray
{
    NSUInteger count = [anArray count];
    for (NSUInteger i = 0; i < count; ++i) {
        NSInteger remainingCount = count - i;
        NSInteger exchangeIndex = i + arc4random_uniform(remainingCount);
        [anArray exchangeObjectAtIndex:i withObjectAtIndex:exchangeIndex];
    }
}

#pragma mark -
#pragma mark - UICollectionView Datasource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return COLUMN_LENGTH;
}

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return ROW_LENGTH;
}

- (UICollectionViewCell*) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Shape";
    
    BGGShapeCollectionViewCell *cell = (BGGShapeCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier
                                                                                                               forIndexPath:indexPath];
    
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    NSArray *shapesForSection = [self.shapes objectAtIndex:section];
    
    BGGIrregularButton *shapeButton = [shapesForSection objectAtIndex:row];
    IQIrregularView *shape = [shapeButton shape];
    
    // Get that shape's color
    UIColor *shapeColor = [shape backgroundColor];
    
    // Compare to AppManager color
    UIColor *currentGameColor = [[BGGApplicationManager sharedInstance] color];

    [cell setIsCorrectCell:[currentGameColor isEqualToColor:shapeColor]];
    
    [cell addSubview:shapeButton];
    
    [cell setAlpha:0.0f];
    
    return cell;
}

#pragma mark -
#pragma mark - UICollectionView Delegate
- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // Get the current shape
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    NSArray *shapesForSection = [self.shapes objectAtIndex:section];
    BGGIrregularButton *shapeButton = [shapesForSection objectAtIndex:row];
    
    double delayInSeconds = 0.0f;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        // Animate fade out
        for(int i=0;i<self.collectionView.visibleCells.count;i++)
        {
            BGGShapeCollectionViewCell *cell = [self.collectionView.visibleCells objectAtIndex:i];
            
            if(![cell isCorrectCell])
            {
                
                [UILabel beginAnimations:NULL
                                 context:nil];
                [UILabel setAnimationDuration:0.1f];
                [cell setAlpha:0.6f];
                [UILabel commitAnimations];
            }
        }
    });
    
    IQIrregularView *shape = [shapeButton shape];
    
    // Get that shape's color
    UIColor *shapeColor = [shape backgroundColor];
    
    // Compare to AppManager color
    UIColor *currentGameColor = [[BGGApplicationManager sharedInstance] color];
    
    BOOL colorsMatch = ALWAYS_WIN ? YES : [currentGameColor isEqualToColor:shapeColor];
    
    if(self.gridDelegate != nil)
    {
        [self.collectionView setUserInteractionEnabled:NO];
        
        [self.gridDelegate touchedShape:colorsMatch];
    }
    
}




@end
