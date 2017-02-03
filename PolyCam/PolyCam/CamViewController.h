//
//  CamViewController.h
//  PolyCam
//
//  Created by Jerry Chen on 2/2/17.
//  Copyright © 2017 bl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface CamViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

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

// Video Related Assets
@property (strong, nonatomic) AVCaptureSession *captureSession;
@property (strong, nonatomic) AVCaptureStillImageOutput *imageOutput;
@property (strong, nonatomic) AVCaptureVideoPreviewLayer *previewLayer;

// Actions
- (IBAction)snapBtnPrsd:(id)sender;
- (IBAction)testBtnPrsd:(id)sender;

@end
