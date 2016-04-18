//
//  BGGTutorialViewController.m
//  Colorthesia
//
//  Created by AJ Green on 10/1/14.
//  Copyright (c) 2014 Big Gorilla Games. All rights reserved.
//

#import "BGGFirstTutorialScreenViewController.h"
#import "BGGIrregularButton.h"

@interface BGGFirstTutorialScreenViewController ()

@property (nonatomic, strong) BGGIrregularButton *play;
@property (nonatomic, strong) BGGIrregularButton *next;

@end

@implementation BGGFirstTutorialScreenViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.play = [BGGUtilities centerOrientedOvalButtonForView:self.view
                                                    withTitle:@""
                                                        color:[BGGUtilities mainMenuYellow]
                                                       target:nil
                                                    andAction:nil];
    
    [[self view] addSubview:self.play];
    
    self.next = [BGGUtilities bottomOrientedOvalButtonForView:self.view
                                                         withImage:[UIImage imageNamed:@"Next"]
                                                             color:[BGGUtilities mainMenuYellow]
                                                            target:self
                                                         andAction:@selector(moveToNextController)];
    [[self view] addSubview:self.next];
    
    [self fadeInColor];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) fadeInColor
{
    [UIView animateWithDuration:0.5
                          delay:1.0
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         [self.play setAlpha:1.0f];
                     }
                     completion:^(BOOL finished){
                         [self fadeInNextButton];
                     }];
}

- (void) fadeInNextButton
{
    [UIView animateWithDuration:0.5
                          delay:1.0
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         [self.next setAlpha:1.0f];
                     }
                     completion:^(BOOL finished){

                     }];
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
    NSLog(@"Tutorial Page Two!");
    
    [self performSegueWithIdentifier:SEGUE_TUTORIAL_SECOND
                              sender:self];
}

@end
