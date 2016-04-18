//
//  BGGUtilities.m
//  Colorthesia
//
//  Created by AJ Green on 9/30/14.
//  Copyright (c) 2014 Big Gorilla Games. All rights reserved.
//

#import "BGGUtilities.h"
#import "BGGIrregularButton.h"
#import "IQIrregularView.h"

@interface BGGUtilities ()



+ (BGGIrregularButton*) buttonWithFrame:(CGRect)aFrame
                                  shape:(IQIrregularView*)aShape
                                  image:(UIImage*)anImage
                                 target:(id)aTarget
                              andAction:(SEL)anAction;

+ (BGGIrregularButton*) buttonWithFrame:(CGRect)aFrame
                                  shape:(IQIrregularView*)aShape
                                  title:(NSString*)aTitle
                                 target:(id)aTarget
                              andAction:(SEL)anAction;

+ (BGGIrregularButton*) buttonWithFrame:(CGRect)aFrame
                                  shape:(IQIrregularView*)aShape
                                 target:(id)aTarget
                              andAction:(SEL)anAction;

+ (NSArray*) arrayForShape:(ShapeType)aShape;

+ (IQIrregularView*) createShape:(ShapeType)aShape withColor:(UIColor*)aColor;

+ (IQIrregularView*) createCircleWithColor:(UIColor*)aColor andFrame:(CGRect)aFrame;
+ (IQIrregularView*) createYellowColoredCircleWithFrame:(CGRect)aFrame;
+ (IQIrregularView*) createSquareWithColor:(UIColor*)aColor;
+ (IQIrregularView*) createYellowColoredSquare;
+ (IQIrregularView*) createTriangleWithColor:(UIColor*)aColor;
+ (IQIrregularView*) createYellowColoredTriangle;
+ (IQIrregularView*) createYellowColoredPentagon;
+ (IQIrregularView*) createPentagonWithColor:(UIColor*)aColor;
+ (IQIrregularView*) createYellowColoredOctagon;
+ (IQIrregularView*) createOctagonWithColor:(UIColor*)aColor;
+ (IQIrregularView*) createYellowColoredDecagon;
+ (IQIrregularView*) createDecagonWithColor:(UIColor*)aColor;
+ (IQIrregularView*) createYellowColoredStar;
+ (IQIrregularView*) createStarWithColor:(UIColor*)aColor;
+ (IQIrregularView*) createYellowColoredFreakStar;
+ (IQIrregularView*) createFreakStarWithColor:(UIColor*)aColor;

+ (UIColor*) colorByAdjustingBaseColor:(UIColor*)aBaseColor byRed:(CGFloat)aRed green:(CGFloat)aGreen blue:(CGFloat)aBlue;
+ (UIColor*) colorByAdjustingBaseColor:(UIColor*)aBaseColor byRed:(CGFloat)aRed green:(CGFloat)aGreen blue:(CGFloat)aBlue andAlpha:(CGFloat)anAlpha;
+ (CGFloat) properColor:(CGFloat)aColor;

@end

@implementation BGGUtilities

#pragma mark -
#pragma mark - Tutorial Helpers
+ (BOOL) shouldShowTutorial
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    NSObject *object = [prefs objectForKey:PREF_TUTORIAL_KEY];
    
    return (object == nil) ? YES : [prefs boolForKey:PREF_TUTORIAL_KEY];
}

+ (void) setVersionNumber
{
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:VERSION_KEY];
    [[NSUserDefaults standardUserDefaults] setObject:version forKey:PREF_VERSION_KEY];
}

+ (void) saveTutorialPreferenceSelection:(BOOL)shouldShowNextTime
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    [prefs setBool:shouldShowNextTime forKey:PREF_TUTORIAL_KEY];
    
    [prefs synchronize];
}

#pragma mark - High Score
+ (void) saveHighScore:(NSInteger)aHighScore
{
    NSInteger currentHighScore = [BGGUtilities retrieveHighScore];
    
    if (aHighScore > currentHighScore)
    {
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:aHighScore]
                                                  forKey:HIGH_SCORE_KEY];
    }
}

+ (NSInteger) retrieveHighScore
{
    return [[[NSUserDefaults standardUserDefaults] objectForKey:HIGH_SCORE_KEY] integerValue];
}

#pragma mark -
#pragma mark - Font Helpers

