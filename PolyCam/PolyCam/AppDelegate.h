//
//  AppDelegate.h
//  PolyCam
//
//  Created by bl on 2/2/17.
//  Copyright © 2017 bl. All rights reserved.
//

#import <UIKit/UIKit.h>
@import Firebase;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSString* APIKEY;
@property (strong, nonatomic) FIRDatabaseReference *ref;

@end

