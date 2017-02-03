//
//  Mediator.h
//  PolyCam
//
//  Created by bl on 2/2/17.
//  Copyright © 2017 bl. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "BackEnd.h"


@protocol MediatorDelegate <NSObject>

- (void) didProcessPhoto:(Question *)question;

@end

@interface Mediator : NSObject<BackEndDelegate>

@property (nonatomic, strong) id<MediatorDelegate> delegate;

@property (nonatomic) NSInteger questionCount;
@property (nonatomic) double truthfulness;
@property (nonatomic) double averageOverallAnger;
@property (nonatomic) double averageOverallContempt;
@property (nonatomic) double averageOverallFear;
@property (nonatomic) double averageOverallSurprise;

+ (Mediator *)sharedInstance;

- (void) processPhoto:(UIImage *)photo;

@end
