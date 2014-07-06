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


static NSString *kSandboxClientId = @"ARmjaBDYxJcXYErMEQdaCnvE5h4vgYxtS9XJo7OTi_ZohebxT7qvMsC-1Vml";
static NSString *kProductionClientId = @"Add Production key here for ASha";

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
    
    PayPalConfig *PPconfig  = [PayPalConfig sharedConfig];
    [PPconfig setupForTakingPayments];
    
    UITapGestureRecognizer *tapGesture =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelTap)];
    [self.selectedChapterLabel addGestureRecognizer:tapGesture];
    
    
    self.successView.hidden = YES;
    
    [self loadChapters];
    ///#TODO update the array form list of chapters coming from PArse
//    self.chapterArray  = [[NSArray alloc] initWithObjects:@"Blue",@"Green",@"Orange",@"Purple",@"Red",@"Yellow" , nil];
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

    
    //#TODO  Find a pay to send the chapter donated to the Paypal as transaction parameter (self.chapterToDonateTo will comtain value to be sent)
    
    PayPalPayment *payment = [[PayPalPayment alloc] init];
    payment.amount = total;
    payment.currencyCode = @"USD";
    payment.shortDescription = @"Donation towards Ashanet";
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
     NSLog(@"Selected Row %d",row);
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
    // TODO: Send completedPayment.confirmation to server
    NSLog(@"Here is your proof of payment:\n\n%@\n\nSend this to your Parse.com for confirmation and fulfillment.", completedPayment.confirmation);
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
    // Blocking call will block the thread till this network call is executed
    NSArray *objects = [query findObjects];
    for (PFObject *object in objects) {
        NSLog(@"%@", object[@"name"]);
        [self.chapterArray addObject:object[@"name"]];
    }
    

}
@end
