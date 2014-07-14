//
//  GeneralDonateViewController.m
//  AshaNet_iOS
//
//  Created by Savla, Sumit on 7/5/14.
//  Copyright (c) 2014 Patil, Sagar. All rights reserved.
//

#import "GeneralDonateViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "PayPalConfig.h"
#import <Parse/Parse.h>
#import "MBProgressHUD.h"


@interface GeneralDonateViewController ()
- (IBAction)onDonateTap:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *successView;
@property (weak, nonatomic) IBOutlet UITextField *donationAmountTextField;
@property (weak, nonatomic) IBOutlet UIButton *donateButton;
@property (weak, nonatomic) IBOutlet UIPickerView *chapterPickerView;

@property (weak, nonatomic) IBOutlet UILabel *selectedChapterLabel;


@property(nonatomic, strong, readwrite) PayPalConfiguration *payPalConfig;
@property (strong, nonatomic) NSMutableArray *chapterArray;
@property (strong, nonatomic) NSString * chapterToDonateTo;
@property (nonatomic, strong) NSNumber *donationAmount;
@end

@implementation GeneralDonateViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.chapterArray = [[NSMutableArray alloc]init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"Donate to Chapter";
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self loadChapters];
    
    PayPalConfig *PPconfig  = [PayPalConfig sharedConfig];
    [PPconfig setupForTakingPayments];
    
    
    UITapGestureRecognizer *tapGesture =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelTap)];
    [self.selectedChapterLabel addGestureRecognizer:tapGesture];
    
    self.successView.hidden = YES;
    
    self.chapterPickerView.delegate = self;
    self.chapterPickerView.dataSource = self;
    self.chapterPickerView.showsSelectionIndicator = YES;
    self.chapterPickerView.hidden = YES;
    
    //add border to the Label
    CALayer * layer = [self.selectedChapterLabel layer];
    [layer setMasksToBounds:YES];
    [layer setCornerRadius:5.0]; //when radius is 0, the border is a rectangle
    [layer setBorderWidth:0.5];
    [layer setBorderColor:[[UIColor lightGrayColor] CGColor]];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Donate Button action
- (IBAction)onDonateTap:(id)sender {
   

   
    [self resignFirstResponder];
    self.resultText = nil;
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Invalid amount"
                                                      message:@"Please enter a valid value greater than 0"
                                                     delegate:nil
                                            cancelButtonTitle:@"OK"
                                            otherButtonTitles:nil];
    
 
    NSDecimalNumber *total = [NSDecimalNumber decimalNumberWithString:self.donationAmountTextField.text];
    if ([[NSDecimalNumber notANumber] isEqualToNumber:total]){
        NSLog(@"Not a valid nuber entered");
        [message show];
        return;
    }
    else if (total.floatValue <= 0){
        NSLog(@"Amount Less than 0");
        [message show];
        return;
    }
    
    self.chapterPickerView.hidden=YES;
    self.donationAmount = total;
    
    PayPalPayment *payment = [[PayPalPayment alloc] init];
    payment.amount = total;
    payment.currencyCode = @"USD";
    payment.shortDescription = [NSString stringWithFormat:@"Donation to %@ chapter of Ashanet",self.chapterToDonateTo];
    payment.intent = PayPalPaymentIntentSale;
    
    if (!payment.processable) {
        NSLog(@"Payment not processable");
    }
    PayPalPaymentViewController *paymentViewController = [[PayPalPaymentViewController alloc] initWithPayment:payment
                                                                                                configuration:self.payPalConfig
                                                                                                     delegate:self];
    [self presentViewController:paymentViewController animated:YES completion:nil];

}

#pragma mark - UIPicker View methods

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row   forComponent:(NSInteger)component
{
    return [self.chapterArray objectAtIndex:row];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row   inComponent:(NSInteger)component
{
    self.chapterToDonateTo = self.chapterArray[row];
    self.selectedChapterLabel.text = self.chapterToDonateTo;
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent: (NSInteger)component{
    return self.chapterArray.count;
    
}


#pragma mark PayPalPaymentDelegate methods

- (void)payPalPaymentViewController:(PayPalPaymentViewController *)paymentViewController didCompletePayment:(PayPalPayment *)completedPayment {
    NSLog(@"PayPal Payment Success!");
    self.resultText = [completedPayment description];
    [self showSuccess];
    self.chapterPickerView.hidden = YES;
    self.donationAmountTextField.text = @"";
    self.selectedChapterLabel.text = @"Tap to Select";
    [self sendCompletedPaymentToServer:completedPayment]; // Payment was processed successfully; send to server for verification and fulfillment
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)payPalPaymentDidCancel:(PayPalPaymentViewController *)paymentViewController {
    NSLog(@"PayPal Payment Canceled");
    self.resultText = nil;
    self.successView.hidden = YES;
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark Proof of payment validation

- (void)sendCompletedPaymentToServer:(PayPalPayment *)completedPayment {
    NSLog(@"Here is your proof of payment:\n\n%@\n\nSend this to your Parse.com for confirmation and fulfillment.", completedPayment.confirmation);
    NSDictionary *response = (NSDictionary*)completedPayment.confirmation;
    PFObject *donation = [PFObject objectWithClassName:@"Donations"];
    donation[@"donation_amount"] = self.donationAmount;
    donation[@"chapter"] = self.chapterToDonateTo;
    donation[@"paypal_confirmation_id"] = response[@"response"][@"id"];
    [donation saveInBackground];
}


#pragma mark - Helpers

// Animation effect where the success message can be shown on our View controller which disappears after 2 seconds
- (void)showSuccess {
    self.successView.hidden = NO;
    self.successView.alpha = 1.0f;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDelay:2.0];
    self.successView.alpha = 0.0f;
    [UIView commitAnimations];
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
 // DIssmiss keyboard if touched anywhere else on the screen
    if ([self.donationAmountTextField isFirstResponder] && [touch view] != self.donationAmountTextField) {
        [self.donationAmountTextField resignFirstResponder];
    }
    [super touchesBegan:touches withEvent:event];
}

- (void)labelTap{
    [self resignFirstResponder];
    [self.selectedChapterLabel becomeFirstResponder];
    self.chapterPickerView.hidden = NO;
}


- (void)loadChapters{
    PFQuery *query = [PFQuery queryWithClassName:@"Chapter"];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %lu records.", (unsigned long)objects.count);
            for (PFObject *object in objects) {
               // NSLog(@"%@", object[@"name"]);
                [self.chapterArray addObject:object[@"name"]];
            }

            [self.chapterPickerView reloadAllComponents];
            [MBProgressHUD hideHUDForView:self.view animated:YES];

        } else {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Error"
                                                              message:@"Failed to retreive the list of chapters from the Backend"
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles:nil];
            [message show];
        }
    }];

    
  
    }
@end