+ (UIFont*) systemFontOfSize:(CGFloat)aSize
{
    return [UIFont fontWithName:@"Quicksand-Light"
                           size:aSize];
}

#pragma mark -
#pragma mark - Button Helpers

+ (BGGIrregularButton*) createShape:(ShapeType)aShapeType withColorIndex:(NSInteger)aColorIndex andBaseColor:(UIColor*)aColor
{
    CGRect buttonFrame = CGRectMake(0.0f, 0.0f, 76.0f, 76.0f);
    
    BGGIrregularButton *toReturn = [self buttonWithFrame:buttonFrame
                                                   shape:[BGGUtilities createShape:aShapeType
                                                                               withColor:[BGGUtilities colorVariationsForIndex:aColorIndex
                                                                                                                  andBaseColor:aColor]]
                                                   image:nil
                                                  target:nil
                                               andAction:nil];
    
    return toReturn;
}

+ (BGGIrregularButton*) centerOrientedOvalButtonForView:(UIView*)aView
                                              withTitle:(NSString*)aTitle
                                                  color:(UIColor*)aColor
                                                 target:(id)aTarget
                                              andAction:(SEL)anAction
{
    
    CGRect buttonFrame = CGRectMake(0.0f, 0.0f, 176.0f, 185.0f);
    CGRect shapeFrame = CGRectMake(0.0f, 0.0f, 176.0f, 185.0f);
    
    
    BGGIrregularButton *toReturn = [self buttonWithFrame:buttonFrame
                                                   shape:[BGGUtilities createCircleWithColor:aColor
                                                                                    andFrame:shapeFrame]
                                                   title:aTitle
                                                  target:aTarget
                                               andAction:anAction];
    
    [toReturn setAlpha:0.0f];
    [toReturn setCenter:aView.center];
    
    return toReturn;
}

+ (BGGIrregularButton*) bottomOrientedOvalButtonForView:(UIView*)aView
                                              withImage:(UIImage*)anImage
                                                  color:(UIColor*)aColor
                                                 target:(id)aTarget
                                              andAction:(SEL)anAction
{
    CGRect buttonFrame = CGRectMake(0.0f, 0.0f, 110.0f, 110.0f);
    CGRect shapeFrame = CGRectMake(0.0f, 0.0f, 110.0f, 110.0f);
    
    BGGIrregularButton *toReturn =  [self buttonWithFrame:buttonFrame
                                                    shape:[BGGUtilities createCircleWithColor:aColor
                                                                                     andFrame:shapeFrame]
                                                    image:anImage
                                                   target:aTarget
                                                andAction:anAction];
    
    [toReturn setAlpha:0.0f];
    [toReturn setCenter:CGPointMake(aView.center.x, aView.frame.size.height)];
    [toReturn setContentEdgeInsets:UIEdgeInsetsMake(0, 0, 50, 0)];
    
    
    return toReturn;
}

+ (BGGIrregularButton*) bottomOrientedOvalButtonForView:(UIView*)aView
                                              withTitle:(NSString*)aTitle
                                                  color:(UIColor*)aColor
                                                 target:(id)aTarget
                                              andAction:(SEL)anAction
{
    CGRect buttonFrame = CGRectMake(0.0f, 0.0f, 110.0f, 110.0f);
    CGRect shapeFrame = CGRectMake(0.0f, 0.0f, 110.0f, 110.0f);
    
    BGGIrregularButton *toReturn =  [self buttonWithFrame:buttonFrame
                                                    shape:[BGGUtilities createCircleWithColor:aColor
                                                                                     andFrame:shapeFrame]
                                                    title:aTitle
                                                   target:aTarget
                                                andAction:anAction];
    
    [toReturn setAlpha:0.0f];
    [toReturn setCenter:CGPointMake(aView.center.x, aView.frame.size.height)];
    [toReturn setContentEdgeInsets:UIEdgeInsetsMake(0, 0, 50, 0)];
    
    
    return toReturn;
}


+ (BGGIrregularButton*) buttonWithFrame:(CGRect)aFrame
                                  shape:(IQIrregularView*)aShape
                                  image:(UIImage*)anImage
                                 target:(id)aTarget
                              andAction:(SEL)anAction
{
    BGGIrregularButton *toReturn = [BGGUtilities buttonWithFrame:aFrame
                                                           shape:aShape
                                                          target:aTarget
                                                       andAction:anAction];
    
    [toReturn setImage:anImage
              forState:UIControlStateNormal];
    [toReturn bringSubviewToFront:[toReturn imageView]];
    
    return toReturn;
}

