//
//  ViewController.m
//  PolyCam
//
//  Created by bl on 2/2/17.
//  Copyright © 2017 bl. All rights reserved.
//

#import "MainViewController.h"
#import "CamViewController.h"
#import "StatViewController.h"


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
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    scrollView.bounces = NO;
    scrollView.scrollEnabled = YES;
    scrollView.userInteractionEnabled = YES;
    
    [self.view addSubview:scrollView];
    scrollView.contentSize = CGSizeMake((self.view.frame.size.width * 2), self.view.frame.size.height);
    
    // Create the two VCs- camVC & statVC
    CamViewController *camVC = [[CamViewController alloc]init];
    StatViewController *statVC = [[StatViewController alloc]init];
    
    scrollView.delegate = statVC;
    
    [self addChildViewController:camVC];
    [scrollView addSubview: camVC.view];
    camVC.view.frame = self.view.frame;
    [camVC didMoveToParentViewController:self];
    // camVC.view.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addChildViewController:statVC];
    [scrollView addSubview: statVC.view];
    statVC.view.frame = self.view.frame;
    [statVC didMoveToParentViewController:self];
    // statVC.view.translatesAutoresizingMaskIntoConstraints = NO;
    
    // Shift Stat VC
    CGRect statFrame = statVC.view.frame;
    statFrame.origin.x = self.view.frame.size.width;
    NSLog(@"%f",[[self view] bounds].size.width);
    statVC.view.frame = statFrame;
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
