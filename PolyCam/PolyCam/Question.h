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

@property double anger;
@property double contempt;
@property double disgust;
@property double fear;
@property double happiness;
@property double neutral;
@property double sadness;
@property double surprise;

@property double truthfulness;

@property double angerPercentage;
@property double contemptPercentage;
@property double fearPercentage;
@property double surprisePercentage;

@end
