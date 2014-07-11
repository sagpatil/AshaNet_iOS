//
//  NewEventViewController.m
//  AshaNet_iOS
//
//  Created by Patil, Sagar on 7/10/14.
//  Copyright (c) 2014 Patil, Sagar. All rights reserved.
//

#import "NewEventViewController.h"
#import <Parse/Parse.h>
#import <QuartzCore/QuartzCore.h>

static NSString *KPlaceHolderText = @"Enter Description Here.. Add ticket prices in description";

@interface NewEventViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;
@property (weak, nonatomic) IBOutlet UITextField *addressTextField;
@property (weak, nonatomic) IBOutlet UITextField *urlTextField;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIButton *dateTimeButton;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (assign, nonatomic) CGPoint orignalCentre;
@property  (nonatomic,strong) NSDate *eventDate;
- (IBAction)onSavetap:(id)sender;
- (IBAction)onCanceltap:(id)sender;
- (IBAction)onSelectPhotoTap:(id)sender;
- (IBAction)onDatePickerButtonTap:(id)sender;
@end

@implementation NewEventViewController

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
    self.datePicker.hidden = YES;
    self.scrollView.contentSize =CGSizeMake(320, 700);
    self.orignalCentre = self.scrollView.center;
    self.urlTextField.delegate = self;
    self.addressTextField.delegate=self;
    self.nameTextField.delegate = self;
    [self.datePicker addTarget:self action:@selector(datePickerChanged:) forControlEvents:UIControlEventValueChanged];
    
    [[self.descriptionTextView layer] setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [[self.descriptionTextView layer] setBorderWidth:0.5];
    [[self.descriptionTextView layer] setCornerRadius:5];
    
    self.descriptionTextView.delegate = self;
    self.descriptionTextView.text = KPlaceHolderText;
    self.descriptionTextView.textColor = [UIColor lightGrayColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)datePickerChanged:(UIDatePicker *)datePicker
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MMMM-yyyy hh:mm a"];
    self.eventDate = datePicker.date;
    NSString *strDate = [dateFormatter stringFromDate:datePicker.date];
    self.dateTimeButton.titleLabel.text = [NSString stringWithFormat:@"        %@",strDate];
}

#pragma mark Button Methods

- (IBAction)onSavetap:(id)sender {
    PFObject *event = [PFObject objectWithClassName:@"Event"];
    event[@"Name"]= self.nameTextField.text;
    event[@"Description"]= self.descriptionTextView.text;
    event[@"Ticket_site_url"] = self.urlTextField.text;
    event[@"Address"] = self.addressTextField.text;
    event[@"Event_time"] = self.eventDate;
    
    NSData *imageData = UIImagePNGRepresentation(self.imageView.image);
    PFFile *imageFile = [PFFile fileWithName:@"image.png" data:imageData];
    event[@"Image"] = imageFile;
    [event saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        NSLog(@"Save Complete");
        [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    }];
}

- (IBAction)onCanceltap:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)onSelectPhotoTap:(id)sender {
     self.datePicker.hidden = YES;
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
}

- (IBAction)onDatePickerButtonTap:(id)sender {
    
    self.scrollView.center = CGPointMake(160,150);
    // add the bwlow line for every textField
    [self.urlTextField resignFirstResponder];
    [self.addressTextField resignFirstResponder];
    [self.nameTextField resignFirstResponder];
    [self.descriptionTextView resignFirstResponder];
    self.datePicker.hidden = NO;
}

#pragma mark UIITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    NSLog(@"Change me");
    self.datePicker.hidden = YES;
    if (textField == self.urlTextField) {
        self.scrollView.center = CGPointMake(160, 200);
    }
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    [self resignFirstResponder];
    self.scrollView.center = CGPointMake(self.orignalCentre.x, self.orignalCentre.y);
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSLog(@"Editing");
    // enter closes the keyboard
    if ([string isEqualToString:@"\n"])
    {
        NSLog(@"Editing ended");
        [textField resignFirstResponder];
        return NO;
    }
    return YES;
}

#pragma mark UIImagePickerControllerDelegate

-(void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
   
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.imageView.image = chosenImage;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark UItextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:KPlaceHolderText]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor]; //optional
    }
    [textView becomeFirstResponder];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""]) {
        textView.text = KPlaceHolderText;
        textView.textColor = [UIColor lightGrayColor]; //optional
    }
    [textView resignFirstResponder];
}
@end
