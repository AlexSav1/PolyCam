//
//  CamViewController.m
//  PolyCam
//
//  Created by Jerry Chen on 2/2/17.
//  Copyright © 2017 bl. All rights reserved.
//

#import "CamViewController.h"
#import <AVFoundation/AVFoundation.h>

// Define RGB colors
#define UIColorFromRGB(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >>  8))/255.0 \
blue:((float)((rgbValue & 0x0000FF) >>  0))/255.0 \
alpha:1.0]

@interface CamViewController ()

@end

@implementation CamViewController

//////////////////////////////////////////////////////////////////////////////////////////
//
//  viewDidLoad, viewWillAppear, viewDidAppear
//
//////////////////////////////////////////////////////////////////////////////////////////
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // UI Adjustments
    // Header
    self.tipLabel.backgroundColor = UIColorFromRGB(0xdd7684);
    self.tipLabel.layer.masksToBounds = YES;
    self.tipLabel.layer.cornerRadius = 20.0;
    
    // Snap Btn
    UIImage *snapBtnImage = [UIImage imageNamed:@"snapBtn.png"];
    [self.snapBtn setImage:snapBtnImage forState:UIControlStateNormal];
    UIImage *statsBtnImage = [UIImage imageNamed:@"stats.png"];
    [self.statBtn setImage:statsBtnImage forState:UIControlStateNormal];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.previewLayer.frame = self.cameraView.bounds; 
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // Adjust on-screen assets
    self.logoWithText.image = [self.logoWithText.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.logoWithText.tintColor = [UIColor whiteColor];
    
    self.captureSession = [[AVCaptureSession alloc]init];
    self.captureSession.sessionPreset = AVCaptureSessionPreset1920x1080;
    
    AVCaptureDevice *backCamera = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    // NSError *error = [[NSError alloc]init];
    
    AVCaptureDeviceInput *deviceInput = [AVCaptureDeviceInput deviceInputWithDevice:backCamera error:nil];
    
    if ([self.captureSession canAddInput:deviceInput]) {
        [self.captureSession addInput:deviceInput];
        
         self.imageOutput = [[AVCaptureStillImageOutput alloc]init];
        self.imageOutput.outputSettings = [[NSDictionary alloc] initWithObjectsAndKeys: AVVideoCodecJPEG, AVVideoCodecKey, nil];
        
        if ([self.captureSession canAddOutput:self.imageOutput]) {
            [self.captureSession addOutput:self.imageOutput];
            
            self.previewLayer = [[AVCaptureVideoPreviewLayer alloc]initWithSession:self.captureSession];
            [self.previewLayer setVideoGravity:AVLayerVideoGravityResizeAspect];
            [self.previewLayer.connection setVideoOrientation:AVCaptureVideoOrientationPortrait];
            
            [self.cameraView.layer addSublayer:self.previewLayer];
            
            [self.captureSession startRunning];
        }
    }
}

- (void)didTakePhoto {
}

//////////////////////////////////////////////////////////////////////////////////////////
//
//  Actions
//
//////////////////////////////////////////////////////////////////////////////////////////
- (IBAction)snapBtnPrsd:(id)sender {
    AVCaptureConnection *videoConnection = nil;
    
    for (AVCaptureConnection *connection in self.imageOutput.connections) {
        for (AVCaptureInputPort *inputPort in [connection inputPorts]) {
            if ([[inputPort mediaType] isEqual:AVMediaTypeVideo]) {
                videoConnection = connection;
                break;
            }
        }
        if (videoConnection) {
            break;
        }
    }
    
    [self.imageOutput captureStillImageAsynchronouslyFromConnection:videoConnection completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
        if (imageDataSampleBuffer != NULL) {
            NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
            UIImage *image = [UIImage imageWithData: imageData];
            self.previewView.image = image;
        }
    }];

}
//
- (IBAction)testBtnPrsd:(id)sender {
    
    // Input
    double truthfulness = 35.6;
    int questionCount = 2;
    
    // Animation
    CATransition *animation = [CATransition animation];
    animation.duration = 1.0;
    animation.type = kCATransitionFade;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.questionLabel.layer addAnimation:animation forKey:@"changeTextTransition"];
    [self.feedbackLabel.layer addAnimation:animation forKey:@"changeTextTransition"];
    [self.feedbackLabel2.layer addAnimation:animation forKey:@"changeTextTransition"];
    [self.tipLabel.layer addAnimation:animation forKey:@"changeTextTransition"];

    
    
    // Change the text
    self.questionLabel.text = [NSString stringWithFormat:@"Question #%d", questionCount];
    self.feedbackLabel2.text = @"Likely Truthful";
    self.tipLabel.text = [NSString stringWithFormat:@"%.0f%%", truthfulness];
    
    // Conditional Updates
    if (truthfulness <= 50) {
        self.tipLabel.backgroundColor = UIColorFromRGB(0xdd7684);
        self.tickerView.backgroundColor = UIColorFromRGB(0xac0101);
        self.feedbackLabel2.text = @"Likely Lying";
    } else {
        self.tipLabel.backgroundColor = UIColorFromRGB(0x8de37e);
        self.feedbackLabel2.textColor = UIColorFromRGB(0x8de37e);
        self.feedbackLabel2.text = @"Likely Truthful";
    }

}
@end
