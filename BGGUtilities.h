//
//  BGGUtilities.h
//  Colorthesia
//
//  Created by AJ Green on 9/30/14.
//  Copyright (c) 2014 Big Gorilla Games. All rights reserved.
//

#import <Foundation/Foundation.h>

#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_IPHONE_4 (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 480.0f)
#define IS_IPHONE_5 (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 568.0f)
#define IS_IPHONE_6 (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 667.0f)
#define IS_IPHONE_6_PLUS (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 960.0f)

#define VERSION_KEY             @"CFBundleVersion"
#define PREF_TUTORIAL_KEY       @"tutorial_preference"
#define PREF_VERSION_KEY        @"version_preference"
#define HIGH_SCORE_KEY          @"high_score"

#define SEGUE_TUTORIAL_START    @"TutorialStart"
#define SEGUE_TUTORIAL_SECOND   @"TutorialSecond"
#define SEGUE_TUTORIAL_THIRD    @"TutorialThird"
#define SEGUE_TUTORIAL_GAME     @"TutorialGamePlay"
#define SEGUE_GAMEPLAY          @"GamePlay"
#define SEGUE_GAMEBOARD         @"GameBoard"
#define SEGUE_GAMEREPLAY        @"GameReplay"
#define SEGUE_GAMEMAIN          @"GameMain"

@class BGGIrregularButton;

@interface BGGUtilities : NSObject

typedef enum
{
    Square,
    Circle,
    Triangle,
    Pentagon,
    Octagon,
    Star,
    Decagon,
    FreakStar,
    Oval
}ShapeType;

+ (BOOL) shouldShowTutorial;
+ (void) setVersionNumber;
+ (void) saveTutorialPreferenceSelection:(BOOL)shouldShowNextTime;
+ (void) saveHighScore:(NSInteger)aHighScore;
+ (NSInteger) retrieveHighScore;

+ (UIFont*) systemFontOfSize:(CGFloat)aSize;

+ (BGGIrregularButton*) centerOrientedOvalButtonForView:(UIView*)aView
                                              withTitle:(NSString*)aTitle
                                                  color:(UIColor*)aColor
                                                 target:(id)aTarget
                                              andAction:(SEL)anAction;

+ (BGGIrregularButton*) bottomOrientedOvalButtonForView:(UIView*)aView
                                              withImage:(UIImage*)anImage
                                                  color:(UIColor*)aColor
                                                 target:(id)aTarget
                                              andAction:(SEL)anAction;

+ (BGGIrregularButton*) bottomOrientedOvalButtonForView:(UIView*)aView
                                              withTitle:(NSString*)aTitle
                                                  color:(UIColor*)aColor
                                                 target:(id)aTarget
                                              andAction:(SEL)anAction;

+ (BGGIrregularButton*) createShape:(ShapeType)aShapeType withColorIndex:(NSInteger)aColorIndex andBaseColor:(UIColor*)aColor;

+ (UIButton*) playButtonForView:(UIView*)aView target:(id)aTarget andAction:(SEL)anAction;

+ (UIColor*) randomColor;
+ (UIColor*) mainMenuYellow;
+ (UIColor*) restartGray;
+ (UIColor*) colorVariationsForIndex:(NSInteger)anIndex
                        andBaseColor:(UIColor*)aBaseColor;

@end
