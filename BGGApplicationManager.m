//
//  BGGApplicationManager.m
//  Colorthesia
//
//  Created by AJ Green on 10/7/14.
//  Copyright (c) 2014 Big Gorilla Games. All rights reserved.
//

#import "BGGApplicationManager.h"
#import "BGGAudioPlayerPool.h"

@interface BGGApplicationManager ()

@property (nonatomic, strong) UIColor *currentColor;
@property (nonatomic, assign) NSInteger currentScore;
@property (nonatomic, assign) NSInteger highScore;
@property (nonatomic, strong) NSString *leaderboardIdentifier;
@property (nonatomic, strong) AVAudioPlayer *audioPlayer;

- (void) playSoundEffectWithFileName:(NSString*)aFileName;
- (NSURL*) audioURLWithFileName:(NSString*)aFileName;

@end

@implementation BGGApplicationManager

static BGGApplicationManager *sharedAppManager;

#pragma mark Singleton Methods

+ (instancetype)sharedInstance
{
    @synchronized(self)
    {
        if (sharedAppManager == nil)
        {
            sharedAppManager = [[self alloc] init];
        }
    }
    
    return sharedAppManager;
}

- (void) setColor:(UIColor*)aColor
{
    self.currentColor = aColor;
}

- (UIColor*) color
{
    return self.currentColor;
}

- (void) setScore:(NSInteger)aScore
{
    self.currentScore = aScore;
    
    // Probably needs adjustment for GameCenter
    self.highScore = (self.currentScore > self.highScore) ? self.currentScore : self.highScore;
}

- (NSInteger) score
{
    return self.currentScore;
}

- (void) setCurrentHighScore:(NSInteger)aScore
{
    self.highScore = aScore;
}

- (NSInteger) currentHighScore
{
    return self.highScore;
}

- (void) setLeaderboardID:(NSString*)anID
{
    self.leaderboardIdentifier = anID;
}

- (NSString*) leaderboardID
{
    return self.leaderboardIdentifier;
}

#pragma mark - Background Music
- (void) playBackgroundMusic
{
    if (self.audioPlayer == nil)
    {
        // Create audio player object and initialize with URL to sound
        self.audioPlayer = [BGGAudioPlayerPool playerWithURL:[self audioURLWithFileName:@"Theme.mp3"]];
        [self.audioPlayer setNumberOfLoops:-1];
    }
    
    [self.audioPlayer prepareToPlay];
    [self.audioPlayer play];
}

- (void) restartBackgroundMusic
{
    if ((self.audioPlayer != nil) && [self.audioPlayer isPlaying])
    {
        [self.audioPlayer setCurrentTime:0];
    }
}

- (void) pauseBackgroundMusic
{
    if (self.audioPlayer!=nil)
    {
        [self.audioPlayer pause];
    }
}

- (void) playSoundEffectWithFileName:(NSString*)aFileName
{
    AVAudioPlayer *player = [BGGAudioPlayerPool playerWithURL:[self audioURLWithFileName:aFileName]];
    

    [player play];
}

- (void) playPopSoundEffect
{
    //[self playSoundEffectWithFileName:@"Pop.wav"];
}

- (void) playAnswerSoundEffect:(BOOL)isCorrectAnswer
{
    NSString *answerFile = isCorrectAnswer ? @"Correct.wav" : @"Wrong.wav";
    [self playSoundEffectWithFileName:answerFile];
}

- (NSURL*) audioURLWithFileName:(NSString*)aFileName
{
    // Construct URL to sound file
    NSString *path = [NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], aFileName];
    return [NSURL fileURLWithPath:path];
}

@end
