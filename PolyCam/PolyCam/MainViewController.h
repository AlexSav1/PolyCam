//
//  ViewController.h
//  PolyCam
//
//  Created by bl on 2/2/17.
//  Copyright © 2017 bl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
//@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

- (IBAction)takePhoto:(UIButton *)sender;

@end