+ (BGGIrregularButton*) buttonWithFrame:(CGRect)aFrame
                                  shape:(IQIrregularView*)aShape
                                  title:(NSString*)aTitle
                                 target:(id)aTarget
                              andAction:(SEL)anAction
{
    BGGIrregularButton *toReturn = [BGGUtilities buttonWithFrame:aFrame
                                                           shape:aShape
                                                          target:aTarget
                                                       andAction:anAction];
    
    [[toReturn titleLabel] setFont:[BGGUtilities systemFontOfSize:55.0f]];
    [toReturn setTitle:aTitle
              forState:UIControlStateNormal];
    
    return toReturn;
}

+ (BGGIrregularButton*) buttonWithFrame:(CGRect)aFrame
                                  shape:(IQIrregularView*)aShape
                                 target:(id)aTarget
                              andAction:(SEL)anAction
{
    BGGIrregularButton *toReturn = [[BGGIrregularButton alloc] initWithFrame:aFrame
                                                              irregularShape:aShape
                                                              andShapeOffset:0.0f];
    [toReturn addTarget:aTarget
                 action:anAction
       forControlEvents:UIControlEventTouchUpInside];
    
    return toReturn;
}

+ (UIButton*) playButtonForView:(UIView*)aView target:(id)aTarget andAction:(SEL)anAction
{
    CGRect buttonFrame = CGRectMake(0.0f, 0.0f, 185.0f, 185.0f);
    
    UIButton *toReturn = [UIButton buttonWithType:UIButtonTypeCustom];
    [toReturn setFrame:buttonFrame];
    
    [toReturn setAdjustsImageWhenHighlighted:NO];
    
    [toReturn setBackgroundImage:[UIImage imageNamed:@"play"]
                        forState:UIControlStateNormal];
    
    [toReturn addTarget:aTarget
                 action:anAction
       forControlEvents:UIControlEventTouchUpInside];
    
    [toReturn setAlpha:0.0f];
    [toReturn setCenter:aView.center];
    
    return toReturn;
}

#pragma mark -
#pragma mark - Color Helpers
+ (UIColor*) randomColor
{
    CGFloat randomRed = (arc4random_uniform(256)/255.0f);
    CGFloat randomGreen = (arc4random_uniform(256)/255.0f);
    CGFloat randomBlue = (arc4random_uniform(256)/255.0f);
    
    return [UIColor colorWithRed:randomRed
                           green:randomGreen
                            blue:randomBlue
                           alpha:1.0f];
}

+ (UIColor*) mainMenuYellow
{
    return [UIColor colorWithRed:(241.0f/255.0f)
                           green:(200.0f/255.0f)
                            blue:(47.0f/255.0f)
                           alpha:1.0f];
}

+ (UIColor*) restartGray
{
    return [UIColor colorWithRed:(109.0f/255.0f)
                           green:(110.0f/255.0f)
                            blue:(112.0f/255.0f)
                           alpha:1.0f];
}


+ (UIColor*) colorVariationsForIndex:(NSInteger)anIndex andBaseColor:(UIColor*)aBaseColor
{
    switch (anIndex)
    {
        case 0:
            return aBaseColor;
        case 1:
            return [BGGUtilities colorByAdjustingBaseColor:aBaseColor
                                                     byRed:[BGGUtilities properColor:-8]
                                                     green:[BGGUtilities properColor:2]
                                                      blue:[BGGUtilities properColor:40]];
        case 2:
            return [BGGUtilities colorByAdjustingBaseColor:aBaseColor
                                                     byRed:[BGGUtilities properColor:-56]
                                                     green:0
                                                      blue:0];
        case 3:
            return [BGGUtilities colorByAdjustingBaseColor:aBaseColor
                                                     byRed:0
                                                     green:[BGGUtilities properColor:15]
                                                      blue:[BGGUtilities properColor:20]];
        case 4:
            return [BGGUtilities colorByAdjustingBaseColor:aBaseColor
                                                     byRed:[BGGUtilities properColor:-9]
                                                     green:[BGGUtilities properColor:-12]
                                                      blue:0];
        case 5:
            return [BGGUtilities colorByAdjustingBaseColor:aBaseColor
                                                     byRed:[BGGUtilities properColor:-12]
                                                     green:[BGGUtilities properColor:-48]
                                                      blue:[BGGUtilities properColor:8]];
        case 6:
            return [BGGUtilities colorByAdjustingBaseColor:aBaseColor
                                                     byRed:0
                                                     green:[BGGUtilities properColor:16]
                                                      blue:[BGGUtilities properColor:10]];
        case 7:
            return [BGGUtilities colorByAdjustingBaseColor:aBaseColor
                                                     byRed:[BGGUtilities properColor:8]
                                                     green:[BGGUtilities properColor:61]
                                                      blue:[BGGUtilities properColor:16]];
        case 8:
            return [BGGUtilities colorByAdjustingBaseColor:aBaseColor
                                                     byRed:0
                                                     green:[BGGUtilities properColor:29]
                                                      blue:[BGGUtilities properColor:36]];
        case 9:
            return [BGGUtilities colorByAdjustingBaseColor:aBaseColor
                                                     byRed:0
                                                     green:0
                                                      blue:0
                                                  andAlpha:0.80f];
        default:
            return [BGGUtilities colorByAdjustingBaseColor:aBaseColor
                                                     byRed:0
                                                     green:0
                                                      blue:0
                                                  andAlpha:0.80f];
    }
}

