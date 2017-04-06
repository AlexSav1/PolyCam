//
//  ViewController.h
//  PolyCam
//
//  Created by bl on 2/2/17.
//  Copyright © 2017 bl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CamViewController.h"
#import "StatViewController.h"

@interface MainViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate, CamViewDelegate, StatViewDelegate>

@property UIScrollView *scrollView;

@end

