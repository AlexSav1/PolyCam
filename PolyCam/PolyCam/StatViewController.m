//
//  StatViewController.m
//  PolyCam
//
//  Created by Jerry Chen on 2/2/17.
//  Copyright © 2017 bl. All rights reserved.
//

#import "StatViewController.h"
#import "Mediator.h"

// Define RGB colors
#define UIColorFromRGB(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >>  8))/255.0 \
blue:((float)((rgbValue & 0x0000FF) >>  0))/255.0 \
alpha:1.0]

@interface StatViewController ()

@end

@implementation StatViewController
{
    Mediator *_mediator;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _mediator = [Mediator sharedInstance];
    
    // Adjust UI assets
    self.statsIconImageView.image = [self.statsIconImageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.statsIconImageView.tintColor = UIColorFromRGB(0x232323);
    
}

-(void) viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.overallAngerPercentage.text = [NSString stringWithFormat:@"%f", _mediator.averageOverallAnger];
    self.overallContemptPercentage.text = [NSString stringWithFormat:@"%f", _mediator.averageOverallContempt];
    self.overallFearPercentage.text = [NSString stringWithFormat:@"%f", _mediator.averageOverallFear];
    self.overallSurprisePercentage.text = [NSString stringWithFormat:@"%f", _mediator.averageOverallSurprise];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
