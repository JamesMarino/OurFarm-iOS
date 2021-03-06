/*
 * Copyright (c) 2015 James Marino. All rights reserved.
 * File: ViewController.m
 */

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <StoreKit/StoreKit.h>

@import GoogleMobileAds;
@import UIKit;

// Constants
static int const AmountOfSounds = 13;
static NSString* const RemoveAdsInAppID = @"RemoveAds";

@interface ViewController () <GADInterstitialDelegate, SKProductsRequestDelegate, SKPaymentTransactionObserver>
{
    // In App Purchase
    SKProduct *removeAddInAppProduct;
    
    // Ads
    GADInterstitial *interstitial;
    int pressCount;
    
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
    [self showAdvert];
}

- (IBAction)cowPress:(id)sender
{
	[cow play];
    [self showAdvert];
    
}

- (IBAction)iCowPress:(id)sender
{
	[icow play];
    [self showAdvert];
}

- (IBAction)sheepPress:(id)sender
{
	[sheep play];
    [self showAdvert];
}

- (IBAction)iSheepPress:(id)sender
{
	[isheep play];
    [self showAdvert];
}

- (IBAction)pigPress:(id)sender
{
	[pig play];
    [self showAdvert];
}

- (IBAction)iPigPress:(id)sender
{
	[ipig play];
    [self showAdvert];
}

- (IBAction)chickenPress:(id)sender
{
	[chicken play];
    [self showAdvert];
}

- (IBAction)iChickenPress:(id)sender
{
	[ichicken play];
    [self showAdvert];
}

- (IBAction)horsePress:(id)sender
{
	[horse play];
    [self showAdvert];
}

- (IBAction)iHorsePress:(id)sender
{
	[ihorse play];
    [self showAdvert];
}

- (IBAction)dogPress:(id)sender
{
	[dog play];
    [self showAdvert];
}

- (IBAction)iDogPress:(id)sender
{
	[idog play];
    [self showAdvert];
}

- (void)getAdvert
{
    self->interstitial = [[GADInterstitial alloc]
                          initWithAdUnitID:@"ca-app-pub-5973785969162902/7785097978"];
    self->interstitial.delegate = self;
    
    GADRequest *request = [GADRequest request];
    [self->interstitial loadRequest:request];
}

- (void)showAdvert
{
    // Check User Defaults
    BOOL areAdsRemoved = [[NSUserDefaults standardUserDefaults] boolForKey:@"areAdsRemoved"];
    
    if (!areAdsRemoved) {
        
        // Incremenet
        [self incrementAdCountOrReset:NO];
        
        if (self->pressCount > 3) {
            if (self->interstitial.isReady) {
                [self->interstitial presentFromRootViewController:self];
            }
        }
    }
    
}

- (int)incrementAdCountOrReset:(BOOL)reset
{
    if (reset == YES) {
        self->pressCount = 0;
    } else {
        self->pressCount = self->pressCount + 1;
    }
    
    return self->pressCount;
}

- (void)interstitialWillDismissScreen:(GADInterstitial *)interstitial
{
    [self getAdvert];
}

- (void)interstitialDidDismissScreen:(GADInterstitial *)interstitial
{
    [self showRemoveAds];
}

- (void)showRemoveAds
{
    
    if (removeAddInAppProduct != nil) {
        
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        [numberFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
        [numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
        [numberFormatter setLocale:removeAddInAppProduct.priceLocale];
        NSString *formattedCurrency = [numberFormatter stringFromNumber:removeAddInAppProduct.price];
        
        
        NSString* message = [NSString stringWithFormat:@"%@ %@",
                             removeAddInAppProduct.localizedDescription,
                             formattedCurrency];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:removeAddInAppProduct.localizedTitle
                                                        message:message
                                                       delegate:self
                                              cancelButtonTitle:@"Remove Ads"
                                              otherButtonTitles:@"Keep Ads", nil
                              ];
        [alert show];
    
        
    }
    
    if (self->pressCount > 3) {
        [self incrementAdCountOrReset:YES];
        NSLog(@"Show PopUp");
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 0) {
        [self purchaseMyProduct:removeAddInAppProduct];
    } else {
        NSLog(@"Keep Ads Pressed");
    }
}

- (BOOL)canMakePurchases
{
    return [SKPaymentQueue canMakePayments];
}

- (void)purchaseMyProduct:(SKProduct*)product
{
    if ([self canMakePurchases]) {
        SKPayment *payment = [SKPayment paymentWithProduct:product];
        [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
        [[SKPaymentQueue defaultQueue] addPayment:payment];
    } else {
        
        NSString *title = @"Purchases are disabled in your device";
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                            message:nil
                                                           delegate:self
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles: nil];
        [alertView show];
    }
}

- (void)productsRequest:(SKProductsRequest *)request
     didReceiveResponse:(SKProductsResponse *)response
{
    removeAddInAppProduct = nil;
    
    if ([response.products count] > 0) {
        removeAddInAppProduct = [response.products objectAtIndex:0];
    }
}

- (void)request:(SKRequest *)request
didFailWithError:(NSError *)error
{
    removeAddInAppProduct = nil;
}

- (void)paymentQueue:(SKPaymentQueue *)queue
 updatedTransactions:(NSArray *)transactions
{
    for (SKPaymentTransaction *transaction in transactions) {
        
        switch (transaction.transactionState) {
            case SKPaymentTransactionStatePurchased:
                // User Purchased Ads
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"areAdsRemoved"];
                
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                break;
                
            case SKPaymentTransactionStateRestored:
                // Restored Purchased
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                break;
        }
    }
}

- (void)viewDidLoad {
	[super viewDidLoad];
    
    // In App Purchase Load
    SKProductsRequest *productsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:[NSSet setWithObject:RemoveAdsInAppID]];
    productsRequest.delegate = self;
    [productsRequest start];
    
    // AdMob
    [self getAdvert];
    self->pressCount = 0;
    
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
}

@end
