//
//  FullViewViewController.m
//  AshaNet_iOS
//
//  Created by Patil, Sagar on 7/12/14.
//  Copyright (c) 2014 Patil, Sagar. All rights reserved.
//

#import "FullViewViewController.h"
#import "NewEventViewController.h"

@interface FullViewViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *fullscreenDesciption;
@property (weak, nonatomic) IBOutlet UIView *overlayView;
@property (weak, nonatomic) IBOutlet UIButton *onDollarbuttonClicked;
- (IBAction)onDollarBUttontap:(id)sender;
- (IBAction)handlePan:(id)sender;
- (IBAction)onEditTap:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *editButton;

@end

@implementation FullViewViewController

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
 
    self.fullscreenDesciption.text = self.selectedEvent.description;
    self.nameLabel.text = self.selectedEvent.name;
    self.imageView.image = self.selectedEvent.eventImage;
  //  self.navigationController.navigationBar.hidden = YES;
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.name = @"gradientLayer";
     CGRect frame = self.overlayView.bounds;
   // frame.size.height = 171;
    gradient.frame = frame;
    gradient.colors = [NSArray arrayWithObjects:(id)[UIColor clearColor].CGColor, (id)[UIColor orangeColor].CGColor, nil];
    gradient.startPoint = CGPointMake(1.0f, 0.0f);
    gradient.endPoint = CGPointMake(1.0f, 1.0f);
        [self.overlayView.layer insertSublayer:gradient atIndex:0];
   // [self.overlayView.layer insertSublayer:gradient above:self.gradientView.layer];
    self.overlayView.backgroundColor = [UIColor clearColor];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
   // NSLog(@"Change me");
    if (touch.view == self.overlayView)
    {
        // remove the rpevious added gradient layer
        for (CALayer *layer in self.overlayView.layer.sublayers) {
            if ([layer.name isEqualToString: @"gradientLayer"]) {
                [self.overlayView.layer.sublayers[0] removeFromSuperlayer];
                break;
            }
            
        }
        
        [UIView animateKeyframesWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.overlayView.center = CGPointMake(160, 450);
            self.overlayView.backgroundColor = [UIColor colorWithRed:255/255.0 green:128/255.0 blue:0/255.0 alpha:0.7];
            self.fullscreenDesciption.alpha = 1;

        } completion:^(BOOL finished) {}];
        
    }
}


- (IBAction)onDollarBUttontap:(id)sender {
    NSLog(@"Change me");
}

- (IBAction)handlePan:(id)sender {
    UIPanGestureRecognizer *recognizer = sender;
    
    CGPoint translation = [recognizer translationInView:self.view];
    recognizer.view.center = CGPointMake(recognizer.view.center.x ,
                                         recognizer.view.center.y + translation.y);
    [recognizer setTranslation:CGPointMake(0, 0) inView:self.view];
    
    
    if (recognizer.state == UIGestureRecognizerStateChanged) {
        CGPoint fp = recognizer.view.center;
        if(recognizer.view.center.y < 450)
            fp.y = 450;
    }
    if (recognizer.state == UIGestureRecognizerStateEnded) {

        CGPoint fp = recognizer.view.center;
        if(recognizer.view.center.y < 450)
            fp.y = 450;
            
        
        [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            recognizer.view.center = fp;
        } completion:nil];
        
    }

}

- (IBAction)onEditTap:(id)sender {
    NewEventViewController *evc = [[NewEventViewController alloc]initWithEvent:self.selectedEvent];
    
    [self presentViewController:evc animated:YES completion:nil];
}
@end
