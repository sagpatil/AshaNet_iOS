//
//  HomeViewController.m
//  AshaNet_iOS
//
//  Created by Patil, Sagar on 7/14/14.
//  Copyright (c) 2014 Patil, Sagar. All rights reserved.
//

#import "HomeViewController.h"
#import "Event.h"
#import "Project.h"
#import <Parse/Parse.h>
#import "MBProgressHUD.h"
#import "EventDetailsViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface HomeViewController ()
@property (nonatomic, strong) NSMutableArray *events;
@property (nonatomic, strong) NSMutableArray *projects;
- (IBAction)onTap:(id)sender;
@property (nonatomic,strong)  NSLock *lock;
@property  (nonatomic,assign) NSInteger index;
@property (strong, nonatomic) MPMoviePlayerController *moviePlayer;
@end

@implementation HomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.projects = [[NSMutableArray alloc]init];
        self.events = [[NSMutableArray alloc]init];
        self.index =0;
           }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];


    [self getEventsFromParse];
    [self getProjectsFromParse];
    [self.lock lock];
    NSLog(@"Change me");
    NSURL* mMovieURL;
    NSBundle *bundle = [NSBundle mainBundle];
    if(bundle != nil)
    {
        NSString *moviePath = @"http://www.ebookfrenzy.com/ios_book/movie/movie.mov";
        if (moviePath)
        {
            mMovieURL = [NSURL fileURLWithPath:moviePath];
        }
    }
//    NSString *filePathStr = [[NSBundle mainBundle] pathForResource:@"movie" ofType:@"mov"];
//    NSURL *fileURL = [NSURL fileURLWithPath:filePathStr];
    self.moviePlayer = [[MPMoviePlayerController alloc]initWithContentURL:mMovieURL];
                       // [self.moviePlayer.view setFrame:CGRectMake(0, 0, 320, 320)];
    self.moviePlayer.movieSourceType = MPMovieSourceTypeStreaming;
    [self.moviePlayer prepareToPlay];
//    [self.view addSubview:self.moviePlayer.view];
[self presentMoviePlayerViewControllerAnimated:self.moviePlayer];
    [self.moviePlayer play];

    

    
    MPMoviePlayerViewController* mMoviePlayer = [[MPMoviePlayerViewController alloc] initWithContentURL:mMovieURL];
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(moviePlayBackDidFinish)
//                                                 name:MPMoviePlayerPlaybackDidFinishNotification
//                                               object:mMoviePlayer.moviePlayer];
//    mMoviePlayer.moviePlayer.controlStyle = MPMovieControlStyleNone;
//    [self.view addSubview:mMoviePlayer.moviePlayer.view];
//    mMoviePlayer.moviePlayer.scalingMode = MPMovieScalingModeFill;
//    [mMoviePlayer.moviePlayer setFullscreen:YES animated:NO];
//    [mMoviePlayer.moviePlayer play];
//    //[MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    NSLog(@"Change me %d",self.events.count);
//    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma  mark - Helper methods

- (void) getEventsFromParse{
    PFQuery *query = [PFQuery queryWithClassName:@"Event"];
       // [query setCachePolicy:kPFCachePolicyCacheElseNetwork];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %lu records.", (unsigned long)objects.count);
            for (NSDictionary *object in objects){
                Event *e = [[Event alloc]initWithDictionary:object];
                [self.events addObject:e];
            }
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            // #TODO move this in didLoad after figureing out semaphore logic got wait till model is loaded from parse
            [self customLoad];

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
- (void) getProjectsFromParse{
    PFQuery *query = [PFQuery queryWithClassName:@"Project"];
    //[query setCachePolicy:kPFCachePolicyCacheElseNetwork];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            [self.lock lock];
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %lu records.", (unsigned long)objects.count);
            for (NSDictionary *object in objects){
                Project *e = [[Project alloc]initWithDictionary:object];
                [self.projects addObject:e];
            }
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



-(void) customLoad{
    
//    EventDetailsViewController *e = [[EventDetailsViewController alloc]init];
//    e.selectedEvent = self.events[self.index++];
//    //
//    
//    [self presentViewController:e animated:NO completion:nil];
    UISwipeGestureRecognizer* swipeUpGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeUpFrom:)];
    swipeUpGestureRecognizer.direction = UISwipeGestureRecognizerDirectionUp;
    
    [self.view addGestureRecognizer:swipeUpGestureRecognizer];
    
}

- (void) handleSwipeUpFrom:(UIGestureRecognizer*)recognizer {
    NSLog(@"Change me");
    EventDetailsViewController *e = [[EventDetailsViewController alloc]init];
    e.selectedEvent = self.events[self.index++];
    
    UISwipeGestureRecognizer* swipeUpGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeUpFrom:)];
    swipeUpGestureRecognizer.direction = UISwipeGestureRecognizerDirectionUp;

    [e.view addGestureRecognizer:swipeUpGestureRecognizer];

    
    e.modalPresentationStyle = UIModalPresentationCustom;
    e.transitioningDelegate = self;
    

    [self presentViewController:e animated:YES completion:nil];

}



- (IBAction)onTap:(id)sender {
    
    EventDetailsViewController *e = [[EventDetailsViewController alloc]init];
    e.selectedEvent = self.events[self.index++];
    e.events = self.events;
//    if (self.index == 5)
//        self.index = 0;
//    e.modalPresentationStyle = UIModalPresentationCustom;
//    e.transitioningDelegate = self;
//    
//    UISwipeGestureRecognizer* swipeUpGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeUpFrom:)];
//    swipeUpGestureRecognizer.direction = UISwipeGestureRecognizerDirectionUp;
//    
//    [e.view addGestureRecognizer:swipeUpGestureRecognizer];
//
//    UIScreenEdgePanGestureRecognizer *gestureRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeUpFrom:)];
//    gestureRecognizer.edges = UIRectEdgeBottom;
//    [e.view addGestureRecognizer:gestureRecognizer];

    
    [self presentViewController:e animated:YES completion:nil];
}




@end
