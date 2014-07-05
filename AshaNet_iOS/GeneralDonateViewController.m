//
//  GeneralDonateViewController.m
//  AshaNet_iOS
//
//  Created by Savla, Sumit on 7/5/14.
//  Copyright (c) 2014 Patil, Sagar. All rights reserved.
//

#import "GeneralDonateViewController.h"


// Set the environment:
// - For live charges, use PayPalEnvironmentProduction (default).
// - To use the PayPal sandbox, use PayPalEnvironmentSandbox.
// - For testing, use PayPalEnvironmentNoNetwork.
#define kPayPalEnvironment PayPalEnvironmentNoNetwork

static NSString *kSandboxClientId = @"ARmjaBDYxJcXYErMEQdaCnvE5h4vgYxtS9XJo7OTi_ZohebxT7qvMsC-1Vml";
static NSString *kProductionClientId = @"Add Production key here for ASha";

@interface GeneralDonateViewController ()
- (IBAction)onDonateTap:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *successView;
@property (weak, nonatomic) IBOutlet UITextField *donationAmountTextField;
@property (weak, nonatomic) IBOutlet UIButton *donateButton;

@property(nonatomic, strong, readwrite) PayPalConfiguration *payPalConfig;

@end

@implementation GeneralDonateViewController

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
    // Set up payPalConfig
    self.payPalConfig = [[PayPalConfiguration alloc] init];
    self.payPalConfig.acceptCreditCards = YES;
    self.payPalConfig.languageOrLocale = @"en";
    self.payPalConfig.merchantName = @"AshaNet.Org";
    self.payPalConfig.merchantPrivacyPolicyURL = [NSURL URLWithString:@"https://www.paypal.com/webapps/mpp/ua/privacy-full"];
    self.payPalConfig.merchantUserAgreementURL = [NSURL URLWithString:@"https://www.paypal.com/webapps/mpp/ua/useragreement-full"];
    self.payPalConfig.languageOrLocale = [NSLocale preferredLanguages][0];
    
    // Do any additional setup after loading the view, typically from a nib.
    
    self.successView.hidden = YES;
    
    // use default environment, should be Production in real life
    self.environment = kPayPalEnvironment;

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
     NSDictionary *keys =  @{PayPalEnvironmentProduction : kProductionClientId,
                             PayPalEnvironmentSandbox : kSandboxClientId};
    
    [PayPalMobile initializeWithClientIdsForEnvironments:keys];
    
    // Preconnect to PayPal early
    [PayPalMobile preconnectWithEnvironment:self.environment];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onDonateTap:(id)sender {
    
    // Remove our last completed payment, just for demo purposes.
    self.resultText = nil;
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Invalid amount"
                                                      message:@"Please enter a valid value greater than 0"
                                                     delegate:nil
                                            cancelButtonTitle:@"OK"
                                            otherButtonTitles:nil];
    
 
    NSDecimalNumber *total = [NSDecimalNumber decimalNumberWithString:self.donationAmountTextField.text];
    if ([[NSDecimalNumber notANumber] isEqualToNumber:total])
    {
        NSLog(@"Not a valid nuber entered");
        [message show];
        return;
    }
    
    else if (total.floatValue <= 0){
        NSLog(@"Amount Less than 0");        
        [message show];
        return;
    }
    
    
    PayPalPayment *payment = [[PayPalPayment alloc] init];
    payment.amount = total;
    payment.currencyCode = @"USD";
    payment.shortDescription = @"Donation towards Ashanet";
    payment.intent = PayPalPaymentIntentSale;
    
    if (!payment.processable) {
        
        NSLog(@"Payment not processable");
        // This particular payment will always be processable. If, for
        // example, the amount was negative or the shortDescription was
        // empty, this payment wouldn't be processable, and you'd want
        // to handle that here.
    }
    PayPalPaymentViewController *paymentViewController = [[PayPalPaymentViewController alloc] initWithPayment:payment
                                                                                                configuration:self.payPalConfig
                                                                                                     delegate:self];
    [self presentViewController:paymentViewController animated:YES completion:nil];

}


#pragma mark PayPalPaymentDelegate methods

- (void)payPalPaymentViewController:(PayPalPaymentViewController *)paymentViewController didCompletePayment:(PayPalPayment *)completedPayment {
    NSLog(@"PayPal Payment Success!");
    self.resultText = [completedPayment description];
    [self showSuccess];
    self.donationAmountTextField.text = @"";
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

@end
