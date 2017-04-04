//
//  BackEnd.h
//  PolyCam
//
//  Created by Alex Savitt on 2/2/17.
//  Copyright © 2017 bl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Question.h"
@import Firebase;

@protocol BackEndDelegate <NSObject>

- (void) didSendToEmotionAPI:(Question *)question;

@end

@interface BackEnd : NSObject

@property (nonatomic) id <BackEndDelegate> delegate;

-(void) sendToEmotionAPI: (NSData*) imageData;

@end
