//
//  CamViewController.h
//  PolyCam
//
//  Created by Jerry Chen on 2/2/17.
//  Copyright © 2017 bl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "Mediator.h"

@protocol CamViewDelegate <NSObject>

- (void) shiftToStatView;

@end

@interface CamViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, MediatorDelegate>

@property (nonatomic) id <CamViewDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UIView *tickerView;

@property (weak, nonatomic) IBOutlet UIView *horizontalDiv;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *questionLabel;
@property (weak, nonatomic) IBOutlet UILabel *feedbackLabel;
@property (weak, nonatomic) IBOutlet UILabel *feedbackLabel2;

@property (weak, nonatomic) IBOutlet UIView *cameraView;
@property (weak, nonatomic) IBOutlet UIImageView *previewView;

@property (weak, nonatomic) IBOutlet UIImageView *logoWithText;
@property (weak, nonatomic) IBOutlet UIButton *snapBtn;
@property (weak, nonatomic) IBOutlet UIButton *statBtn;
@property (weak, nonatomic) IBOutlet UIView *loadingView;
@property (weak, nonatomic) IBOutlet UILabel *dismissLabel;

// Video Related Assets
@property (strong, nonatomic) AVCaptureSession *captureSession;
@property (strong, nonatomic) AVCaptureStillImageOutput *imageOutput;
@property (strong, nonatomic) AVCaptureVideoPreviewLayer *previewLayer;

// Actions
- (IBAction)snapBtnPrsd:(id)sender;
- (IBAction)testBtnPrsd:(id)sender;
- (IBAction)testLoadingBtnPrsd:(id)sender;
- (IBAction)dismissLoading:(id)sender;
- (IBAction)okBtnPrsd:(id)sender;


@end
