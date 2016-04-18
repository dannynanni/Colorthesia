//
//  BGGThirdTutorialScreenViewController.m
//  Colorthesia
//
//  Created by AJ Green on 10/6/14.
//  Copyright (c) 2014 Big Gorilla Games. All rights reserved.
//

#import "BGGThirdTutorialScreenViewController.h"
#import "BGGIrregularButton.h"

@interface BGGThirdTutorialScreenViewController ()

@property (nonatomic, strong) BGGIrregularButton *start;

@end

@implementation BGGThirdTutorialScreenViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.start = [BGGUtilities bottomOrientedOvalButtonForView:self.view
                                                    withImage:[UIImage imageNamed:@"Next"]
                                                        color:[BGGUtilities mainMenuYellow]
                                                       target:self
                                                    andAction:@selector(moveToNextController)];
    
    [self.start setAlpha:1.0f];
    
    [[self view] addSubview:self.start];    
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

- (void) moveToNextController
{
    // Move to game controller
    NSLog(@"Tutorial Page Game Start!");
    
    [BGGUtilities saveTutorialPreferenceSelection:NO];
    
    [self performSegueWithIdentifier:SEGUE_TUTORIAL_GAME
                              sender:self];
}

@end
