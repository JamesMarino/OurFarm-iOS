/*
 * Copyright (c) 2015 James Marino. All rights reserved.
 * File: AppDelegate.m
 */

#import "AppDelegate.h"
@import GoogleMobileAds;

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // Initialise AdMob
    [GADMobileAds configureWithApplicationID:@"ca-app-pub-5973785969162902~8070547745"];
	
	CGSize iOSScreenSize = [[UIScreen mainScreen] bounds].size;
	
	if (iOSScreenSize.height == 480) {
		UIStoryboard *iPhoneStory35Board = [UIStoryboard storyboardWithName:@"iPhone35" bundle:nil];
		
		UIViewController *initialViewController = [iPhoneStory35Board instantiateInitialViewController];
		
		self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
		self.window.rootViewController = initialViewController;
		
		[self.window makeKeyAndVisible];
		
	}
	
	if (iOSScreenSize.height == 568) {
		UIStoryboard *iPhoneStory4Board = [UIStoryboard storyboardWithName:@"iPhone4" bundle:nil];
		
		UIViewController *initialViewController = [iPhoneStory4Board instantiateInitialViewController];
		
		self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
		self.window.rootViewController = initialViewController;
		
		[self.window makeKeyAndVisible];
		
	}
	
	if (iOSScreenSize.height == 667) {
		UIStoryboard *iPhoneStory47Board = [UIStoryboard storyboardWithName:@"iPhone47" bundle:nil];
		
		UIViewController *initialViewController = [iPhoneStory47Board instantiateInitialViewController];
		
		self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
		self.window.rootViewController = initialViewController;
		
		[self.window makeKeyAndVisible];
		
	}
	
	if (iOSScreenSize.height == 736) {
		UIStoryboard *iPhoneStory55Board = [UIStoryboard storyboardWithName:@"iPhone55" bundle:nil];
		
		UIViewController *initialViewController = [iPhoneStory55Board instantiateInitialViewController];
		
		self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
		self.window.rootViewController = initialViewController;
		
		[self.window makeKeyAndVisible];
		
	}
	
	return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {}

- (void)applicationDidEnterBackground:(UIApplication *)application {}

- (void)applicationWillEnterForeground:(UIApplication *)application {}

- (void)applicationDidBecomeActive:(UIApplication *)application {}

- (void)applicationWillTerminate:(UIApplication *)application {}

@end
