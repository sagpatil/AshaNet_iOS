//
//  ProjectDetailsViewController.m
//  AshaNet_iOS
//
//  Created by Savla, Sumit on 7/5/14.
//  Copyright (c) 2014 Patil, Sagar. All rights reserved.
//

#import "ProjectDetailsViewController.h"

@interface ProjectDetailsViewController ()

@property UIBarButtonItem *rightButton;

@end

@implementation ProjectDetailsViewController

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
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"Aseema Charitable Trust - Rural Education Centre";
    self.rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Share" style:UIBarButtonItemStylePlain target:self action:@selector(onRightButton:)];
    self.navigationItem.rightBarButtonItem = self.rightButton;
}

- (IBAction)onRightButton:(id)sender
{
    NSMutableArray *sharingItems = [NSMutableArray new];
    
    
    NSArray *lines = @[@"Asha for Education \n Project information", @"http://www.ashanet.org/projects/project-view.php?p=855"];
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

@end
