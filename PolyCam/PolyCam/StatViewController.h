//
//  StatViewController.h
//  PolyCam
//
//  Created by Jerry Chen on 2/2/17.
//  Copyright © 2017 bl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StatViewController : UIViewController<UIScrollViewDelegate>

// UI
@property (weak, nonatomic) IBOutlet UIImageView *statsIconImageView;
@property (weak, nonatomic) IBOutlet UITableView *questionsTableView;

// Calculated Stats
@property (weak, nonatomic) IBOutlet UILabel *overallAngerPercentage;
@property (weak, nonatomic) IBOutlet UILabel *overallContemptPercentage;
@property (weak, nonatomic) IBOutlet UILabel *overallFearPercentage;
@property (weak, nonatomic) IBOutlet UILabel *overallSurprisePercentage;

@property (weak, nonatomic) IBOutlet UILabel *overallTruthPercentage;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *overallAngerBarConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *overallContemptBarConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *overallFearBarConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *overallSurpriseBarConstraint;
@end
