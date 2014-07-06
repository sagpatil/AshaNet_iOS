//
//  EventDetailsViewController.m
//  AshaNet_iOS
//
//  Created by Savla, Sumit on 7/6/14.
//  Copyright (c) 2014 Patil, Sagar. All rights reserved.
//

#import "EventDetailsViewController.h"

@interface EventDetailsViewController ()

@property UIBarButtonItem *rightButton;

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"SF Half Marathon";
    self.rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Share" style:UIBarButtonItemStylePlain target:self action:@selector(onRightButton:)];
    self.navigationItem.rightBarButtonItem = self.rightButton;
}

- (IBAction)onRightButton:(id)sender
{
    NSMutableArray *sharingItems = [NSMutableArray new];
    
    [sharingItems addObject:@"Event information"];
    [sharingItems addObject:@"RSVP Below:"];
    [sharingItems addObject:@"https://www.facebook.com/events/1418622448387884"];
    
    UIActivityViewController *activityController = [[UIActivityViewController alloc] initWithActivityItems:sharingItems applicationActivities:nil];
    [self presentViewController:activityController animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
