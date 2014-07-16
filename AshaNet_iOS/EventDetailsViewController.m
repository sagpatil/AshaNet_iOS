//
//  EventDetailsViewController.m
//  AshaNet_iOS
//
//  Created by Savla, Sumit on 7/6/14.
//  Copyright (c) 2014 Patil, Sagar. All rights reserved.
//

#import "EventDetailsViewController.h"
#import "webViewController.h"

@interface EventDetailsViewController ()

@property UIBarButtonItem *rightButton;
@property (weak, nonatomic) IBOutlet UITextView *descTextView;
@property (weak, nonatomic) IBOutlet UITextView *eventTimeTxtView;
@property (weak, nonatomic) IBOutlet UIButton *ticketsBtn;
@property  (nonatomic,assign) NSInteger index;

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
    self.eventAddrTxtView.text = self.selectedEvent.address;
    self.imageView.image = self.selectedEvent.eventImage;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"E, MMM dd, yyyy hh:mm"];
    
    NSString *stringFromDate = [formatter stringFromDate:self.selectedEvent.eventTime];
    self.eventTimeTxtView.text = stringFromDate;
    
    UISwipeGestureRecognizer* swipeUpGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeUpFrom:)];
    swipeUpGestureRecognizer.direction = UISwipeGestureRecognizerDirectionUp;
    
    [self.view addGestureRecognizer:swipeUpGestureRecognizer];

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


- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return  self;
    
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    return self;
}


- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext{
    return 2.0;
}
// This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    UIView *containerView = [transitionContext containerView];
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    toViewController.view.frame = containerView.frame;
    [containerView addSubview:toViewController.view];
    
    toViewController.view.alpha = 0;
    [UIView animateWithDuration:2 animations:^{
        toViewController.view.alpha = 1;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}

- (void) handleSwipeUpFrom:(UIGestureRecognizer*)recognizer {
    NSLog(@"Change me %d",self.index);
    EventDetailsViewController *e = [[EventDetailsViewController alloc]init];
    e.selectedEvent = self.events[self.index++];
    e.events = self.events;
    UISwipeGestureRecognizer* swipeUpGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeUpFrom:)];
    swipeUpGestureRecognizer.direction = UISwipeGestureRecognizerDirectionUp;
    
    [e.view addGestureRecognizer:swipeUpGestureRecognizer];
    
    
//    e.modalPresentationStyle = UIModalPresentationCustom;
//    e.transitioningDelegate = self;
    
    
    [self presentViewController:e animated:YES completion:nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