+ (UIColor*) colorByAdjustingBaseColor:(UIColor*)aBaseColor byRed:(CGFloat)aRed green:(CGFloat)aGreen blue:(CGFloat)aBlue
{
    return [BGGUtilities colorByAdjustingBaseColor:aBaseColor byRed:aRed green:aGreen blue:aBlue andAlpha:1.0f];
}

+ (UIColor*) colorByAdjustingBaseColor:(UIColor*)aBaseColor byRed:(CGFloat)aRed green:(CGFloat)aGreen blue:(CGFloat)aBlue andAlpha:(CGFloat)anAlpha
{
    CGFloat red, green, blue, alpha;
    
    [aBaseColor getRed: &red
                 green: &green
                  blue: &blue
                 alpha: &alpha];
    
    return [UIColor colorWithRed:red + aRed
                           green:green + aGreen
                            blue:blue + aBlue
                           alpha:anAlpha];
}

+ (CGFloat) properColor:(CGFloat)aColor
{
    return (aColor / 255.0f);
}

#pragma mark -
#pragma mark - Shape helpers
+ (NSArray*) arrayForShape:(ShapeType)aShape
{
    switch (aShape)
    {
        case Square:
            return [[NSArray alloc] initWithObjects:
                    [NSValue valueWithCGPoint:CGPointMake(8.0f, 8.0f)],
                    [NSValue valueWithCGPoint:CGPointMake(76.0f, 8.0f)],
                    [NSValue valueWithCGPoint:CGPointMake(76.0f, 76.0f)],
                    [NSValue valueWithCGPoint:CGPointMake(8.0f, 76.0f)],
                    nil];
        case Triangle:
            return  [[NSArray alloc] initWithObjects:
                     [NSValue valueWithCGPoint:CGPointMake(42.04, 84)],
                     [NSValue valueWithCGPoint:CGPointMake(0, 84)],
                     [NSValue valueWithCGPoint:CGPointMake(21.02, 42)],
                     [NSValue valueWithCGPoint:CGPointMake(42.04, 0)],
                     [NSValue valueWithCGPoint:CGPointMake(62.98, 42)],
                     [NSValue valueWithCGPoint:CGPointMake(84, 84)],
                     [NSValue valueWithCGPoint:CGPointMake(42.04, 84)],
                     nil];
        case Pentagon:
            return  [[NSArray alloc] initWithObjects:
                     [NSValue valueWithCGPoint:CGPointMake(16.05, 84)],
                     [NSValue valueWithCGPoint:CGPointMake(0, 31.54)],
                     [NSValue valueWithCGPoint:CGPointMake(42, -0.8)],
                     [NSValue valueWithCGPoint:CGPointMake(84, 31.54)],
                     [NSValue valueWithCGPoint:CGPointMake(67.95, 84)],
                     [NSValue valueWithCGPoint:CGPointMake(16.05, 84)],
                     nil];
        case Octagon:            
            return  [[NSArray alloc] initWithObjects:
                     [NSValue valueWithCGPoint:CGPointMake(24.65, 84)],
                     [NSValue valueWithCGPoint:CGPointMake(0, 59.44)],
                     [NSValue valueWithCGPoint:CGPointMake(0, 24.65)],
                     [NSValue valueWithCGPoint:CGPointMake(24.65, 0)],
                     [NSValue valueWithCGPoint:CGPointMake(59.44, 0)],
                     [NSValue valueWithCGPoint:CGPointMake(84, 24.65)],
                     [NSValue valueWithCGPoint:CGPointMake(84, 59.44)],
                     [NSValue valueWithCGPoint:CGPointMake(59.44, 84)],
                     [NSValue valueWithCGPoint:CGPointMake(24.65, 84)],
                     nil];
        case Decagon:            
            return  [[NSArray alloc] initWithObjects:
                     [NSValue valueWithCGPoint:CGPointMake(28.83, 84)],
                     [NSValue valueWithCGPoint:CGPointMake(7.8, 68)],
                     [NSValue valueWithCGPoint:CGPointMake(-0.2, 42)],
                     [NSValue valueWithCGPoint:CGPointMake(7.8, 16.09)],
                     [NSValue valueWithCGPoint:CGPointMake(28.83, 0)],
                     [NSValue valueWithCGPoint:CGPointMake(54.88, 0)],
                     [NSValue valueWithCGPoint:CGPointMake(75.91, 16.09)],
                     [NSValue valueWithCGPoint:CGPointMake(84, 42)],
                     [NSValue valueWithCGPoint:CGPointMake(75.91, 68)],
                     [NSValue valueWithCGPoint: CGPointMake(54.88, 84)],
                     [NSValue valueWithCGPoint: CGPointMake(28.83, 84)],
                     nil];
        case Star:
            return [[NSArray alloc] initWithObjects:
                    [NSValue valueWithCGPoint:CGPointMake(41.96, 65.01)],
                    [NSValue valueWithCGPoint:CGPointMake(16.07, 84)],
                    [NSValue valueWithCGPoint:CGPointMake(25.19, 52.13)],
                    [NSValue valueWithCGPoint:CGPointMake(0, 32.05)],
                    [NSValue valueWithCGPoint:CGPointMake(31.62, 31.41)],
                    [NSValue valueWithCGPoint:CGPointMake(41.96, 0)],
                    [NSValue valueWithCGPoint:CGPointMake(52.38, 31.41)],
                    [NSValue valueWithCGPoint:CGPointMake(84, 32.05)],
                    [NSValue valueWithCGPoint:CGPointMake(58.81, 52.13)],
                    [NSValue valueWithCGPoint:CGPointMake(67.93, 84)],
                    [NSValue valueWithCGPoint:CGPointMake(41.96, 65.01)],
                    nil];
        case FreakStar:
            return [[NSArray alloc] initWithObjects:
                    [NSValue valueWithCGPoint:CGPointMake(42.04, 22.12)],
                    [NSValue valueWithCGPoint:CGPointMake(60.66, 0)],
                    [NSValue valueWithCGPoint:CGPointMake(55.5, 28.79)],
                    [NSValue valueWithCGPoint:CGPointMake(84, 29.98)],
                    [NSValue valueWithCGPoint:CGPointMake(58.79, 43.69)],
                    [NSValue valueWithCGPoint:CGPointMake(75.72, 67.36)],
                    [NSValue valueWithCGPoint:CGPointMake(49.53, 55.76)],
                    [NSValue valueWithCGPoint:CGPointMake(42.04, 84)],
                    [NSValue valueWithCGPoint:CGPointMake(34.56, 55.76)],
                    [NSValue valueWithCGPoint:CGPointMake(8.28, 67.36)],
                    [NSValue valueWithCGPoint:CGPointMake(25.21, 43.69)],
                    [NSValue valueWithCGPoint:CGPointMake(0, 29.98)],
                    [NSValue valueWithCGPoint:CGPointMake(28.5, 28.79)],
                    [NSValue valueWithCGPoint:CGPointMake(23.34, 0)],
                    [NSValue valueWithCGPoint:CGPointMake(42.04, 22.12)],
                    nil];
        default:
            return [[NSArray alloc] initWithObjects:
                    [NSValue valueWithCGPoint:CGPointMake(0.0f, 0.0f)],
                    [NSValue valueWithCGPoint:CGPointMake(76.0f, 0.0f)],
                    [NSValue valueWithCGPoint:CGPointMake(76.0f, 76.0f)],
                    [NSValue valueWithCGPoint:CGPointMake(0.0f, 76.0f)],
                    nil];
    }
}

