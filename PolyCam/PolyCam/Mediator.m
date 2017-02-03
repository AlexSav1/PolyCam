//
//  Mediator.m
//  PolyCam
//
//  Created by bl on 2/2/17.
//  Copyright © 2017 bl. All rights reserved.
//


#import "Mediator.h"
#import "StatViewController.h"
#import "CustomTableViewCell.h"


static BackEnd *_backEnd;
static NSMutableArray *_questions;


@implementation Mediator
{
    UIImage *_photo;
    NSData *_imageData;
    double _totalAnger;
    double _totalFear;
    double _totalContempt;
    double _totalSurprise;
    NSInteger _count;
}

//////////////////////////////////////////////////////////////////////////////////////////
//
//  Method implements the singleton pattern for this class.
//
//////////////////////////////////////////////////////////////////////////////////////////
+ (Mediator *)sharedInstance
{
    static Mediator *_sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate,
                  ^{
                      _sharedInstance = [[Mediator alloc] init];
                      _backEnd = [[BackEnd alloc] init];
                      _questions = [[NSMutableArray alloc] init];
                  });
    
    return _sharedInstance;
}

//////////////////////////////////////////////////////////////////////////////////////////
//
//  Method to start processing the image.
//
//////////////////////////////////////////////////////////////////////////////////////////
- (void) processPhoto:(UIImage *)photo
{
    // Initialize delgate here because it generate a warning when it is done in a class method
    if (nil == _backEnd.delegate)
        _backEnd.delegate = self;
    
    _photo = photo;
    _imageData = UIImageJPEGRepresentation(photo, 0.0);
    
    [_backEnd sendToEmotionAPI:_imageData];
}

//////////////////////////////////////////////////////////////////////////////////////////
//
//  Delegate method called by the BackEnd.
//
//////////////////////////////////////////////////////////////////////////////////////////
- (void) didSendToEmotionAPI:(Question *)question
{
    question.photo = _photo;
    
    // Maintain running total
    _totalAnger += question.anger;
    _totalContempt += question.contempt;
    _totalFear += question.fear;
    _totalSurprise += question.surprise;
    ++_count;
    
    // Calculate overall average
    self.averageOverallAnger = _totalAnger / (double)_count;
    self.averageOverallContempt = _totalContempt / (double)_count;
    self.averageOverallFear = _totalFear / (double)_count;
    self.averageOverallSurprise = _totalSurprise / (double)_count;
    
    self.questionCount = _count;

    self.truthfulness = (question.anger + question.fear) * 10.0;
    question.truthfulness = self.truthfulness;

    double total = (question.anger + question.contempt + question.fear + question.surprise);
    
    question.angerPercentage = (question.anger / total);
    question.contemptPercentage = (question.contempt / total);
    question.fearPercentage = (question.fear / total);
    question.surprisePercentage = (question.surprise / total);
    
    [_questions addObject:question];
    
    [self.delegate didProcessPhoto:question];
}

#pragma mark - Table view data source

//////////////////////////////////////////////////////////////////////////////////////////
//
//  Delegate method that return if the specified row can move or not.
//
//////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

//////////////////////////////////////////////////////////////////////////////////////////
//
//  Delegate method to specify the number of section in the tableView.
//
//////////////////////////////////////////////////////////////////////////////////////////
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

//////////////////////////////////////////////////////////////////////////////////////////
//
//  Delegate method to specify the number of rows in the tableView.
//
//////////////////////////////////////////////////////////////////////////////////////////
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return _questions.count;
}

//////////////////////////////////////////////////////////////////////////////////////////
//
//  Delegate method to specify if the current row is editable.
//
//////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

//////////////////////////////////////////////////////////////////////////////////////////
//
//  Delegate method for loading data into current row of the tableView.
//
//////////////////////////////////////////////////////////////////////////////////////////

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (nil == cell)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:CellIdentifier];
    
    // Get the corresponding question result
    Question *question = _questions[indexPath.row];
    
    // Load current cell with the question result
    cell.textLabel.text = [NSString stringWithFormat:@"Question %ld", indexPath.row + 1];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%f%%", question.truthfulness * 100.0];
//    cell.imageView.image = ;

    return cell;
}



#pragma mark - Table view delegate

//////////////////////////////////////////////////////////////////////////////////////////
//
//  Delegate method to return the size of the section header.
//
//////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    // Return 0, there is no need to display a section header in this screen.
    return 0.0;
}

//////////////////////////////////////////////////////////////////////////////////////////
//
//  Delegate method to return the size of each row in points (not pixel).
//
//////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0;
}

@end
