//
//  EventDetailsViewController.m
//  AshaNet_iOS
//
//  Created by Savla, Sumit on 7/6/14.
//  Copyright (c) 2014 Patil, Sagar. All rights reserved.
//

#import "EventDetailsViewController.h"
#import "webViewController.h"
#import "NewEventViewController.h"

@interface EventDetailsViewController ()

@property UIBarButtonItem *rightButton;
@property (weak, nonatomic) IBOutlet UITextView *descTextView;
@property (weak, nonatomic) IBOutlet UITextView *eventTimeTxtView;
@property (weak, nonatomic) IBOutlet UIButton *ticketsBtn;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;


@property (weak, nonatomic) IBOutlet UIView *gradientView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITextView *eventAddrTxtView;
@end

@implementation EventDetailsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (IBAction)onRSVPBtn:(id)sender {
    webViewController *webVC = [[webViewController alloc]initWithNibName:@"webViewController" bundle:nil];
    webVC.url = [NSURL URLWithString:self.selectedEvent.ticketUrl];
    [self presentViewController:webVC animated:YES completion:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = self.selectedEvent.name;
    self.rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Share" style:UIBarButtonItemStylePlain target:self action:@selector(onRightButton:)];
    self.navigationItem.rightBarButtonItem = self.rightButton;
    
    self.ticketsBtn.backgroundColor = [UIColor orangeColor];
    self.ticketsBtn.layer.borderColor = [UIColor blackColor].CGColor;
    self.ticketsBtn.layer.borderWidth = 0.5f;
    self.ticketsBtn.layer.cornerRadius = 10.0f;
    
    self.descTextView.text = self.selectedEvent.description;
    self.descriptionLabel.text = self.selectedEvent.description;
    self.eventAddrTxtView.text = self.selectedEvent.address;
    self.imageView.image = self.selectedEvent.eventImage;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"E, MMM dd, yyyy hh:mm"];
    
    NSString *stringFromDate = [formatter stringFromDate:self.selectedEvent.eventTime];
    self.eventTimeTxtView.text = stringFromDate;
    
    CGSize textViewSize = [self.selectedEvent.description
                           sizeWithFont:[UIFont fontWithName:@"Helvetica" size:20]
                           constrainedToSize:CGSizeMake(320, FLT_MAX)
                           lineBreakMode:NSLineBreakByWordWrapping];
    CGRect frame = self.descTextView.frame;
    frame.size.height = textViewSize.height;
    self.descTextView.frame = frame;
    [self.descTextView setFont:[UIFont fontWithName:@"Helvetica" size:18]];
    self.gradientView.center = CGPointMake(160, 355);
    
    //self.descTextView.textColor=[UIColor blackColor];
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.descTextView.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)[UIColor clearColor].CGColor, (id)[UIColor orangeColor].CGColor, nil];
    gradient.startPoint = CGPointMake(1.0f, 0.0f);
    gradient.endPoint = CGPointMake(1.0f, 1.0f);
    [self.gradientView.layer insertSublayer:gradient atIndex:0];
    
    self.gradientView.backgroundColor = [UIColor clearColor];
    self.descTextView.backgroundColor = [UIColor clearColor];

    
//    gradient.frame = self.descTextView.bounds;
//    gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.1] CGColor],(id)[[UIColor orangeColor] CGColor],nil];
//
//    //gradient.colors = [NSArray arrayWithObjects:(id)[UIColor clearColor].CGColor, (id)[UIColor orangeColor].CGColor, nil];
//    [self.descTextView.layer insertSublayer:gradient atIndex:0];
//    [self.view bringSubviewToFront:self.descTextView];
    
    
}

- (IBAction)onRightButton:(id)sender
{
    NSMutableArray *sharingItems = [NSMutableArray new];
    
    NSArray *lines = @[@"Event information", [NSString stringWithFormat:@"Address: %@", self.selectedEvent.address], @"RSVP Below:", self.selectedEvent.ticketUrl];
    NSString *linesString = [lines componentsJoinedByString:@"\n\n"];
    
    [sharingItems addObject: linesString];
    
    UIActivityViewController *activityController = [[UIActivityViewController alloc] initWithActivityItems:sharingItems applicationActivities:nil];
    [self presentViewController:activityController animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    NSLog(@"Change me");
    if (touch.view == self.gradientView)
    {
        [UIView animateKeyframesWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.gradientView.center = CGPointMake(160, 355);
        } completion:^(BOOL finished) {
            
        }];
        
    }
}



@end