+ (IQIrregularView*) createShape:(ShapeType)aShape withColor:(UIColor*)aColor
{
    switch (aShape)
    {
        case Square:
            return [BGGUtilities createSquareWithColor:aColor];
        case Circle:
            return [BGGUtilities createCircleWithColor:aColor andFrame:CGRectMake(2.0f, 2.0f, 82.0f, 82.0f)];
        case Triangle:
            return  [BGGUtilities createTriangleWithColor:aColor];
        case Pentagon:
            return [BGGUtilities createPentagonWithColor:aColor];
        case Octagon:
            return [BGGUtilities createOctagonWithColor:aColor];
        case Star:
            return [BGGUtilities createStarWithColor:aColor];
        case Decagon:
            return [BGGUtilities createDecagonWithColor:aColor];
        case FreakStar:
            return [BGGUtilities createFreakStarWithColor:aColor];
        case Oval:
            return [BGGUtilities createCircleWithColor:aColor andFrame:CGRectMake(2.0f, 15.0f, 82.0f, 63.0f)];
        default:
            return [BGGUtilities createSquareWithColor:aColor];
    }

}

+ (IQIrregularView*) createYellowColoredCircleWithFrame:(CGRect)aFrame
{
    return [BGGUtilities createCircleWithColor:[BGGUtilities mainMenuYellow]
                                      andFrame:aFrame];
    
}

