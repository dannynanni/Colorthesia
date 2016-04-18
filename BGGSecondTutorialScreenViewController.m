//
//  BGGSecondTutorialScreenViewController.m
//  Colorthesia
//
//  Created by AJ Green on 10/5/14.
//  Copyright (c) 2014 Big Gorilla Games. All rights reserved.
//

#import "BGGSecondTutorialScreenViewController.h"
#import "BGGIrregularButton.h"

@interface BGGSecondTutorialScreenViewController ()

@property (nonatomic, strong) BGGIrregularButton *next;

@end

@implementation BGGSecondTutorialScreenViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.next = [BGGUtilities bottomOrientedOvalButtonForView:self.view
                                                    withImage:[UIImage imageNamed:@"Next"]
                                                        color:[BGGUtilities mainMenuYellow]
                                                       target:self
                                                    andAction:@selector(moveToNextController)];
    [[self view] addSubview:self.next];
    
    [self fadeInNextButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) fadeInNextButton
{
    [UIView animateWithDuration:0.5
                          delay:2.0
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
    NSLog(@"Tutorial Page Three!");
    
    [self performSegueWithIdentifier:SEGUE_TUTORIAL_THIRD
                              sender:self];
}

@end
