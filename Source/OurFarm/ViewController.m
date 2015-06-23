/*
 * Copyright (c) 2015 James Marino. All rights reserved.
 * File: ViewController.m
 */

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

// Constants
static int const AmountOfSounds = 13;

@interface ViewController ()
{
	// Animals
	AVAudioPlayer *chicken;
	AVAudioPlayer *cow;
	AVAudioPlayer *dog;
	AVAudioPlayer *horse;
	AVAudioPlayer *pig;
	AVAudioPlayer *sheep;
	AVAudioPlayer *ichicken;
	AVAudioPlayer *icow;
	AVAudioPlayer *idog;
	AVAudioPlayer *ihorse;
	AVAudioPlayer *ipig;
	AVAudioPlayer *isheep;
	AVAudioPlayer *chooks;
}

@end

@implementation ViewController

- (IBAction)chooksPress:(id)sender
{
	[chooks play];
}

- (IBAction)cowPress:(id)sender
{
	[cow play];
}

- (IBAction)iCowPress:(id)sender
{
	[icow play];
}

- (IBAction)sheepPress:(id)sender
{
	[sheep play];
}

- (IBAction)iSheepPress:(id)sender
{
	[isheep play];
}

- (IBAction)pigPress:(id)sender
{
	[pig play];
}

- (IBAction)iPigPress:(id)sender
{
	[ipig play];
}

- (IBAction)chickenPress:(id)sender
{
	[chicken play];
}

- (IBAction)iChickenPress:(id)sender
{
	[ichicken play];
}

- (IBAction)horsePress:(id)sender
{
	[horse play];
}

- (IBAction)iHorsePress:(id)sender
{
	[ihorse play];
}

- (IBAction)dogPress:(id)sender
{
	[dog play];
}

- (IBAction)iDogPress:(id)sender
{
	[idog play];
}

- (void)viewDidLoad {
	[super viewDidLoad];
	
	// Scroll View Setup
	{
	
		// Initialise
		CGSize iOSScreenSize = [[UIScreen mainScreen] bounds].size;
		
		// Setup Scrolling
		[scroller setScrollEnabled:YES];
		
		// Set Scrolling height for each device
		if (iOSScreenSize.height == 480) {
			[scroller setContentSize:CGSizeMake(320, 2020)];
		} else if (iOSScreenSize.height == 568) {
			[scroller setContentSize:CGSizeMake(320, 2365)];
		} else if (iOSScreenSize.height == 667) {
			[scroller setContentSize:CGSizeMake(320, 2672)];
		} else if (iOSScreenSize.height == 736) {
			[scroller setContentSize:CGSizeMake(320, 3085)];
		}
		
	}
	
	// Audio Arrays
	NSMutableArray *SoundPaths = [[NSMutableArray alloc] initWithCapacity:AmountOfSounds];
	NSMutableArray *SoundURL = [[NSMutableArray alloc] initWithCapacity:AmountOfSounds];
	
	// Add all the objects to the SoundPaths array
	[SoundPaths addObject: [NSString stringWithFormat:@"%@/chicken.mp3", [[NSBundle mainBundle] resourcePath]]];
	[SoundPaths addObject: [NSString stringWithFormat:@"%@/cow.mp3", [[NSBundle mainBundle] resourcePath]]];
	[SoundPaths addObject: [NSString stringWithFormat:@"%@/dog.mp3", [[NSBundle mainBundle] resourcePath]]];
	[SoundPaths addObject: [NSString stringWithFormat:@"%@/horse.mp3", [[NSBundle mainBundle] resourcePath]]];
	[SoundPaths addObject: [NSString stringWithFormat:@"%@/pig.mp3", [[NSBundle mainBundle] resourcePath]]];
	[SoundPaths addObject: [NSString stringWithFormat:@"%@/sheep.mp3", [[NSBundle mainBundle] resourcePath]]];
	[SoundPaths addObject: [NSString stringWithFormat:@"%@/ichicken.mp3", [[NSBundle mainBundle] resourcePath]]];
	[SoundPaths addObject: [NSString stringWithFormat:@"%@/icow.mp3", [[NSBundle mainBundle] resourcePath]]];
	[SoundPaths addObject: [NSString stringWithFormat:@"%@/idog.mp3", [[NSBundle mainBundle] resourcePath]]];
	[SoundPaths addObject: [NSString stringWithFormat:@"%@/ihorse.mp3", [[NSBundle mainBundle] resourcePath]]];
	[SoundPaths addObject: [NSString stringWithFormat:@"%@/ipig.mp3", [[NSBundle mainBundle] resourcePath]]];
	[SoundPaths addObject: [NSString stringWithFormat:@"%@/isheep.mp3", [[NSBundle mainBundle] resourcePath]]];
	[SoundPaths addObject: [NSString stringWithFormat:@"%@/clucks.mp3", [[NSBundle mainBundle] resourcePath]]];
	
	// Loop over each and create URL's
	for (int i = 0; i < AmountOfSounds; i++) {
		[SoundURL addObject: [NSURL fileURLWithPath: [SoundPaths objectAtIndex:i]]];
	}
	
	chicken = [[AVAudioPlayer alloc] initWithContentsOfURL:[SoundURL objectAtIndex:0] error:nil];
	cow = [[AVAudioPlayer alloc] initWithContentsOfURL:[SoundURL objectAtIndex:1] error:nil];
	dog = [[AVAudioPlayer alloc] initWithContentsOfURL:[SoundURL objectAtIndex:2] error:nil];
	horse = [[AVAudioPlayer alloc] initWithContentsOfURL:[SoundURL objectAtIndex:3] error:nil];
	pig = [[AVAudioPlayer alloc] initWithContentsOfURL:[SoundURL objectAtIndex:4] error:nil];
	sheep = [[AVAudioPlayer alloc] initWithContentsOfURL:[SoundURL objectAtIndex:5] error:nil];
	ichicken = [[AVAudioPlayer alloc] initWithContentsOfURL:[SoundURL objectAtIndex:6] error:nil];
	icow = [[AVAudioPlayer alloc] initWithContentsOfURL:[SoundURL objectAtIndex:7] error:nil];
	idog = [[AVAudioPlayer alloc] initWithContentsOfURL:[SoundURL objectAtIndex:8] error:nil];
	ihorse = [[AVAudioPlayer alloc] initWithContentsOfURL:[SoundURL objectAtIndex:9] error:nil];
	ipig = [[AVAudioPlayer alloc] initWithContentsOfURL:[SoundURL objectAtIndex:10] error:nil];
	isheep = [[AVAudioPlayer alloc] initWithContentsOfURL:[SoundURL objectAtIndex:11] error:nil];
	chooks = [[AVAudioPlayer alloc] initWithContentsOfURL:[SoundURL objectAtIndex:12] error:nil];
	
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