+ (IQIrregularView*) createCircleWithColor:(UIColor*)aColor andFrame:(CGRect)aFrame
{
    return [[IQIrregularView alloc] initWithPath:[IQIrregularView ovalPathWithFrame:aFrame]
                                        andColor:aColor];
}

+ (IQIrregularView*) createYellowColoredSquare
{
    return [BGGUtilities createSquareWithColor:[BGGUtilities mainMenuYellow]];
}

+ (IQIrregularView*) createSquareWithColor:(UIColor*)aColor
{
    return [[IQIrregularView alloc] initWithPoints:[BGGUtilities arrayForShape:Square]
                                          andColor:aColor];
}

+ (IQIrregularView*) createYellowColoredTriangle
{
    return [BGGUtilities createTriangleWithColor:[BGGUtilities mainMenuYellow]];
}

+(IQIrregularView*) createTriangleWithColor:(UIColor*)aColor
{
    return [[IQIrregularView alloc] initWithPoints:[BGGUtilities arrayForShape:Triangle]
                                          andColor:aColor];
}

+ (IQIrregularView*) createYellowColoredPentagon
{
    return [BGGUtilities createPentagonWithColor:[BGGUtilities mainMenuYellow]];
}

+ (IQIrregularView*) createPentagonWithColor:(UIColor*)aColor
{
    return [[IQIrregularView alloc] initWithPoints:[BGGUtilities arrayForShape:Pentagon]
                                          andColor:aColor];
}

+ (IQIrregularView*) createYellowColoredOctagon
{
    return [BGGUtilities createOctagonWithColor:[BGGUtilities mainMenuYellow]];
}

+ (IQIrregularView*) createOctagonWithColor:(UIColor*)aColor
{
    return [[IQIrregularView alloc] initWithPoints:[BGGUtilities arrayForShape:Octagon]
                                          andColor:aColor];
}

+ (IQIrregularView*) createYellowColoredDecagon
{
    return [BGGUtilities createDecagonWithColor:[BGGUtilities mainMenuYellow]];
}

+ (IQIrregularView*) createDecagonWithColor:(UIColor*)aColor
{
    return [[IQIrregularView alloc] initWithPoints:[BGGUtilities arrayForShape:Decagon]
                                          andColor:aColor];
}

+ (IQIrregularView*) createYellowColoredStar
{
    return [BGGUtilities createStarWithColor:[BGGUtilities mainMenuYellow]];
}

+ (IQIrregularView*) createStarWithColor:(UIColor*)aColor
{
    return [[IQIrregularView alloc] initWithPoints:[BGGUtilities arrayForShape:Star]
                                          andColor:aColor];
}

+ (IQIrregularView*) createYellowColoredFreakStar
{
    return [BGGUtilities createFreakStarWithColor:[BGGUtilities mainMenuYellow]];
}

+ (IQIrregularView*) createFreakStarWithColor:(UIColor*)aColor
{
    return [[IQIrregularView alloc] initWithPoints:[BGGUtilities arrayForShape:FreakStar]
                                          andColor:aColor];
}


@end
