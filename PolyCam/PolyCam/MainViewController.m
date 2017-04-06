//
//  ViewController.m
//  PolyCam
//
//  Created by bl on 2/2/17.
//  Copyright © 2017 bl. All rights reserved.
//

#import "MainViewController.h"
#import "AppDelegate.h"


@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%f",[[self view] bounds].size.width);

    
    
    self.view.backgroundColor = [UIColor blackColor];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    self.scrollView.bounces = NO;
    self.scrollView.scrollEnabled = YES;
    self.scrollView.userInteractionEnabled = YES;
    self.scrollView.pagingEnabled = YES;
    
    [self.view addSubview:self.scrollView];
    self.scrollView.contentSize = CGSizeMake((self.view.frame.size.width * 2), self.view.frame.size.height);
    
    // Create the two VCs- camVC & statVC
    CamViewController *camVC = [[CamViewController alloc]init];
    StatViewController *statVC = [[StatViewController alloc]init];
    camVC.delegate = self;
    statVC.delegate = self;
    
    self.scrollView.delegate = statVC;
    
    [self addChildViewController:camVC];
    [self.scrollView addSubview: camVC.view];
    camVC.view.frame = self.view.frame;
    [camVC didMoveToParentViewController:self];
    // camVC.view.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addChildViewController:statVC];
    [self.scrollView addSubview: statVC.view];
    statVC.view.frame = self.view.frame;
    [statVC didMoveToParentViewController:self];
    // statVC.view.translatesAutoresizingMaskIntoConstraints = NO;
    
    // Shift Stat VC
    CGRect statFrame = statVC.view.frame;
    statFrame.origin.x = self.view.frame.size.width;
    NSLog(@"%f",[[self view] bounds].size.width);
    statVC.view.frame = statFrame;
    
}

- (void) shiftToStatView{
    CGRect newFrame = self.view.frame;
    newFrame.origin.x = self.view.frame.size.width;
    
    [self.scrollView scrollRectToVisible:newFrame animated:TRUE];
}

-(void) shiftToCamView{
    
    [self.scrollView scrollRectToVisible:self.view.frame animated:TRUE];
    
}

#if 0
//////////////////////////////////////////////////////////////////////////////////////////
//
//  Method is called when the user pushes the button
//
//////////////////////////////////////////////////////////////////////////////////////////
- (IBAction)takePhoto:(UIButton *)sender
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = NO;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:NULL];
}

//////////////////////////////////////////////////////////////////////////////////////////
//
//  Delegate method called after picture is taken.
//
//////////////////////////////////////////////////////////////////////////////////////////
- (void) imagePickerController:(UIImagePickerController *)picker
 didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *chosenImage = info[UIImagePickerControllerOriginalImage];
    self.imageView.image = chosenImage;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
    // call backend
}
#endif

@end
