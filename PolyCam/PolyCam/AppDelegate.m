//
//  AppDelegate.m
//  PolyCam
//
//  Created by bl on 2/2/17.
//  Copyright © 2017 bl. All rights reserved.
//


#import "AppDelegate.h"
#import "MainViewController.h"
@import Firebase;


@interface AppDelegate ()

@end

@implementation AppDelegate


-(void) fetchFromDatabase{
    
    self.ref = [[FIRDatabase database] reference];
    
    [self.ref observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        NSDictionary *postDict = snapshot.value;
        
        NSLog(@"Initial DATA: %@", postDict);
        
        self.APIKEY = [postDict objectForKey:@"key"];
        
        NSLog(@"DATA: %@", self.APIKEY);
        
    }withCancelBlock:^(NSError * _Nonnull error) {
        NSLog(@"%@", error.localizedDescription);
    }];
    
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    [FIRApp configure];
    [self fetchFromDatabase];
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    self.window = [[UIWindow alloc] initWithFrame: screenBounds];
    self.window.backgroundColor = UIColor.purpleColor;
    
    UIViewController *rootController = [[MainViewController alloc] init];
    rootController.edgesForExtendedLayout = UIRectEdgeAll;
    
    [self.window setRootViewController:rootController];
    
    // Make the window visible and active
    [self.window makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
