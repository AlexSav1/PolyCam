//
//  Mediator.m
//  PolyCam
//
//  Created by bl on 2/2/17.
//  Copyright © 2017 bl. All rights reserved.
//


#import "Mediator.h"
#import "StatViewController.h"


static BackEnd *_backEnd;


@implementation Mediator
{
    UIImage *_photo;
    NSData *_imageData;
}

//////////////////////////////////////////////////////////////////////////////////////////
//
//  Method implements the singleton pattern for this class.
//
//////////////////////////////////////////////////////////////////////////////////////////
+ (Mediator *)sharedInstance
{
    static Mediator *_sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate,
                  ^{
                      _sharedInstance = [[Mediator alloc] init];
                      _backEnd = [[BackEnd alloc] init];
                  });
    
    return _sharedInstance;
}

//////////////////////////////////////////////////////////////////////////////////////////
//
//  Method to start processing the image.
//
//////////////////////////////////////////////////////////////////////////////////////////
- (void) processPhoto:(UIImage *)photo
{
    // Initialize delgate here because it generate a warning when it is done in a class method
    if (nil == _backEnd.delegate)
        _backEnd.delegate = self;
    
    _photo = photo;
    _imageData = UIImageJPEGRepresentation(photo, 0.0);
    
    [_backEnd sendToEmotionAPI:_imageData];
}

//////////////////////////////////////////////////////////////////////////////////////////
//
//  Delegate method called by the BackEnd.
//
//////////////////////////////////////////////////////////////////////////////////////////
- (void) didSendToEmotionAPI:(Question *)question
{
    question.photo = _photo;
    
    double total = (question.anger + question.contempt + question.fear + question.surprise);
    
    question.angerPercentage = (question.anger / total);
    question.contemptPercentage = (question.contempt / total);
    question.fearPercentage = (question.fear / total);
    question.surprisePercentage = (question.surprise / total);
    
    [self.delegate didProcessPhoto:question];
}

@end
