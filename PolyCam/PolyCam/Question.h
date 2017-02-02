//
//  Question.h
//  PolyCam
//
//  Created by Aditya Narayan on 2/2/17.
//  Copyright © 2017 bl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Question : NSObject

@property NSData *imageData;

@property double anger;
@property double contempt;
@property double disgust;
@property double fear;
@property double happiness;
@property double neutral;
@property double sadness;
@property double surprise;

@end
