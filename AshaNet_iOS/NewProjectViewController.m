//
//  NewProjectViewController.m
//  AshaNet_iOS
//
//  Created by Patil, Sagar on 7/10/14.
//  Copyright (c) 2014 Patil, Sagar. All rights reserved.
//

#import "NewProjectViewController.h"

@interface NewProjectViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation NewProjectViewController

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
    self.scrollView.contentSize =CGSizeMake(320, 700);

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
