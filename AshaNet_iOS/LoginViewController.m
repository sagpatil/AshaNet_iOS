//
//  LoginViewController.m
//  AshaNet_iOS
//
//  Created by Patil, Sagar on 7/9/14.
//  Copyright (c) 2014 Patil, Sagar. All rights reserved.
//

#import "LoginViewController.h"
#import "NewProjectViewController.h"
#import "NewEventViewController.h"
#import <Parse/Parse.h>

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
- (IBAction)onLoginTap:(id)sender;
- (IBAction)onBackTap:(id)sender;
- (IBAction)onProjectTap:(id)sender;
- (IBAction)onEventTap:(id)sender;


@end

@implementation LoginViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onLoginTap:(id)sender {
    [PFUser logInWithUsernameInBackground:self.userNameTextField.text password:self.passwordTextField.text
                                    block:^(PFUser *user, NSError *error) {
                                        if (user) {
                                           UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Announcement" message: @"Success Login" delegate: nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                                            
                                            [alert show];
                                            
                                        } else {
                                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Announcement" message: @"Failed Login" delegate: nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                                            
                                            [alert show];
                                        }
                                    }];
    
}

- (IBAction)onBackTap:(id)sender {
   [[self presentingViewController] dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)onProjectTap:(id)sender {
     NewProjectViewController *pVC = [[NewProjectViewController alloc]init];
 
    [self presentViewController:pVC animated:YES completion:nil];
}
- (IBAction)onEventTap:(id)sender {
   
    NewEventViewController *pVC = [[NewEventViewController alloc]init];
    [self presentViewController:pVC animated:YES completion:nil];
}
@end
