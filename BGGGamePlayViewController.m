//
//  BGGGamePlayViewController.m
//  Colorthesia
//
//  Created by AJ Green on 10/5/14.
//  Copyright (c) 2014 Big Gorilla Games. All rights reserved.
//

#import "BGGGamePlayViewController.h"
#import "BGGIrregularButton.h"
#import "BGGApplicationManager.h"

@interface BGGGamePlayViewController ()

@property (nonatomic, assign) NSInteger seconds;
@property (nonatomic, assign) NSInteger countdown;
@property (nonatomic, strong) BGGIrregularButton *play;
@property (nonatomic, strong) BGGIrregularButton *finalCountdown;

@end

@implementation BGGGamePlayViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[BGGApplicationManager sharedInstance] pauseBackgroundMusic];
    
    self.seconds = 1;
    self.countdown = 3;
    
    UIColor *randomColor = [BGGUtilities randomColor];
    [[BGGApplicationManager sharedInstance] setColor:randomColor];
    

    self.play = [BGGUtilities centerOrientedOvalButtonForView:self.view
                                                    withTitle:@""
                                                        color:randomColor
                                                       target:nil
                                                    andAction:nil];
    
    [self.play setAlpha:1.0f];
    
    self.finalCountdown = [BGGUtilities bottomOrientedOvalButtonForView:self.view
                                                    withTitle:[NSString stringWithFormat:@"%li",(long)self.countdown]
                                                        color:randomColor
                                                       target:nil
                                                    andAction:nil];
    [self.finalCountdown setAlpha:1.0f];
    
    [[self view] addSubview:self.finalCountdown];
    [[self view] addSubview:self.play];
    
    
    [NSTimer scheduledTimerWithTimeInterval:1.0
                                     target:self
                                   selector:@selector(handleTimer:)
                                   userInfo:nil
                                    repeats:YES];
    
    [[self score] setText:[NSString stringWithFormat:@"%li",(long)[[BGGApplicationManager sharedInstance] score]]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

- (void) handleTimer:(NSTimer*)aTimer
{
    if(self.seconds < 4)
    {
        self.countdown--;
        [self.finalCountdown setTitle:[NSString stringWithFormat:@"%li",(long)self.countdown]
                             forState:UIControlStateNormal];
        self.seconds++;
    }
    else
    {
        [aTimer invalidate];
        [[BGGApplicationManager sharedInstance] playBackgroundMusic];
        [self moveToNextController];
    }
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (void) moveToNextController
{
    // Move to game controller
    
    [self performSegueWithIdentifier:SEGUE_GAMEBOARD
                              sender:self];
}

@end
