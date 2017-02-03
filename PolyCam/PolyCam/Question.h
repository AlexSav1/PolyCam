//
//  Question.h
//  PolyCam
//
//  Created by Aditya Narayan on 2/2/17.
//  Copyright © 2017 bl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface Question : NSObject

@property UIImage *photo;
@property int iD;

// All 8 Emotions
@property double anger;
@property double contempt;
@property double disgust;
@property double fear;
@property double happiness;
@property double neutral;
@property double sadness;
@property double surprise;

// Calculated Emotions
@property double angerPercentage;
@property double contemptPercentage;
@property double fearPercentage;
@property double surprisePercentage;

// Truthfullness
@property double truthfulness;

@end
