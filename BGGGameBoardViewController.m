//
//  BGGGameBoardViewController.m
//  Colorthesia
//
//  Created by AJ Green on 10/8/14.
//  Copyright (c) 2014 Big Gorilla Games. All rights reserved.
//

#import "BGGGameBoardViewController.h"
#import "BGGIrregularButton.h"

@interface BGGGameBoardViewController ()

@property (nonatomic, weak) BGGShapeGridViewController *containedGrid;
@property (nonatomic, strong) BGGIrregularButton *replay;

- (void) setScoreText:(NSInteger)aScore;
- (void) handleNextOrReplay:(id)sender;
- (void) reportScore;

@end

@implementation BGGGameBoardViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    self.containedGrid = (BGGShapeGridViewController*)[self.childViewControllers objectAtIndex:0];
    [self.containedGrid setGridDelegate:self];

}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (IS_IPHONE_4)
    {
        // Need to adjust the grid up slightly
        CGPoint gridCenter = CGPointMake(self.containedGrid.view.center.x, self.containedGrid.view.center.y - 20.0f);
        
        [self.containedGrid.view setCenter:gridCenter];
        
        // High score takes a little bit more work, adjust it up
        CGPoint highScoreCenter = CGPointMake(self.highScore.center.x, self.highScore.center.y - 65.0f);
        [self.highScore setCenter:highScoreCenter];
        
        // Make it one line
        //[self.highScore setNumberOfLines:1];
        
        // Adjust the font
        //[self.highScore setFont:[BGGUtilities systemFontOfSize:24.0f]];
    }
    
    [self setScoreText:[[BGGApplicationManager sharedInstance] score]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Score Text
- (void) setScoreText:(NSInteger)aScore
{
    [self.score setText:[NSString stringWithFormat:@"%li",(long)[[BGGApplicationManager sharedInstance] score]]];
}

#pragma mark -
#pragma mark - Grid Delegate
- (void) touchedShape:(BOOL)isCorrect
{
    [self.containedGrid.collectionView setUserInteractionEnabled:NO];

    [[BGGApplicationManager sharedInstance] playAnswerSoundEffect:isCorrect];
    
    if (isCorrect)
    {
        NSInteger currentScore = [[BGGApplicationManager sharedInstance] score];
        [[BGGApplicationManager sharedInstance] setScore:currentScore+1];
        [self setScoreText:[[BGGApplicationManager sharedInstance] score]];
    }
    else
    {
        [self reportScore];
    }
    
    NSString *resultText = isCorrect ? @"Correct!" : @"Wrong!";
    NSString *imageName = isCorrect ? @"Next" : @"Replay";
    
    [self.result setText:resultText];
    [self.result setHidden:NO];
    
    [self.highScore setText:[NSString stringWithFormat:@"High Score %li", (long)[[BGGApplicationManager sharedInstance] currentHighScore]]];
    [self.highScore setHidden:isCorrect];
    
    self.replay = [BGGUtilities bottomOrientedOvalButtonForView:self.view
                                                      withImage:[UIImage imageNamed:imageName]
                                                          color:[BGGUtilities restartGray]
                                                         target:self
                                                      andAction:@selector(handleNextOrReplay:)];
    [self.replay setTag:isCorrect];
    [self.replay setAlpha:1.0f];
    [[self view] addSubview:self.replay];
    

}

- (void) handleNextOrReplay:(id)sender
{
    NSInteger tag = self.replay.tag;
    
    // Not Correct
    if (tag == 0)
    {
        [self performSegueWithIdentifier:SEGUE_GAMEMAIN sender:self];
    }
    else
    {
        [self performSegueWithIdentifier:SEGUE_GAMEREPLAY sender:self];
    }
}

- (void) reportScore
{
    if([[BGGApplicationManager sharedInstance] leaderboardID] != nil)
    {
    GKScore *score = [[GKScore alloc] initWithLeaderboardIdentifier:[[BGGApplicationManager sharedInstance] leaderboardID]];
    score.value = [[BGGApplicationManager sharedInstance] currentHighScore];
    
    [GKScore reportScores:@[score] withCompletionHandler:^(NSError *error) {
        if (error != nil) {
            NSLog(@"%@", [error localizedDescription]);
        }
    }];
    }
}

@end
