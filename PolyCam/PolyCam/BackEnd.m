//
//  BackEnd.m
//  PolyCam
//
//  Created by Aditya Narayan on 2/2/17.
//  Copyright © 2017 bl. All rights reserved.
//

#import "BackEnd.h"
#import "Question.h"
#import "Key.h"

@implementation BackEnd

-(void) sendToEmotionAPI: (NSData*) imageData{
    
    
    //Create session, URL, and request objects
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSURL *url = [NSURL URLWithString:@"https://westus.api.cognitive.microsoft.com/emotion/v1.0/recognize"];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    //Set content type and key
    request.HTTPBody = imageData;
    [request addValue:APIkey forHTTPHeaderField:@"Ocp-Apim-Subscription-Key"];
    [request addValue:@"application/octet-stream" forHTTPHeaderField:@"Content-Type"];
    request.HTTPMethod = @"POST";
 
    //Session task
    [[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {

        Question *currentQuestion = [[Question alloc] init];
        
        //Convert received data to dictionary
        NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
       
        //Parsing
        NSDictionary *jsonDictionary = jsonArray[0];
        NSDictionary *scores = jsonDictionary[@"scores"];
        
        currentQuestion.anger = [[scores objectForKey:@"anger"] doubleValue];
        currentQuestion.contempt = [[scores objectForKey:@"contempt"] doubleValue];
        currentQuestion.disgust = [[scores objectForKey:@"disgust"] doubleValue];
        currentQuestion.fear = [[scores objectForKey:@"fear"] doubleValue];
        
        currentQuestion.happiness = [[scores objectForKey:@"happiness"] doubleValue];
        currentQuestion.neutral = [[scores objectForKey:@"neutral"] doubleValue];
        currentQuestion.sadness = [[scores objectForKey:@"sadness"] doubleValue];
        currentQuestion.surprise = [[scores objectForKey:@"surprise"] doubleValue];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.delegate didSendToEmotionAPI:currentQuestion];
        });
        
    }
      ]resume];
  
}

@end
